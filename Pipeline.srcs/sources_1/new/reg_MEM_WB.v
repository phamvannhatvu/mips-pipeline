module reg_MEM_WB (
	input		[1:0]	wb_control_in,
	input		[31:0]	data_from_dmem_in,
	input		[31:0]	alu_result_in,
	input		[4:0]	write_register_in,
	input   			excep_control_in,
	input				reset,
	input				clk,
	
	output	reg			reg_write_control_out,
	output	reg			mem2reg_control_out,
	output	reg	[31:0]	data_from_dmem_out,
	output	reg	[31:0]	alu_result_out,
	output	reg	[4:0]	write_register_out,
    output  reg			excep_control_out
);

	// Exception

	always @(posedge reset or posedge clk) begin
		if (reset) begin
			reg_write_control_out	<= 0;
			mem2reg_control_out		<= 0;
			data_from_dmem_out		<= 0;
			alu_result_out			<= 0;
			write_register_out		<= 0;
		end else begin
			reg_write_control_out	<= wb_control_in[0];
			mem2reg_control_out		<= wb_control_in[1];
			data_from_dmem_out		<= data_from_dmem_in;
			alu_result_out			<= alu_result_in;
			write_register_out		<= write_register_in;
		end
	end
	
endmodule