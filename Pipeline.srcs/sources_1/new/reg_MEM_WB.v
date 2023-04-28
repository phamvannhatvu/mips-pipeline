module reg_MEM_WB (
	input				reg_write_control_in,
	input		[31:0]	wb_data_in,
	input		[4:0]	write_register_in,
	input   			excep_control_in,
	input				reset,
	input				clk,
	
	output	reg			reg_write_control_out,
	output	reg	[31:0]	wb_data_out,
	output	reg	[4:0]	write_register_out
);

	// Exception

	always @(posedge reset or posedge clk) begin
		if (reset) begin
			reg_write_control_out	<= 0;
			wb_data_out				<= 0;
			write_register_out		<= 0;
		end else begin
			reg_write_control_out	<= reg_write_control_in;
			wb_data_out				<= wb_data_in;
			write_register_out		<= write_register_in;
		end
	end
	
endmodule