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

	wire           	clk = SYS_clk;// & ~exception_handler.exception_output; 

	//IF_stage
	wire 	[31:0]  instruction;
	wire	[7:0]	next_pc_calulated;
	wire    [7:0]	next_pc;
	wire	[7:0]	if_pc;
	
	mux8bit pc_sel(
		//input
		.in0(next_pc_calulated),
		.in1(SYS_pc_val),
		.sel(SYS_reset),
		
		//output
		.out(next_pc)
	);

	IF_stage IF_stage(
		//input
		.pc_in(next_pc),
		.clk(clk),

		//output
		.instruction_out(instruction),
		.pc_out(if_pc)
	);

	reg_IF_ID reg_IF_ID(
		//input
		.pc_in(if_pc),
		.instruction(instruction), 
		.clk(clk),
		.reset(SYS_reset),

		//output
		.rs(id_rs),
		.rt(id_rt),
		.rd(id_rd),
		.opcode(id_opcode),
		.shamt(id_shamt),
		.funct(id_funct),
		.pc_out(id_pc),
		.immediate(id_immediate),
		.jump_address(id_jump_address)
	);

	//ID_stage
	wire [4:0] 	id_rs;
	wire [4:0] 	id_rd;
	wire [4:0] 	id_rt;
	wire [5:0]	id_opcode;
	wire [4:0]	id_shamt;
	wire [5:0]	id_funct;
	wire [7:0]	id_pc;
	wire [15:0]	id_immediate;
	wire [26:0] id_jump_address;

	wire [10:0] id_control;
	wire [31:0] id_extended_immediate;
	wire [31:0] id_value_rs;
	wire [31:0] id_value_rt;

	ID_stage ID_stage(
		//input
		.clk(clk),
		.reset(SYS_reset),

		.data_write(wb_data_write),
		.reg_write(wb_reg_write),
		.address_write(wb_write_register),
		
		.address_rs(id_rs),
		.address_rt(id_rt),
		.opcode(id_opcode),
		.immediate(id_immediate),

		//output
		.extended_immediate(id_extended_immediate),
		.value_rs(id_value_rs),
		.value_rt(id_value_rt),
		.control_signal(id_control)
	);

	reg_ID_EXE reg_ID_EXE(
		//input
		.rs_value_in(id_value_rs),
		.rt_value_in(id_value_rt),
		.pc_in(id_pc),
		.immediate_in(id_extended_immediate),
		.rt_in(id_rt),
		.rd_in(id_rd),

		.control_in(id_control),
		
		.clk(clk),
		.reset(SYS_reset),

		//output
		.alu_src_control_out(exe_alu_src),
		.alu_op_control_out(exe_alu_op),
		.reg_dst_control_out(exe_reg_dst),

		.mem_control_out(exe_mem_control),
		.wb_control_out(exe_wb_control),

		.rs_value_out(exe_value_rs),
		.rt_value_out(exe_value_rt),
		.immediate_out(exe_immediate),
		.pc_out(exe_pc),
		.rt_out(exe_rt),
		.rd_out(exe_rd)
	);

	//EXE_stage
	wire 		exe_alu_src;
	wire [1:0]	exe_alu_op;
	wire 		exe_reg_dst;
	
	wire [2:0]	exe_mem_control;
	wire [1:0]	exe_wb_control;

	wire [7:0]	exe_pc;
	wire [31:0]	exe_immediate;
	wire [31:0]	exe_value_rs;
	wire [31:0]	exe_value_rt;
	wire [4:0]	exe_rt;
	wire [4:0]  exe_rd;

	wire [4:0] 	exe_write_register;
	wire [31:0]	exe_alu_result;
	wire [7:0] 	exe_alu_status;
	wire [7:0] 	exe_branch_address;

	EXE_stage EXE_stage(
		//input
		.immediate(exe_immediate),
		.pc(exe_pc),
		.rs_value(exe_value_rs),
		.alu_src(exe_alu_src),
		.alu_op(exe_alu_op),
		.reg_dst(exe_reg_dst),
		.rt_value(exe_value_rt),
		.rt(exe_rt),
		.rd(exe_rd),

		//output
		.branch_address(exe_branch_address),
		.alu_result(exe_alu_result),
		.alu_status(exe_alu_status),
		.write_register(exe_write_register)
	);

	reg_EXE_MEM reg_EXE_MEM(
		//input
		.wb_control_in(exe_wb_control),
		.mem_control_in(exe_mem_control),

		.write_register_in(exe_write_register),
		.alu_result_in(exe_alu_result),
		.alu_status(exe_alu_status),
		.branch_address_in(exe_branch_address),
		.rt_value_in(exe_value_rt),
		.clk(clk),
		.reset(SYS_reset),

		//output
		.branch_control_out(mem_branch_control),
		.mem_read_control_out(mem_mem_read),
		.mem_write_control_out(mem_mem_write),
		.wb_control_out(mem_wb_control),
		.alu_zero(mem_alu_zero),

		.branch_address_out(mem_branch_address),
		.write_data(mem_write_data),
		.write_register_out(mem_write_register),
		.alu_result_out(mem_alu_result)
	);

	//MEM_stage
	wire [1:0] 	mem_wb_control;
	wire 		mem_branch_control;
	wire		mem_alu_zero;
	wire 		mem_mem_read;
	wire 		mem_mem_write;

	wire [31:0] mem_alu_result;
	wire [4:0]	mem_write_register;
	wire [7:0] 	mem_branch_address;
	wire [31:0] mem_write_data;
	wire [31:0] mem_data_read;
	MEM_stage MEM_stage(
		//input
		.branch_control(mem_branch_control),
		.alu_zero(mem_alu_zero),
		.mem_read(mem_mem_read),
		.mem_write(mem_mem_write),
		.mem_address(mem_alu_result),
		.write_data(mem_write_data),
		
		.clk(clk),
		.reset(SYS_reset),

		//output
		.data_read_out(mem_data_read),
		.branch_pc_sel(branch_pc_sel)
	);

	reg_MEM_WB reg_MEM_WB(
		//input
		.wb_control_in(mem_wb_control),
		.data_from_dmem_in(mem_data_read),
		.alu_result_in(mem_alu_result),
		.write_register_in(mem_write_register),
		.clk(clk),
		.reset(SYS_reset),

		//output
		.reg_write_control_out(wb_reg_write),
		.mem2reg_control_out(wb_mem2reg),
		.data_from_dmem_out(wb_data_from_dmem),
		.alu_result_out(wb_alu_result),
		.write_register_out(wb_write_register)
	);

	//WB_stage
	wire 	    wb_reg_write;
	wire		wb_mem2reg;
	wire [31:0]	wb_data_write;
	wire [31:0] wb_alu_result;
	wire [31:0] wb_data_from_dmem;
	wire [4:0]	wb_write_register;

	wire [31:0] wb_data_read;

	WB_stage WB_stage(
		//input
		.data_from_dmem(wb_data_from_dmem),
		.alu_result(wb_alu_result),
		.mem2reg(wb_mem2reg),

		//output
		.data_write2reg(wb_data_write)
	);

	//PC update
	wire 		branch_pc_sel;
	wire		jump_pc_sel;
	wire [7:0]	branch_mux_out;
	wire [7:0]	jump_pc_address;

	mux8bit branch_pc_mux(
		//input
		.in0(if_pc + 4),
		.in1(mem_branch_address),
		.sel(branch_pc_sel),

		//output
		.out(branch_mux_out)
	);

	assign jump_pc_sel = id_control[10];

	shift_left_two jump_shifter(
		//input
		.in(id_jump_address),

		//ouput
		.out(jump_pc_address)
	);

	mux8bit jump_pc_mux(
		//input
		.in0(branch_mux_out),
		.in1(jump_pc_address),
		.sel(jump_pc_sel),

		//output
		.out(next_pc_calulated)
	);
endmodule
