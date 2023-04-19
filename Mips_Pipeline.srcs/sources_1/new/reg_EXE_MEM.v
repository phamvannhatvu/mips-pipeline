module reg_EXE_MEM (
	input 	[2:0]	wb_control_in,
	input	[4:0]	mem_control_in,

	input	[4:0]	write_register_in,
	input	[31:0]	alu_result_in,
	input	[7:0]	alu_status,
	input	[7:0]	branch_address_in,
	input 	[31:0]	rt_value_in,
	input			clk,
	input			reset,
	
	output reg	        branch_control_out,
	output reg 			mem_read_control_out,
	output reg 			mem_write_control_out,
	output reg	[2:0]	wb_control_out,
	output reg  		alu_zero,

	output reg	[7:0]	branch_address_out,
	output reg	[31:0]	write_data,
	output reg	[4:0]	write_register_out,
	output reg	[31:0]	alu_result_out
);

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			branch_control_out		<= 0;
			mem_read_control_out 	<= 0;
			mem_write_control_out 	<= 0;
			wb_control_out			<= 0;
			alu_zero				<= 0;
			
			branch_address_out 		<= 0;
			write_data				<= 0;
			write_register_out		<= 0;
			alu_result_out			<= 0;
		end else begin
			branch_control_out		<= mem_control_in[2];
			mem_read_control_out 	<= mem_control_in[1];
			mem_write_control_out 	<= mem_control_in[0];
			wb_control_out			<= wb_control_in;
			alu_zero 				<= alu_status[7];
			
			branch_address_out 		<= branch_address_in;
			write_data				<= rt_value_in;
			write_register_out		<= write_register_in;
			alu_result_out			<= alu_result_in;
		end
	end
endmodule