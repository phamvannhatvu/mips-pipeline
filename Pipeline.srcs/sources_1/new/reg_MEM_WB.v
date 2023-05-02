module reg_MEM_WB (
	input		[4:0]	write_register_in,
	input		[31:0]	wb_data_in,
	input				reg_write_control_in,
	input   			excep_enable,
	input				reset,
	input				clk,
	
	output	reg	[4:0]	write_register_out,
	output	reg	[31:0]	wb_data_out,
	output	reg			reg_write_control_out
);

	always @(posedge reset or posedge clk) begin
		if (reset || excep_enable) begin
			write_register_out		<= 0;
			wb_data_out				<= 0;
			reg_write_control_out	<= 0;
		end else begin
			write_register_out		<= write_register_in;
			wb_data_out				<= wb_data_in;
			reg_write_control_out	<= reg_write_control_in;
		end
	end
	
endmodule