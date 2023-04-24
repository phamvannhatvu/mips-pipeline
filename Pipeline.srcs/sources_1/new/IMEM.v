module IMEM (
	input		[7:0]	pc,
	input				reset,
	input				clk,

	output	reg	[31:0]	instruction_out
);

	reg [7:0]	memory [0:1023];
	
	// initial begin
	//    memory[0] = 8'h01;	// add t0 t1 t2
	//    memory[1] = 8'h2a;
	//    memory[2] = 8'h40;
	//    memory[3] = 8'h20;

	//    memory[4] = 8'h12;	// beq s0, s1, 2
	//    memory[5] = 8'h11;
	//    memory[6] = 8'h00;
	//    memory[7] = 8'h02;
	// //    memory[4] = 8'h08;	// j 2
	// //    memory[5] = 8'h00;
	// //    memory[6] = 8'h00;
	// //    memory[7] = 8'h02;

	//    memory[8] = 8'h01;	// sub t1 t2 t3
	//    memory[9] = 8'h4b;
	//    memory[10] = 8'h48;
	//    memory[11] = 8'h22;

	//    memory[12] = 8'h01;	// or t2 t3 t4
	//    memory[13] = 8'h6c;
	//    memory[14] = 8'h50;
	//    memory[15] = 8'h25;

	//    memory[16] = 8'h01;	// xor t3 t4 t5
	//    memory[17] = 8'h8d;
	//    memory[18] = 8'h58;
	//    memory[19] = 8'h26;

	//    memory[20] = 8'h01;	// nor t4 t5 t6
	//    memory[21] = 8'hae;
	//    memory[22] = 8'h60;
	//    memory[23] = 8'h27;
	// end

	initial begin
		memory[0] = 8'h8c;	// lw s2 4(0)
		memory[1] = 8'h12;
		memory[2] = 8'h00;
		memory[3] = 8'h04;

		memory[4] = 8'h01;	// add t0 t1 s2
		memory[5] = 8'h32;
		memory[6] = 8'h40;
		memory[7] = 8'h20;
		// memory[4] = 8'h02;	// add t0 s2 t1
		// memory[5] = 8'h49;
		// memory[6] = 8'h40;
		// memory[7] = 8'h20;

		memory[8] = 8'h01;	// sub t1 t2 t3
		memory[9] = 8'h4b;
		memory[10] = 8'h48;
		memory[11] = 8'h22;

		memory[12] = 8'h01;	// or t2 t3 t4
		memory[13] = 8'h6c;
		memory[14] = 8'h50;
		memory[15] = 8'h25;
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