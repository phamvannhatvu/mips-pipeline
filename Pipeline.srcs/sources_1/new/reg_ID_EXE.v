module reg_ID_EXE (
	input		[4:0]	rs_address_in,
	input		[4:0]	rt_address_in,
	input		[4:0]	rd_address_in,
	input		[4:0]	shamt_in,
	input		[5:0]	funct_in,
	input		[4:0]	write_register_in,
	input		[31:0]	rs_value_in,
	input		[31:0]	rt_value_in,
	input		[31:0]	immediate_in,
	input		[13:0]	control_in,
	input		[7:0]	pc_calculated_in,
	input		[7:0]	pc_in,
	input				excep_enable,
	input				clk,
	input				reset,

	output	reg	[4:0]	rs_address_out,
	output	reg	[4:0]	rt_address_out,
	output	reg	[4:0]	rd_address_out,
	output	reg	[4:0]	shamt_out,
	output	reg	[5:0]	funct_out,
	output	reg	[4:0]	write_register_out,
	output	reg	[31:0]	rs_value_out,
	output	reg	[31:0]	rt_value_out,
	output	reg	[31:0]	immediate_out,
	output	reg			jump_control_out,
	output	reg			branch_control_out,
	output	reg	[3:0]	mem_control_out,
	output	reg	[2:0]	alu_op_control_out,
	output	reg			alu_src_control_out,
	output	reg			regdst_control_out,
	output 	reg			excep_control_out,
	output	reg	[1:0]	wb_control_out,
	output	reg	[7:0]	pc_calculated_out,
	output	reg [7:0]	pc_out
);

	always @(posedge clk or posedge reset) begin
		if (reset || excep_enable) begin
			rs_address_out		<= 0;
			rt_address_out		<= 0;
			rd_address_out		<= 0;
			shamt_out			<= 0;
			funct_out			<= 0;
			write_register_out	<= 0;
			rs_value_out		<= 0;
			rt_value_out		<= 0;
			immediate_out		<= 0;
			jump_control_out	<= 0;
			branch_control_out	<= 0;
			mem_control_out		<= 0;
			alu_op_control_out	<= 0;
			alu_src_control_out	<= 0;
			regdst_control_out	<= 0;
			excep_control_out	<= 0;
			wb_control_out		<= 0;
			pc_calculated_out	<= 0;
			pc_out				<= 0;
		end else begin
			rs_address_out		<= rs_address_in;
			rt_address_out		<= rt_address_in;
			rd_address_out		<= rd_address_in;
			shamt_out			<= shamt_in;
			funct_out			<= funct_in;
			write_register_out	<= write_register_in;
			rs_value_out		<= rs_value_in;
			rt_value_out		<= rt_value_in;
			immediate_out		<= immediate_in;
			jump_control_out	<= control_in[13];
			branch_control_out	<= control_in[12];
			mem_control_out		<= control_in[11:8];
			alu_op_control_out	<= control_in[7:5];
			alu_src_control_out	<= control_in[4];
			regdst_control_out	<= control_in[3];
			excep_control_out	<= control_in[2];
			wb_control_out		<= control_in[1:0];
			pc_calculated_out	<= pc_calculated_in;
			pc_out				<= pc_in;
		end
	end

endmodule