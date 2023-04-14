module IMEM(
	input	[7:0]	pc,

	output reg	[31:0]	instruction_out
);
//<= 2^8 instructions 
	reg 	[7:0]	memory [0:1023];
	initial begin
	   memory[0] = 8'h01;
	   memory[1] = 8'h28;
	   memory[2] = 8'h50;
	   memory[3] = 8'h20;
	end
	
	always @(pc) begin
		instruction_out[31:24] = memory[pc];
		instruction_out[23:16] = memory[pc + 1];
		instruction_out[15:8] = memory[pc + 2];
		instruction_out[7:0] = memory[pc + 3];
	end
endmodule