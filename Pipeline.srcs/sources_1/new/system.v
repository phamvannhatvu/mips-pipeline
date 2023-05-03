module system (
	input				SYS_clk,
	input				SYS_reset,
	input				SYS_load,
	input		[7:0]	SYS_pc_val,
	input		[3:0]	SYS_output_sel,

	output		[26:0]	SYS_leds
);

	// IF_stage
	wire [31:0]	if_instruction;
	wire [7:0]	if_pc;
	wire [7:0]	id_pc;
	wire [7:0]	exe_pc_calculated;
	wire [7:0]	exception_pc;
	wire		hz_control_pc;
	wire 		SYS_excep;

	IF_stage IF_stage (
		.SYS_pc_val(SYS_pc_val),
		.pc_from_id(id_pc),
		.pc_from_exe(exe_pc_calculated),
		.epc(exception_pc),
		.SYS_load(SYS_load),
		.pc_hazard_control(hz_control_pc),
		.excep_enable(SYS_excep),
		.clk(SYS_clk),
		.reset(SYS_reset),

		.instruction_out(if_instruction),
		.pc_out(if_pc)
	);

	// reg_IF_ID
	wire [5:0]	id_opcode;
	wire [4:0] 	id_rs;
	wire [4:0] 	id_rt;
	wire [4:0] 	id_rd;
	wire [4:0]	id_shamt;
	wire [5:0]	id_funct;
	wire [15:0]	id_immediate;
	wire [25:0] id_jump_address;

	reg_IF_ID reg_IF_ID (
		.instruction(if_instruction), 
		.pc_in(if_pc),
		.excep_enable(SYS_excep),
		.clk(SYS_clk),
		.reset(SYS_reset),

		.opcode(id_opcode),
		.rs(id_rs),
		.rt(id_rt),
		.rd(id_rd),
		.shamt(id_shamt),
		.funct(id_funct),
		.immediate(id_immediate),
		.jump_address(id_jump_address),
		.pc_out(id_pc)
	);

	// ID_stage
	wire [4:0] 	id_write_register;
	wire [31:0] id_value_rs;
	wire [31:0] id_value_rt;
	wire [31:0] id_extended_immediate;
	wire [13:0] id_control;
	wire [1:0]	id_mem_write_control;
	wire		id_regdst_control;
	wire [7:0]	id_calculated_pc;
	
	wire [4:0]	mem_write_register;
	wire [31:0]	mem_data;
	wire		mem_reg_write;

	wire		hz_control_signal;

	ID_stage ID_stage (
		.opcode(id_opcode),
		.address_rs(id_rs),
		.address_rt(id_rt),
		.address_rd(id_rd),
		.immediate(id_immediate),
		.jump_immediate(id_jump_address),
		.address_write_in(mem_write_register),
		.data_write(mem_data),
		.reg_write(mem_reg_write),
		.hz_control_signal(hz_control_signal),
		.pc_in(id_pc),
		.clk(SYS_clk),
		.reset(SYS_reset),

		.address_write_out(id_write_register),
		.value_rs(id_value_rs),
		.value_rt(id_value_rt),
		.extended_immediate(id_extended_immediate),
		.control_signal(id_control),
		.mem_write_control_out(id_mem_write_control),
		.regdst_control_out(id_regdst_control),
		.pc_calculated(id_calculated_pc)
	);

	// reg_ID_EXE
	wire [4:0]	exe_rs;
	wire [4:0]	exe_rt;
	wire [4:0]	exe_rd;
	wire [4:0]	exe_shamt;
	wire [5:0]	exe_funct;
	wire [4:0] 	exe_write_register;
	wire [31:0]	exe_value_rs;
	wire [31:0]	exe_value_rt_in;
	wire [31:0]	exe_immediate;
	wire		exe_jump_control;
	wire		exe_branch_control;
	wire [3:0]	exe_mem_control;
	wire [2:0]	exe_alu_op;
	wire 		exe_alu_src;
	wire		exe_regdst_control;
	wire 		exe_excep;
	wire [1:0]	exe_wb_control;
	wire [7:0]	exe_pc;

	reg_ID_EXE reg_ID_EXE (
		.rs_address_in(id_rs),
		.rt_address_in(id_rt),
		.rd_address_in(id_rd),
		.shamt_in(id_shamt),
		.funct_in(id_funct),
		.write_register_in(id_write_register),
		.rs_value_in(id_value_rs),
		.rt_value_in(id_value_rt),
		.immediate_in(id_extended_immediate),
		.control_in(id_control),
		.pc_calculated_in(id_calculated_pc),
		.pc_in(id_pc),
		.excep_enable(SYS_excep),
		.clk(SYS_clk),
		.reset(SYS_reset),

		.rs_address_out(exe_rs),
		.rt_address_out(exe_rt),
		.rd_address_out(exe_rd),
		.shamt_out(exe_shamt),
		.funct_out(exe_funct),
		.write_register_out(exe_write_register),
		.rs_value_out(exe_value_rs),
		.rt_value_out(exe_value_rt_in),
		.immediate_out(exe_immediate),
		.jump_control_out(exe_jump_control),
		.branch_control_out(exe_branch_control),
		.mem_control_out(exe_mem_control),
		.alu_op_control_out(exe_alu_op),
		.alu_src_control_out(exe_alu_src),
		.regdst_control_out(exe_regdst_control),
		.excep_control_out(exe_excep),
		.wb_control_out(exe_wb_control),
		.pc_calculated_out(exe_pc_calculated),
		.pc_out(exe_pc)
	);

	// EXE_stage
	wire [31:0]	exe_alu_result;
	wire [31:0]	exe_value_rt_out;
	wire [7:0] 	exe_alu_status;
	wire		exe_comparator;
	wire [1:0]	exe_wb_new_control;
	wire		alu_control_excep;
	wire		alu_excep;
	wire [31:0] mem_alu_result;
	wire [31:0]	wb_data;
	wire [1:0]	fw_control_0;
	wire [1:0]	fw_control_1;
	wire [1:0]	fw_control_write_address;

	wire [31:0]	exe_operand_0;
	wire [31:0]	exe_operand_1;
	wire [31:0]	exe_alu_out;
	wire [31:0]	exe_hilo_out;
	wire [4:0]	exe_alu_control;

	EXE_stage EXE_stage (
		.rs_address_in(exe_rs),
		.rd_address_in(exe_rd),
		.shamt_in(exe_shamt),
		.funct_in(exe_funct),
		.rs_value_in(exe_value_rs),
		.rt_value_in(exe_value_rt_in),
		.immediate(exe_immediate),
		.mem_control(exe_mem_control),
		.alu_op(exe_alu_op),
		.alu_src(exe_alu_src),
		.wb_control_in(exe_wb_control),
		.prev_alu_result(mem_alu_result),
		.prev_wb_result(wb_data),
		.operand_0_forward_control(fw_control_0),
		.operand_1_forward_control(fw_control_1),
		.write_address_forward_control(fw_control_write_address),
		.excep_enable(SYS_excep),
		.clk(SYS_clk),
		.reset(SYS_reset),

		.alu_result(exe_alu_result),
		.rt_value_out(exe_value_rt_out),
		.alu_status(exe_alu_status),
		.comparator_out(exe_comparator),
		.wb_control_out(exe_wb_new_control),
		.alu_control_excep(alu_control_excep),
		.alu_excep(alu_excep),
		.operand_0(exe_operand_0),
		.operand_1(exe_operand_1),
		.alu_out(exe_alu_out),
		.data_hilo_out(exe_hilo_out),
		.alu_control_out(exe_alu_control)
	);

	// reg_EXE_MEM
	wire [31:0] mem_write_data;
	wire [1:0]	mem_mem_read;
	wire [1:0]	mem_mem_write;
	wire		mem_mem2reg;

	reg_EXE_MEM reg_EXE_MEM (
		.write_register_in(exe_write_register),
		.alu_result_in(exe_alu_result),
		.rt_value_in(exe_value_rt_out),
		.mem_control_in(exe_mem_control),
		.wb_control_in(exe_wb_new_control),
		.excep_enable(SYS_excep),
		.clk(SYS_clk),
		.reset(SYS_reset),

		.write_register_out(mem_write_register),
		.alu_result_out(mem_alu_result),
		.write_data(mem_write_data),
		.mem_read_control_out(mem_mem_read),
		.mem_write_control_out(mem_mem_write),
		.mem2reg_control_out(mem_mem2reg),
		.reg_write_control_out(mem_reg_write)
	);

	// MEM_stage
	wire [31:0]	mem_data_read;

	MEM_stage MEM_stage (
		.mem_address(mem_alu_result[7:0]),
		.alu_result(mem_alu_result),
		.write_data(mem_write_data),
		.mem_read(mem_mem_read),
		.mem_write(mem_mem_write),
		.mem2reg(mem_mem2reg),
		.clk(SYS_clk),
		.reset(SYS_reset),

		.wb_data(mem_data),
		.data_read_out(mem_data_read)
	);

	// reg_MEM_WB
	wire		wb_reg_write;
	wire [4:0]	wb_write_register;

	reg_MEM_WB reg_MEM_WB (
		.write_register_in(mem_write_register),
		.wb_data_in(mem_data),
		.reg_write_control_in(mem_reg_write),
		.excep_enable(SYS_excep),
		.clk(SYS_clk),
		.reset(SYS_reset),

		.write_register_out(wb_write_register),
		.wb_data_out(wb_data),
		.reg_write_control_out(wb_reg_write)
	);

	// Forward_unit
	forward_unit forward_unit (
		.id_exe_address_rs(exe_rs),
		.id_exe_address_rt(exe_rt),
		.id_exe_regdst_control(exe_regdst_control),
		.mem_write_control(exe_mem_control[1:0]),
		.exe_mem_address_write(mem_write_register),
		.exe_mem_reg_write(mem_reg_write),
		.mem_wb_address_write(wb_write_register),
		.mem_wb_reg_write(wb_reg_write),

		.operand_0_control(fw_control_0),
		.operand_1_control(fw_control_1),
		.write_address_control(fw_control_write_address)
	);

	// Hazard_detection
	hazard_detection hazard_detection (
		.address_write(exe_write_register),
		.comparator_in(exe_comparator),
		.jump_control_in(exe_jump_control),
		.branch_control_in(exe_branch_control),
		.mem_read_control_in(exe_mem_control[3:2]),
		.next_address_rs(id_rs),
		.next_address_rt(id_rt),
		.next_mem_write_control_in(id_mem_write_control),
		.next_regdst_control_in(id_regdst_control),

		.pc_control_out(hz_control_pc),
		.control_signal(hz_control_signal)
	);

	// Exception_handler
	exception_handler exception_handler (
		.exe_excep_in(exe_excep),
		.alu_excep_in(alu_excep),
		.alu_control_excep_in(alu_control_excep),
		.pc_in(exe_pc),
		.reset(SYS_reset),
		.clk(SYS_clk),

		.pc_out(exception_pc),
		.excep_out(SYS_excep)
	);

	// System_control
	system_control system_control (
		.SYS_output_sel(SYS_output_sel),
		.imem_instruction(if_instruction),
		.reg_rs_value(id_value_rs),
		.reg_rt_value(id_value_rt),
		.id_pc_calculated(id_calculated_pc),
		.alu_operand_0(exe_operand_0),
		.alu_operand_1(exe_operand_1),
		.alu_out(exe_alu_out),
		.hilo_reg_out(exe_hilo_out),
		.exe_out(exe_alu_result),
		.exe_write_data(exe_value_rt_out),
		.alu_status(exe_alu_status),
		.dmem_data(mem_data_read),
		.control(id_control),
		.alu_control(exe_alu_control),
		.pc(if_pc),
		.epc(exception_pc),

		.SYS_led(SYS_leds)
	);

endmodule