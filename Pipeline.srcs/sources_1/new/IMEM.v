module IMEM (
	input		[7:0]	pc,
	input				reset,
	input				clk,

	output	reg	[31:0]	instruction_out
);

	reg [7:0]	memory [0:1023];
	
	initial begin
	   memory[0] = 8'h01; //add t2 t1 t0
	   memory[1] = 8'h28;
	   memory[2] = 8'h50;
	   memory[3] = 8'h20;
	   
	   memory[4] = 8'h01; //add t7 t5 zero
	   memory[5] = 8'hA0;
	   memory[6] = 8'h78;
	   memory[7] = 8'h20;
	   
	   memory[8] = 8'h02; //add s2 s3 zero
	   memory[9] = 8'h60;
	   memory[10] = 8'h90;
	   memory[11] = 8'h20;
	   
	   memory[12] = 8'h02; //xor s4 s5 s1
	   memory[13] = 8'hB1;
	   memory[14] = 8'hA0;
	   memory[15] = 8'h26;

       memory[16] = 8'h00; //add t4, zero, t3
       memory[17] = 8'h0b;
       memory[18] = 8'h60;
       memory[19] = 8'h20;
	   
	   // 2 stalls
       memory[20] = 8'h0; 
       memory[21] = 8'h0;
       memory[22] = 8'h0;
       memory[23] = 8'h0;       
       memory[24] = 8'h0; 
       memory[25] = 8'h0;
       memory[26] = 8'h0;
       memory[27] = 8'h0;       
       
       memory[28] = 8'h00; //add t4, zero, t4
       memory[29] = 8'h0c;
       memory[30] = 8'h60;
       memory[31] = 8'h20;

	   // 4 stalls       
	   memory[32] = 8'h0;
       memory[33] = 8'h0;
       memory[34] = 8'h0;
       memory[35] = 8'h0;
       memory[36] = 8'h0; 
       memory[37] = 8'h0;
       memory[38] = 8'h0;
       memory[39] = 8'h0;       
       memory[40] = 8'h0; 
       memory[41] = 8'h0;
       memory[42] = 8'h0;
       memory[43] = 8'h0;       
       memory[44] = 8'h0; 
       memory[45] = 8'h0;
       memory[46] = 8'h0;
       memory[47] = 8'h0;

	   memory[48] = 8'h02; //add t8 s7 t4
       memory[49] = 8'hEC;
       memory[50] = 8'hC0;
       memory[51] = 8'h20;     
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