module IMEM(
	input	[7:0]	pc,
	input			reset,
	input           clk,
	output reg	[31:0]	instruction_out
);
//<= 2^8 instructions 
	reg 	[7:0]	memory [0:1023];
	initial begin
              memory[0] = 8'h01; //add t2 t1 t0
              memory[1] = 8'h28;
              memory[2] = 8'h50;
              memory[3] = 8'h20;
              
              memory[4] = 8'h01; //sub t5 t3 t4
              memory[5] = 8'h6C;
              memory[6] = 8'h68;
              memory[7] = 8'h22;
              
              memory[8] = 8'h02; //mult s3 s4
              memory[9] = 8'h74;
              memory[10] = 8'h40;
              memory[11] = 8'h18;
              
              memory[12] = 8'h38; //xori s0 zero 13
              memory[13] = 8'h10;
              memory[14] = 8'h00;
              memory[15] = 8'h0d;

              memory[16] = 8'h03; //div t8 s1
              memory[17] = 8'h11;
              memory[18] = 8'h00;
              memory[19] = 8'h1A;

              memory[20] = 8'h02; //and t7 s6 t2
              memory[21] = 8'hCA;
              memory[22] = 8'h78;
              memory[23] = 8'h24;

              memory[24] = 8'h02; //or t6 s3 s5 
              memory[25] = 8'h75;
              memory[26] = 8'h70;
              memory[27] = 8'h25; 

              memory[28] = 8'hAE; //sw t2 3(s0)
              memory[29] = 8'h0A;
              memory[30] = 8'h00;
              memory[31] = 8'h03;

              memory[32] = 8'h02; //xor t2 s6 t2
              memory[33] = 8'hCA;
              memory[34] = 8'h50;
              memory[35] = 8'h26;
    
              memory[36] = 8'h02; //nor s4 s4 s4 
              memory[37] = 8'h94;
              memory[38] = 8'hA0;
              memory[39] = 8'h27;

              memory[40] = 8'h01; //slt s7 t7 t5 
              memory[41] = 8'hED;
              memory[42] = 8'hB8;
              memory[43] = 8'h2A;

              memory[44] = 8'h20; //addi s3 zero 14 
              memory[45] = 8'h13;
              memory[46] = 8'h00;
              memory[47] = 8'h0E;

              memory[48] = 8'h00; //sll t6 t6 3
              memory[49] = 8'h0E;
              memory[50] = 8'h70;
              memory[51] = 8'hC0;
              
       //       //000100 11001 01100 0000 0000 0000 0110
       //       //0001 0011 0010 1100 0000 0000 0000 0110
       //       //beq t9 t4 6
       //       memory[52] = 8'h13;
       //       memory[53] = 8'h2C;
       //       memory[54] = 8'h00;
       //       memory[55] = 8'h06;

              memory[52] = 8'h00; //srl t1 t5 3
              memory[53] = 8'h0D;
              memory[54] = 8'h48;
              memory[55] = 8'hC2;

              memory[56] = 8'h00; //sra s6 t5 3 
              memory[57] = 8'h0D;
              memory[58] = 8'hB0;
              memory[59] = 8'hC3;

              memory[60] = 8'h82; //lb t0 3(s3) 
              memory[61] = 8'h68;
              memory[62] = 8'h00;
              memory[63] = 8'h03;

              memory[64] = 8'h22; //addi s7 s7 -3 
              memory[65] = 8'hF7;
              memory[66] = 8'hFF;
              memory[67] = 8'hFD;  
              
              memory[68] = 8'h34; //ori t9, zero, 13
              memory[69] = 8'h19;
              memory[70] = 8'h00;
              memory[71] = 8'h0D;
              
              memory[72] = 8'h31; //andi t7, t2, 0xAB21
              memory[73] = 8'h4F;
              memory[74] = 8'hAB;
              memory[75] = 8'h21;

              memory[76] = 8'h35; //ori t1 t6 0xDEAD
              memory[77] = 8'hC9;
              memory[78] = 8'hDE;
              memory[79] = 8'hAD;

              memory[80] = 8'h3A; //xori s0 s0 0xF415
              memory[81] = 8'h10;
              memory[82] = 8'hF4;
              memory[83] = 8'h15;
              
              memory[84] = 8'h8F; //lw t8 3(t9)
              memory[85] = 8'h38;
              memory[86] = 8'h00;
              memory[87] = 8'h03;
              
       //       //add t5 t4 zero
       //       memory[80] = 8'h01;
       //       memory[81] = 8'h80;
       //       memory[82] = 8'h68;
       //       memory[83] = 8'h20;
              
       //       //add t5 t4 zero
       //       memory[84] = 8'h01;
       //       memory[85] = 8'h80;
       //       memory[86] = 8'h68;
       //       memory[87] = 8'h20;
              
       //       //j -21 = 0000 1011 1111 1111 1111 1111 1110 1011
       //       memory[88] = 8'h0B;
       //       memory[89] = 8'hFF;
       //       memory[90] = 8'hFF;
       //       memory[91] = 8'hEB;
              
       //	   // 1 stall
       //       memory[92] = 8'h0; 
       //       memory[93] = 8'h0;
       //       memory[94] = 8'h0;
       //       memory[95] = 8'h0;       
	end
	
	always @(negedge clk or posedge reset) begin
		if (reset) begin
			instruction_out <= 0;
		end else begin
			instruction_out[31:24] <= memory[pc];
			instruction_out[23:16] <= memory[pc + 1];
			instruction_out[15:8] <= memory[pc + 2];
			instruction_out[7:0] <= memory[pc + 3];
		end
	end
endmodule