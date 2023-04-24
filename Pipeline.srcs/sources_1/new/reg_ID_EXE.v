module reg_ID_EXE (
	input		[31:0]	rs_value_in,
	input		[31:0]	rt_value_in,
	input		[31:0]	immediate_in,
	input		[4:0]	write_register_in,
	input		[13:0]	control_in,
	input				comparator_in,
	input		[7:0]	pc_in,
	input		[7:0]	pc_calculated_in,
	input				clk,
	input				reset,
	
	output	reg			jump_control_out,
	output	reg			branch_control_out,
	output	reg			comparator_out,
	output	reg	[7:0]	pc_out,
	output	reg	[7:0]	pc_calculated_out,
	output	reg	[3:0]	mem_control_out,
	output	reg	[2:0]	alu_op_control_out,
	output	reg			alu_src_control_out,
	output	reg			excep_control_out,
	output	reg	[1:0]	wb_control_out,
	output	reg	[31:0]	rs_value_out,
	output	reg	[31:0]	rt_value_out,
	output	reg	[31:0]	immediate_out,
	output	reg	[4:0]	write_register_out
);

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			jump_control_out	<= 0;
			branch_control_out	<= 0;
			comparator_out		<= 0;
			pc_out				<= 0;
			pc_calculated_out	<= 0;
			mem_control_out		<= 0;
			alu_op_control_out	<= 0;
			alu_src_control_out	<= 0;
			excep_control_out	<= 0;
			wb_control_out		<= 0;
			rs_value_out		<= 0;
			rt_value_out		<= 0;
			immediate_out		<= 0;
			write_register_out	<= 0;
		end else begin
			jump_control_out	<= control_in[13];
			branch_control_out	<= control_in[12];
			comparator_out		<= comparator_in;
			pc_out				<= pc_in;
			pc_calculated_out	<= pc_calculated_in;
			mem_control_out		<= control_in[11:8];
			alu_op_control_out	<= control_in[7:5];
			alu_src_control_out	<= control_in[4];
			excep_control_out	<= control_in[2];
			wb_control_out		<= control_in[1:0];
			rs_value_out		<= rs_value_in;
			rt_value_out		<= rt_value_in;
			immediate_out		<= immediate_in;
			write_register_out	<= write_register_in;
		end
	end

endmodule