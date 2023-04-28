module system (
	input				SYS_clk,
	input				SYS_reset,
	input				SYS_load,
	input		[7:0]	SYS_pc_val,
	input		[2:0]	SYS_output_sel,

	output		[26:0]	SYS_leds
);

	wire		clk = SYS_clk; // & ~exception_handler.exception_output;

	// exception_handler
	wire [7:0]	exception_pc;
	wire 		SYS_excep;
	wire		alu_excep;
	wire		alu_control_excep;
	wire 		exe_excep;	
	wire [7:0]	exe_pc;

	exception_handler exception_handler (
		.alu_excep_in(alu_excep),
		.alu_control_excep_in(alu_control_excep),
		.exe_excep_in(exe_excep),
		.pc_in(exe_pc),
		.reset(SYS_reset),
		.clk(clk),

		.pc_out(exception_pc),
		.excep_out(SYS_excep)
	);

	// IF_stage
	wire [7:0]	if_pc;
	wire [31:0]	if_instruction;

	wire [7:0]	id_pc;
	wire [7:0]	exe_pc_calculated;
	wire		hz_control_pc;

	IF_stage IF_stage (
		.pc_from_id(id_pc),
		.pc_from_exe(exe_pc_calculated),
		.pc_hazard_control(hz_control_pc),
		.clk(clk),
		.reset(SYS_reset),
		.excep_control_in(SYS_excep),

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

	reg_IF_ID reg_IF_ID (
		.pc_in(if_pc),
		.instruction(if_instruction), 
		.clk(clk),
		.excep_enable(SYS_excep),
		.reset(reset),

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
	wire [7:0]	id_calculated_pc;
	wire		id_regdst_control;
	
	wire		mem_reg_write;
	wire [4:0]	mem_write_register;
	wire [31:0]	mem_data;

	wire		hz_control_signal;

	ID_stage ID_stage (
		.clk(clk),
		.reset(SYS_reset),
		.data_write(mem_data),
		.reg_write(mem_reg_write),
		.address_write_in(mem_write_register),
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
		.pc_calculated(id_calculated_pc),
		.regdst_control_out(id_regdst_control)
	);

	// reg_ID_EXE
	wire 		exe_alu_src;
	wire [2:0]	exe_alu_op;
	wire [3:0]	exe_mem_control;
	wire [1:0]	exe_wb_control;
	wire [31:0]	exe_value_rs;
	wire [31:0]	exe_value_rt;
	wire [31:0]	exe_immediate;
	wire [4:0] 	exe_write_register;
	wire		exe_jump_control;
	wire		exe_branch_control;
	wire [4:0]	exe_rs;
	wire [4:0]	exe_rt;
	wire		exe_regdst_control;

	reg_ID_EXE reg_ID_EXE (
		.rs_value_in(id_value_rs),
		.rt_value_in(id_value_rt),
		.immediate_in(id_extended_immediate),
		.write_register_in(id_write_register),
		.rs_address_in(id_rs),
		.rt_address_in(id_rt),
		.control_in(id_control),
		.pc_calculated_in(id_calculated_pc),
		.pc_in(id_pc),
		.clk(clk),
		.reset(SYS_reset),
		.excep_enable(SYS_excep),

		.alu_src_control_out(exe_alu_src),
		.alu_op_control_out(exe_alu_op),
		.mem_control_out(exe_mem_control),
		.wb_control_out(exe_wb_control),
		.excep_control_out(exe_excep),
		.rs_value_out(exe_value_rs),
		.rt_value_out(exe_value_rt),
		.immediate_out(exe_immediate),
		.write_register_out(exe_write_register),
		.rs_address_out(exe_rs),
		.rt_address_out(exe_rt),
		.jump_control_out(exe_jump_control),
		.branch_control_out(exe_branch_control),
		.pc_calculated_out(exe_pc_calculated),
		.pc_out(exe_pc),
		.regdst_control_out(exe_regdst_control)
	);

	// EXE_stage
	wire [31:0]	exe_alu_result;
	wire [7:0] 	exe_alu_status;
	wire		exe_reg_write_control;
	wire		exe_comparator;
	wire [1:0]	exe_wb_new_control;

	wire [31:0] mem_alu_result;
	wire [31:0]	wb_data;
	wire [1:0]	fw_control_0;
	wire [1:0]	fw_control_1;

	wire [31:0]	wb_data_write;

	EXE_stage EXE_stage (
		.immediate(exe_immediate),
		.rs_value(exe_value_rs),
		.rt_value(exe_value_rt),
		.alu_src(exe_alu_src),
		.alu_op(exe_alu_op),
		.mem_control(exe_mem_control),
		.wb_control_in(exe_wb_control),
		.excep_control_in(SYS_excep),
		.prev_alu_result(mem_alu_result),
		.prev_wb_result(wb_data),
		.operand_0_forward_control(fw_control_0),
		.operand_1_forward_control(fw_control_1),
		.clk(clk),
		.reset(SYS_reset),

		.alu_result(exe_alu_result),
		.alu_status(exe_alu_status),
		.comparator_out(exe_comparator),
		.wb_control_out(exe_wb_new_control),
		.alu_control_excep(alu_control_excep),
		.alu_excep(alu_excep)
	);

	// reg_EXE_MEM
	wire [1:0]	mem_mem_read;
	wire [1:0]	mem_mem_write;
	wire		mem_mem2reg;
	wire [31:0] mem_write_data;

	reg_EXE_MEM reg_EXE_MEM (
		.wb_control_in(exe_wb_new_control),
		.mem_control_in(exe_mem_control),
		.write_register_in(exe_write_register),
		.alu_result_in(exe_alu_result),
		.rt_value_in(exe_value_rt),
		.clk(clk),
		.excep_enable(SYS_excep),
		.reset(SYS_reset),

		.mem_read_control_out(mem_mem_read),
		.mem_write_control_out(mem_mem_write),
		.mem2reg_control_out(mem_mem2reg),
		.reg_write_control_out(mem_reg_write),
		.write_data(mem_write_data),
		.write_register_out(mem_write_register),
		.alu_result_out(mem_alu_result)
	);

	// MEM_stage
	MEM_stage MEM_stage (
		.mem_read(mem_mem_read),
		.mem_write(mem_mem_write),
		.mem_address(mem_alu_result),
		.write_data(mem_write_data),
		.alu_result(mem_alu_result),
		.mem2reg(mem_mem2reg),
		.clk(clk),
		.reset(SYS_reset),

		.wb_data(mem_data)
	);

	// reg_MEM_WB
	wire		wb_reg_write;
	wire [4:0]	wb_write_register;

	reg_MEM_WB reg_MEM_WB (
		.reg_write_control_in(mem_reg_write),
		.wb_data_in(mem_data),
		.write_register_in(mem_write_register),
		.clk(clk),
		.reset(SYS_reset),

		.reg_write_control_out(wb_reg_write),
		.wb_data_out(wb_data),
		.write_register_out(wb_write_register)
	);

	// Forward_unit
	forward_unit forward_unit (
		.exe_mem_reg_write(mem_reg_write),
		.exe_mem_address_write(mem_write_register),
		.mem_wb_reg_write(wb_reg_write),
		.mem_wb_address_write(wb_write_register),
		.id_exe_address_rs(exe_rs),
		.id_exe_address_rt(exe_rt),
		.id_exe_regdst_control(exe_regdst_control),

		.operand_0_control(fw_control_0),
		.operand_1_control(fw_control_1)
	);

	// Hazard_detection
	hazard_detection hazard_detection (
		.jump_control_in(exe_jump_control),
		.branch_control_in(exe_branch_control),
		.mem_read_control_in(exe_mem_control[3:2]),
		.comparator_in(exe_comparator),
		.address_write(exe_write_register),
		.next_regdst_control_in(id_regdst_control),
		.next_address_rs(id_rs),
		.next_address_rt(id_rt),

		.pc_control_out(hz_control_pc),
		.control_signal(hz_control_signal)
	);

	assign SYS_leds = exe_alu_result;

endmodule