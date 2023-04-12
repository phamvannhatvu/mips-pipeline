`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/05/2023 08:27:16 PM
// Design Name: 
// Module Name: system
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module system(
	input			SYS_clk,
	input 			SYS_reset,
	input 			SYS_load,
	input	[7:0]	SYS_pc_val,
	input 	[2:0] 	SYS_output_sel,
	output	[26:0]	SYS_leds
);

	wire           clk = SYS_clk;// & ~exception_handler.exception_output; 
	wire  [10:0]   control_signal;        
	wire  [31:0]   IMEM_instruction;
	
	wire  [5:0]    reg_IF_ID_opcode;
	wire  [4:0]    reg_IF_ID_rs;
    wire  [4:0]    reg_IF_ID_rt;
    wire  [4:0]    reg_IF_ID_rd;
    wire  [7:0]    reg_IF_ID_PC_out;
    wire  [15:0]   reg_IF_ID_immediate;
    
    
    wire  [31:0]   REG_value_rs;
    wire  [31:0]   REG_value_rt;
    
    wire           reg_ID_EXE_branch_control_out;
    wire           reg_ID_EXE_mem_read_control_out;
    wire           reg_ID_EXE_mem_write_control_out;
    wire           reg_ID_EXE_reg_write_control_out;
    wire           reg_ID_EXE_mem_to_reg_control_out;
    wire  [4:0]    reg_ID_EXE_write_register;
    wire  [31:0]   reg_ID_EXE_alu_result;
    wire  [7:0]    reg_ID_EXE_alu_status;
    wire  [7:0]    reg_ID_EXE_branch_address;
    wire  [31:0]   reg_ID_EXE_rt_value_out;
    
    wire           reg_EXE_MEM_reg_write_control_out;
    wire           reg_EXE_MEM_mem_to_reg_control_out;
    wire  [31:0]   reg_EXE_MEM_alu_result_out;
    wire  [4:0]    reg_EXE_MEM_write_address;
    
    wire           reg_MEM_WB_write_register_out;
    wire           reg_MEM_WB_reg_write_control_out;
    wire  [31:0]   reg_MEM_WB_write_data;
	
	IMEM ins_memory (.IMEM_PC(SYS_pc_val), 
	               .IMEM_reset(SYS_reset),
	               .IMEM_clk(clk),
	               .IMEM_instruction(IMEM_instruction));
	
	reg_IF_ID reg_IF_ID0  (.reg_IF_ID_PC_in(SYS_pc_val + 1), 
				.reg_IF_ID_instruction(IMEM_instruction),
				.reg_IF_ID_clk(clk),
				.reg_IF_ID_reset(SYS_reset),
				.reg_IF_ID_opcode(reg_IF_ID_opcode),
				.reg_IF_ID_rs(reg_IF_ID_rs),
				.reg_IF_ID_rt(reg_IF_ID_rt));
	
	control control0 (.opcode(reg_IF_ID_opcode),
	                   .control_signal(control_signal));
	
	REG reg0 (.REG_address_rs(reg_IF_ID_rs),
				.REG_address_rt(reg_IF_ID_rt),
				.REG_address_write(reg_MEM_WB0.reg_MEM_WB_write_register_out),
				.REG_write_control(reg_MEM_WB0.reg_MEM_WB_reg_write_control_out),
				.REG_write_data(reg_MEM_WB0.reg_MEM_WB_write_data),
				.REG_clk(clk),
				.REG_reset(SYS_reset),
				.REG_value_rs(REG_value_rs),
				.REG_value_rt(REG_value_rt));
	
	reg_ID_EXE reg_ID_EXE0 (.reg_ID_EXE_reg_dst_control_in(control_signal[0]),
							.reg_ID_EXE_alu_op_control_in(control_signal[5:4]),
							.reg_ID_EXE_alu_src_control_in(control_signal[2]),
							.reg_ID_EXE_branch_control_in(control_signal[9]),
							.reg_ID_EXE_mem_read_control_in(control_signal[8]),
							.reg_ID_EXE_mem_write_control_in(control_signal[7]),
							.reg_ID_EXE_reg_write_control_in(control_signal[1]),
							.reg_ID_EXE_mem_to_reg_control_in(control_signal[6]),
							.reg_ID_EXE_rs_value_in(REG_value_rs),
							.reg_ID_EXE_rt_value_in(REG_value_rt),
							.reg_ID_EXE_PC_in(reg_IF_ID_PC_out),
							.reg_ID_EXE_immediate(reg_IF_ID_immediate),
							.reg_ID_EXE_rt(reg_IF_ID_rt),
							.reg_ID_EXE_rd(reg_IF_ID_rd),
							.reg_ID_EXE_clk(clk),
							.reg_ID_EXE_reset(SYS_reset),
							.reg_ID_EXE_branch_control_out(reg_ID_EXE_branch_control_out),
                            .reg_ID_EXE_mem_read_control_out(reg_ID_EXE_mem_read_control_out),
                            .reg_ID_EXE_mem_write_control_out(reg_ID_EXE_mem_write_control_out),
                            .reg_ID_EXE_reg_write_control_out(reg_ID_EXE_reg_write_control_out),
                            .reg_ID_EXE_mem_to_reg_control_out(reg_ID_EXE_mem_to_reg_control_out),
                            .reg_ID_EXE_write_register(reg_ID_EXE_write_register),
                            .reg_ID_EXE_alu_result(reg_ID_EXE_alu_result),
                            .reg_ID_EXE_alu_status(reg_ID_EXE_alu_status),
                            .reg_ID_EXE_branch_address(reg_ID_EXE_branch_address),
                            .reg_ID_EXE_rt_value_out(reg_ID_EXE_rt_value_out));
							
	reg_EXE_MEM reg_EXE_MEM0 (.reg_EXE_MEM_branch_control_in(reg_ID_EXE_branch_control_out),
								.reg_EXE_MEM_mem_read_control_in(reg_ID_EXE_mem_read_control_out),
								.reg_EXE_MEM_mem_write_control_in(reg_ID_EXE_mem_write_control_out),
								.reg_EXE_MEM_reg_write_control_in(reg_ID_EXE_reg_write_control_out),
								.reg_EXE_MEM_mem_to_reg_control_in(reg_ID_EXE_mem_to_reg_control_out),
								.reg_EXE_MEM_write_register_in(reg_ID_EXE_write_register),
								.reg_EXE_MEM_alu_result_in(reg_ID_EXE_alu_result),
								.reg_EXE_MEM_alu_status(reg_ID_EXE_alu_status),
								.reg_EXE_MEM_branch_address_in(reg_ID_EXE_branch_address),
								.reg_EXE_MEM_rt_value_in(reg_ID_EXE_rt_value_out),
								.reg_EXE_MEM_clk(clk),
								.reg_EXE_MEM_reset(SYS_reset),
								.reg_EXE_MEM_reg_write_control_out(reg_EXE_MEM_reg_write_control_out),
                                .reg_EXE_MEM_mem_to_reg_control_out(reg_EXE_MEM_mem_to_reg_control_out),
                                .reg_EXE_MEM_alu_result_out(reg_EXE_MEM_alu_result_out),
                                .reg_EXE_MEM_write_address(reg_EXE_MEM_write_address));
								
	reg_MEM_WB reg_MEM_WB0 (.reg_MEM_WB_reg_write_control_in(reg_EXE_MEM0.reg_EXE_MEM_reg_write_control_out),
							.reg_MEM_WB_mem_to_reg_control_in(reg_EXE_MEM0.reg_EXE_MEM_mem_to_reg_control_out),
							.reg_MEM_WB_read_data(0),
							.reg_MEM_WB_alu_result(reg_EXE_MEM0.reg_EXE_MEM_alu_result_out),
							.reg_MEM_WB_write_register_in(reg_EXE_MEM0.reg_EXE_MEM_write_address),
							.reg_MEM_WB_clk(clk),
							.reg_MEM_WB_reset(SYS_reset),
							.reg_MEM_WB_write_register_out(reg_MEM_WB_write_register_out),
                            .reg_MEM_WB_reg_write_control_out(reg_MEM_WB_reg_write_control_out),
                            .reg_MEM_WB_write_data(reg_MEM_WB_write_data));		
                            
    assign SYS_leds = {reg_IF_ID_rs[4:0], reg_IF_ID_rt[4:0]};					
endmodule
