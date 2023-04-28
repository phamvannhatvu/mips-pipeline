module IMEM (
	input		[7:0]	pc,
	input				reset,
	input				clk,

	output	reg	[31:0]	instruction_out
);

	reg [7:0]	memory [0:1023];
	
	always @(negedge clk or posedge reset) begin
		if (reset) begin		
			{memory[0], memory[1], memory[2], memory[3]} <= 32'h01ee4020;		// add $t0, $t7, $t6
			{memory[4], memory[5], memory[6], memory[7]} <= 32'h21090005;		// addi $t1, $t0, 5
			{memory[8], memory[9], memory[10], memory[11]} <= 32'h016b001a;		// div $t3, $t3
			{memory[12], memory[13], memory[14], memory[15]} <= 32'h00005812;	// mflo $t3
			{memory[16], memory[17], memory[18], memory[19]} <= 32'h816c0000;	// lh $t4, 1($t3)
			{memory[20], memory[21], memory[22], memory[23]} <= 32'h0160001a;	// div $t3, $zero
			{memory[24], memory[25], memory[26], memory[27]} <= 32'h012c5822;	// sub $t3, $t1, $t4
			{memory[28], memory[29], memory[30], memory[31]} <= 32'h01ab6022;	// sub $t4, $t5, $t3
			instruction_out			<= 0;
		end else begin
			instruction_out[31:24]	<= memory[pc];
			instruction_out[23:16]	<= memory[pc + 1];
			instruction_out[15:8]	<= memory[pc + 2];
			instruction_out[7:0]	<= memory[pc + 3];
		end
	end
	
endmodule