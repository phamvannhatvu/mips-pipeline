module system (
	input				SYS_clk,
	input				SYS_reset,
	input				SYS_load,
	input		[7:0]	SYS_pc_val,
	input		[2:0]	SYS_output_sel,

	output		[26:0]	SYS_leds
);

	wire		clk = SYS_clk; // & ~exception_handler.exception_output;

	// IF_stage
	wire [7:0]	if_pc;
	wire [31:0]	if_instruction;

	wire [7:0]	pc_next;

	IF_stage IF_stage (
		.pc_in(pc_next),
		.clk(clk),
		.reset(SYS_reset),

		.instruction_out(if_instruction),
		.pc_out(if_pc)
	);

	// reg_IF_ID
	wire [4:0] 	id_rs;
	wire [4:0] 	id_rt;
	wire [4:0] 	id_rd;
	wire [5:0]	id_opcode;
	wire [4:0]	id_shamt;
	wire [5:0]	id_funct;
	wire [15:0]	id_immediate;
	wire [25:0] id_jump_address;
	wire [7:0]	id_pc;

	reg_IF_ID reg_IF_ID (
		.pc_in(if_pc),
		.instruction(if_instruction), 
		.clk(clk),
		.reset(SYS_reset),

		.rs(id_rs),
		.rt(id_rt),
		.rd(id_rd),
		.opcode(id_opcode),
		.shamt(id_shamt),
		.funct(id_funct),
		.immediate(id_immediate),
		.jump_address(id_jump_address),
		.pc_out(id_pc)
	);

	// ID_stage
	wire [31:0] id_extended_immediate;
	wire [31:0] id_value_rs;
	wire [31:0] id_value_rt;
	wire [13:0] id_control;
	wire [4:0] 	id_write_register;
	wire [7:0]	id_branch_address;
	wire		id_comparator;
	wire [7:0]	id_calculated_pc;
	wire		id_regdst_control;

	wire 	    wb_reg_write;
	wire [4:0]	wb_write_register;
	wire [31:0]	wb_data_write;

	wire		hz_control_signal;

	ID_stage ID_stage (
		.clk(clk),
		.reset(SYS_reset),
		.data_write(wb_data_write),
		.reg_write(wb_reg_write),
		.address_write_in(wb_write_register),
		.opcode(id_opcode),
		.address_rs(id_rs),
		.address_rt(id_rt),
		.address_rd(id_rd),
		.immediate(id_immediate),
		.jump_immediate(id_jump_address),
		.pc_in(id_pc),
		.hz_control_signal(hz_control_signal),

		.extended_immediate(id_extended_immediate),
		.value_rs(id_value_rs),
		.value_rt(id_value_rt),
		.control_signal(id_control),
		.address_write_out(id_write_register),
		.comparator_out(id_comparator),
		.pc_calculated(id_calculated_pc),
		.regdst_control_out(id_regdst_control)
	);

	// reg_ID_EXE
	wire 		exe_alu_src;
	wire [2:0]	exe_alu_op;
	wire [3:0]	exe_mem_control;
	wire [1:0]	exe_wb_control;
	wire 		exe_excep_control_in;
	wire [31:0]	exe_value_rs;
	wire [31:0]	exe_value_rt;
	wire [31:0]	exe_immediate;
	wire [4:0] 	exe_write_register;

	wire		exe_jump_control;
	wire		exe_branch_control;
	wire		exe_comparator;
	wire [7:0]	exe_pc;
	wire [7:0]	exe_pc_calculated;

	reg_ID_EXE reg_ID_EXE (
		.rs_value_in(id_value_rs),
		.rt_value_in(id_value_rt),
		.immediate_in(id_extended_immediate),
		.write_register_in(id_write_register),
		.control_in(id_control),
		.comparator_in(id_comparator),
		.pc_in(id_pc),
		.pc_calculated_in(id_calculated_pc),
		.clk(clk),
		.reset(SYS_reset),

		.alu_src_control_out(exe_alu_src),
		.alu_op_control_out(exe_alu_op),
		.mem_control_out(exe_mem_control),
		.wb_control_out(exe_wb_control),
		.excep_control_out(exe_excep_control_in),
		.rs_value_out(exe_value_rs),
		.rt_value_out(exe_value_rt),
		.immediate_out(exe_immediate),
		.write_register_out(exe_write_register),
		.jump_control_out(exe_jump_control),
		.branch_control_out(exe_branch_control),
		.comparator_out(exe_comparator),
		.pc_out(exe_pc),
		.pc_calculated_out(exe_pc_calculated)
	);

	// EXE_stage
	wire [31:0]	exe_alu_result;
	wire [7:0] 	exe_alu_status;
	wire		exe_excep_control_out;

	EXE_stage EXE_stage (
		.immediate(exe_immediate),
		.rs_value(exe_value_rs),
		.rt_value(exe_value_rt),
		.alu_src(exe_alu_src),
		.alu_op(exe_alu_op),
		.excep_control_in(exe_excep_control_in),

		.alu_result(exe_alu_result),
		.alu_status(exe_alu_status),
		.excep_control_out(exe_excep_control_out)
	);

	// reg_EXE_MEM
	wire [1:0]	mem_mem_read;
	wire [1:0]	mem_mem_write;
	wire [1:0] 	mem_wb_control;
	wire [31:0] mem_write_data;
	wire [4:0]	mem_write_register;
	wire [31:0] mem_alu_result;
	wire 		mem_excep_control;

	reg_EXE_MEM reg_EXE_MEM (
		.wb_control_in(exe_wb_control),
		.mem_control_in(exe_mem_control),
		.write_register_in(exe_write_register),
		.alu_result_in(exe_alu_result),
		.rt_value_in(exe_value_rt),
		.excep_control_in(exe_excep_control_out),
		.clk(clk),
		.reset(SYS_reset),

		.mem_read_control_out(mem_mem_read),
		.mem_write_control_out(mem_mem_write),
		.wb_control_out(mem_wb_control),
		.write_data(mem_write_data),
		.write_register_out(mem_write_register),
		.alu_result_out(mem_alu_result),
		.excep_control_out(mem_excep_control)
	);

	// MEM_stage
	wire [31:0] mem_data_read;

	MEM_stage MEM_stage (
		.mem_read(mem_mem_read),
		.mem_write(mem_mem_write),
		.mem_address(mem_alu_result),
		.write_data(mem_write_data),
		.clk(clk),
		.reset(SYS_reset),

		.data_read_out(mem_data_read)
	);

	// reg_MEM_WB
	wire 		wb_mem2reg;
	wire [31:0] wb_data_from_dmem;
	wire [31:0] wb_alu_result;
	wire		wb_excep_control;

	reg_MEM_WB reg_MEM_WB (
		.wb_control_in(mem_wb_control),
		.data_from_dmem_in(mem_data_read),
		.alu_result_in(mem_alu_result),
		.write_register_in(mem_write_register),
		.excep_control_in(mem_excep_control),
		.clk(clk),
		.reset(SYS_reset),

		.reg_write_control_out(wb_reg_write),
		.mem2reg_control_out(wb_mem2reg),
		.data_from_dmem_out(wb_data_from_dmem),
		.alu_result_out(wb_alu_result),
		.write_register_out(wb_write_register),
		.excep_control_out(wb_excep_control)
	);

	// WB_stage
	WB_stage WB_stage (
		.data_from_dmem(wb_data_from_dmem),
		.alu_result(wb_alu_result),
		.mem2reg(wb_mem2reg),

		.data_write2reg(wb_data_write)
	);

	// Hazard_detection
	wire		hz_control_pc;
	wire [7:0]	hz_pc_next;
	hazard_detection hazard_detection (
		.jump_control_in(exe_jump_control),
		.branch_control_in(exe_branch_control),
		.mem_read_control_in(exe_mem_control[3:2]),
		.comparator_in(exe_comparator),
		.pc_in(exe_pc),
		.calculated_pc_in(exe_pc_calculated),
		.address_write(exe_write_register),
		.next_regdst_control_in(id_regdst_control),
		.next_address_rs(id_rs),
		.next_address_rt(id_rt),

		.pc_control_out(hz_control_pc),
		.pc_next(hz_pc_next),
		.control_signal(hz_control_signal)
	);

	// PC update
	mux_2_to_1 #(8) pc_next_mux (
		.in0(id_pc),
		.in1(hz_pc_next),
		.sel(hz_control_pc),

		.out(pc_next)
	);

	// wire		pc_branch_sel = id_control[12];
	// wire [7:0]	pc_branch_mux_out;
	// mux_2_to_1 #(8) branch_pc_mux (
	// 	.in0(if_pc),
	// 	.in1(id_branch_address),
	// 	.sel(pc_branch_sel),

	// 	.out(pc_branch_mux_out)
	// );

	// wire		pc_jump_sel = id_control[13];
	// wire [7:0]	pc_jump_address;
	// wire [7:0]	shifted_jump_immediate = id_jump_address << 2;
	// assign pc_jump_address = id_pc + shifted_jump_immediate;
	// mux_2_to_1 #(8) jump_pc_mux (
	// 	.in0(pc_branch_mux_out),
	// 	.in1(pc_jump_address),
	// 	.sel(pc_jump_sel),

	// 	.out(pc_calulated)
	// );

	assign SYS_leds = exe_alu_result;

endmodule