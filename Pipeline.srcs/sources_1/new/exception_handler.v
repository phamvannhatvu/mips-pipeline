module exception_handler (
	input				exe_excep_in,
	input				alu_excep_in,
	input				alu_control_excep_in,
	input		[7:0]	pc_in,
	input				clk,
	input				reset,

	output				excep_out,
	output	reg	[7:0]	pc_out
);

reg exception;
assign excep_out = exception;

always @(posedge reset or negedge clk) begin
	if (reset) begin
		exception		<= 0;
		pc_out			<= 0;
	end else if (exception == 1'b0) begin
		if (exe_excep_in == 1'b1 || alu_excep_in == 1'b1 || alu_control_excep_in == 1'b1) begin
			exception	<= 1;
			pc_out		<= pc_in - 4;
		end
	end
end

endmodule