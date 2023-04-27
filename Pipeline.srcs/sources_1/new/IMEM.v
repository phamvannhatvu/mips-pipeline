module IMEM (
	input		[7:0]	pc,
	input				reset,
	input				clk,

	output	reg	[31:0]	instruction_out
);

	reg [7:0]	memory [0:1023];
	
	initial begin
		{memory[0], memory[1], memory[2], memory[3]} = 32'h000940c0;		// sll t0 t1 3
		{memory[4], memory[5], memory[6], memory[7]} = 32'h00084882;		// srl t1 t0 2
		// {memory[8], memory[9], memory[10], memory[11]} = 32'h00085083;		// sra t2 t0 2
		// {memory[12], memory[13], memory[14], memory[15]} = 32'h000940c0;	// sll t0 t1 3
	end
	
	always @(negedge clk or posedge reset) begin
		if (reset) begin
			instruction_out			<= 0;
		end else begin
			instruction_out[31:24]	<= memory[pc];
			instruction_out[23:16]	<= memory[pc + 1];
			instruction_out[15:8]	<= memory[pc + 2];
			instruction_out[7:0]	<= memory[pc + 3];
		end
	end
	
endmodule