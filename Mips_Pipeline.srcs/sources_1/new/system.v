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

	//Wire declarations
	wire           	clk = SYS_clk;// & ~exception_handler.exception_output; 
	
	//IF_stage
	wire 	[31:0]  instruction;
	wire	[7:0]	next_pc_calulated;
	wire    [7:0]	next_pc;
	wire	[7:0]	if_pc;
	
	//ID_stage
	wire [4:0] 	id_rs;
	wire [4:0] 	id_rd;
	wire [4:0] 	id_rt;
	wire [5:0]	id_opcode;
	wire [4:0]	id_shamt;
	wire [5:0]	id_funct;
	wire [15:0]	id_immediate;
	wire [26:0] id_jump_address;
	wire [7:0]	id_pc;

	wire [13:0] id_control;
	wire [31:0] id_extended_immediate;
	wire [31:0] id_value_rs;
	wire [31:0] id_value_rt;
	wire [4:0] 	id_write_register;

	//EXE_stage
	wire [31:0]	exe_immediate;
	wire [31:0]	exe_value_rs;
	wire [31:0]	exe_value_rt;

	wire 		exe_alu_src;
	wire [2:0]	exe_alu_op;
	wire 		exe_excep_control_in;
	wire [3:0]	exe_mem_control;
	wire [1:0]	exe_wb_control_in;
	

	wire [4:0] 	exe_write_register;
	wire [31:0]	exe_alu_result;
	wire [7:0] 	exe_alu_status;
	wire		exe_excep_control_out;

	//MEM_stage
	wire [1:0] 	mem_wb_control;
	wire [1:0]	mem_mem_read;
	wire [1:0]	mem_mem_write;
	wire 		mem_excep_control;

	wire [31:0] mem_alu_result;
	wire [4:0]	mem_write_register;
	wire [31:0] mem_write_data;
	wire [31:0] mem_data_read;

	//WB_stage
	wire 	    wb_reg_write;
	wire 		wb_mem2reg;
	wire [31:0]	wb_data_write;
	wire [31:0] wb_alu_result;
	wire [31:0] wb_data_from_dmem;
	wire [4:0]	wb_write_register;
	wire		wb_excep_control;

	wire [31:0] wb_data_read;

	//PC_update
	wire 		branch_pc_sel;
	wire		jump_pc_sel;
	wire [7:0]	branch_mux_out;
	wire [7:0]	jump_pc_address;

	//Modules
	//IF_stage
	mux_2_to_1 #(8) pc_sel(
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
		.reset(SYS_reset),

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
	ID_stage ID_stage(
		//input
		.clk(clk),
		.reset(SYS_reset),

		.data_write(wb_data_write),
		.reg_write(wb_reg_write),
		.address_write_in(wb_write_register),
		
		.opcode(id_opcode),
		.address_rs(id_rs),
		.address_rt(id_rt),
		.immediate(id_immediate),
		.pc_in(id_pc),

		//output
		.extended_immediate(id_extended_immediate),
		.value_rs(id_value_rs),
		.value_rt(id_value_rt),
		.control_signal(id_control),
		.address_write_out(id_write_register)
	);

	reg_ID_EXE reg_ID_EXE(
		//input
		.rs_value_in(id_value_rs),
		.rt_value_in(id_value_rt),
		.immediate_in(id_extended_immediate),
		.write_register_in(id_write_register),

		.control_in(id_control),
		
		.clk(clk),
		.reset(SYS_reset),

		//output
		.alu_src_control_out(exe_alu_src),
		.alu_op_control_out(exe_alu_op),
		.mem_control_out(exe_mem_control),
		.wb_control_out(exe_wb_control),
		.excep_control_out(exe_excep_control_in),
		.rs_value_out(exe_value_rs),
		.rt_value_out(exe_value_rt),
		.immediate_out(exe_immediate),
		.write_register_out(exe_write_register)
	);

	//EXE_stage
	EXE_stage EXE_stage(
		//input
		.immediate(exe_immediate),
		.rs_value(exe_value_rs),
		.rt_value(exe_value_rt),
		.alu_src(exe_alu_src),
		.alu_op(exe_alu_op),
		.excep_control_in(exe_excep_control_in),

		//output
		.alu_result(exe_alu_result),
		.alu_status(exe_alu_status),
		.excep_control_out(exe_excep_control_out)
	);

	reg_EXE_MEM reg_EXE_MEM(
		//input
		.wb_control_in(exe_wb_control),
		.mem_control_in(exe_mem_control),

		.write_register_in(exe_write_register),
		.alu_result_in(exe_alu_result),
		.rt_value_in(exe_value_rt),
		.excep_control_in(exe_excep_control_out),
		.clk(clk),
		.reset(SYS_reset),

		//output
		.mem_read_control_out(mem_mem_read),
		.mem_write_control_out(mem_mem_write),
		.wb_control_out(mem_wb_control),

		.write_data(mem_write_data),
		.write_register_out(mem_write_register),
		.alu_result_out(mem_alu_result),
		.excep_control_out(mem_excep_control)
	);

	//MEM_stage
	MEM_stage MEM_stage(
		//input
		.mem_read(mem_mem_read),
		.mem_write(mem_mem_write),
		.mem_address(mem_alu_result),
		.write_data(mem_write_data),
		
		.clk(clk),
		.reset(SYS_reset),

		//output
		.data_read_out(mem_data_read)
	);

	reg_MEM_WB reg_MEM_WB(
		//input
		.wb_control_in(mem_wb_control),
		.data_from_dmem_in(mem_data_read),
		.alu_result_in(mem_alu_result),
		.write_register_in(mem_write_register),
		.excep_control_in(mem_excep_control),

		.clk(clk),
		.reset(SYS_reset),

		//output
		.reg_write_control_out(wb_reg_write),
		.mem2reg_control_out(wb_mem2reg),
		.data_from_dmem_out(wb_data_from_dmem),
		.alu_result_out(wb_alu_result),
		.write_register_out(wb_write_register),
		.excep_control_out(wb_excep_control)
	);

	//WB_stage
	WB_stage WB_stage(
		//input
		.data_from_dmem(wb_data_from_dmem),
		.alu_result(wb_alu_result),
		.mem2reg(wb_mem2reg),

		//output
		.data_write2reg(wb_data_write)
	);

	//PC update
	mux_2_to_1 #(8) branch_pc_mux(
		//input
		.in0(if_pc + 4),
		.in1(mem_branch_address),
		.sel(branch_pc_sel),

		//output
		.out(branch_mux_out)
	);

	assign jump_pc_sel = id_control[14];
	wire [7:0] shifted_jump_immediate;
	shift_left_two jump_shifter(
		//input
		.in(id_jump_address),

		//ouput
		.out(shifted_jump_immediate)
	);
	assign jump_pc_address = id_pc + 4 + shifted_jump_immediate;

	mux_2_to_1 #(8) jump_pc_mux(
		//input
		.in0(branch_mux_out),
		.in1(jump_pc_address),
		.sel(jump_pc_sel),

		//output
		.out(next_pc_calulated)
	);

	assign SYS_leds = exe_alu_result;
endmodule
