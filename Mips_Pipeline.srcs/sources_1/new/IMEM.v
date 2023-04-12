module IMEM(
	input	[7:0]	IMEM_PC,
	input			IMEM_clk,
	input			IMEM_reset,
	output reg	[31:0]	IMEM_instruction
);
//<= 2^8 instructions 
	reg 	[31:0]	IMEM_memory [0:255];
	initial begin
	   IMEM_memory[0] = 32'h01285020;
	end
	
	always @(posedge IMEM_clk or posedge IMEM_reset) begin
		if (IMEM_reset) begin
			IMEM_instruction	<= 0;
		end else if (IMEM_clk) begin
			IMEM_instruction 	<= IMEM_memory[IMEM_PC];
		end 
	end
endmodule