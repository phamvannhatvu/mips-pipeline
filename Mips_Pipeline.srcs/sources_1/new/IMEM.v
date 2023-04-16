module IMEM(
	input	[7:0]	pc,
	input			reset,
	output reg	[31:0]	instruction_out
);
//<= 2^8 instructions 
	reg 	[7:0]	memory [0:1023];
	initial begin
	   memory[0] = 8'h01; //add t2 t1 t0
	   memory[1] = 8'h28;
	   memory[2] = 8'h50;
	   memory[3] = 8'h20;
	   
//	   // 3 stalls
//	   memory[4] = 8'h0; 
//       memory[5] = 8'h0;
//       memory[6] = 8'h0;
//       memory[7] = 8'h0;	   
//       memory[8] = 8'h0; 
//       memory[9] = 8'h0;
//       memory[10] = 8'h0;
//       memory[11] = 8'h0;	   
//       memory[12] = 8'h0; 
//       memory[13] = 8'h0;
//       memory[14] = 8'h0;
//       memory[15] = 8'h0;
	   
	   memory[4] = 8'h01; //add t8 t5 t7
	   memory[5] = 8'hAF;
	   memory[6] = 8'hC0;
	   memory[7] = 8'h20;
	   
	   memory[8] = 8'h02; //add s3 s2 s0
	   memory[9] = 8'h50;
	   memory[10] = 8'h98;
	   memory[11] = 8'h20;
	   
	   memory[12] = 8'h02; //add s4 s5 s1
	   memory[13] = 8'hB1;
	   memory[14] = 8'hA0;
	   memory[15] = 8'h20;

	   memory[16] = 8'h01; //add t4 t3 t2
	   memory[17] = 8'h6A;
	   memory[18] = 8'h60;
	   memory[19] = 8'h20;
	end
	
	always @(pc or reset) begin
		if (reset) begin
			instruction_out = 0;
		end else begin
			instruction_out[31:24] = memory[pc];
			instruction_out[23:16] = memory[pc + 1];
			instruction_out[15:8] = memory[pc + 2];
			instruction_out[7:0] = memory[pc + 3];
		end
	end
endmodule