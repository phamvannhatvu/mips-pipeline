module reg_EXE_MEM (
	input		[4:0]	write_register_in,
	input		[31:0]	alu_result_in,
	input		[31:0]	rt_value_in,
	input		[3:0]	mem_control_in,
	input		[1:0]	wb_control_in,
	input				excep_enable,
	input				clk,
	input				reset,
	
	output	reg	[4:0]	write_register_out,
	output	reg	[31:0]	alu_result_out,
	output	reg	[31:0]	write_data,
	output	reg	[1:0]	mem_read_control_out,
	output	reg	[1:0]	mem_write_control_out,
	output	reg			mem2reg_control_out,
	output	reg			reg_write_control_out
);

	always @(posedge clk or posedge reset) begin
		if (reset || excep_enable) begin
			write_register_out		<= 0;
			alu_result_out			<= 0;
			write_data				<= 0;
			mem_read_control_out	<= 0;
			mem_write_control_out	<= 0;
			mem2reg_control_out		<= 0;
			reg_write_control_out	<= 0;
		end else begin
			write_register_out		<= write_register_in;
			alu_result_out			<= alu_result_in;
			write_data				<= rt_value_in;
			mem_read_control_out	<= mem_control_in[3:2];
			mem_write_control_out	<= mem_control_in[1:0];
			mem2reg_control_out		<= wb_control_in[1];
			reg_write_control_out	<= wb_control_in[0];
		end
	end
	
endmodule