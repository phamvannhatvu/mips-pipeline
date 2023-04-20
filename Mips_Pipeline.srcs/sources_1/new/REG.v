module REG (
	input 	    [4:0] 	address_rs,
	input 	    [4:0] 	address_rt,
	input 	    [4:0] 	address_write,
	input 		   	   	reg_write,
	input			   	clk,
	input			   	reset,
	input 	    [31:0] 	data_write,
	
	output reg	[31:0]	value_rs,
	output reg	[31:0]	value_rt
);
	reg 	[31:0]	reg_file [0:31];
	
	initial begin
	   //zero
	   reg_file[0] = 0;
	   
	   //t0-t7
	   reg_file[8] = 10;
       reg_file[9] = 11;
       reg_file[10] = 12;
       reg_file[11] = 13;
       reg_file[12] = 14;
       reg_file[13] = 15;
	   reg_file[14] = 16;
       reg_file[15] = 17;
       
       //s0-s7
 	   reg_file[16] = 20;
       reg_file[17] = 21;
       reg_file[18] = 22;
       reg_file[19] = 23;
       reg_file[20] = 24;
       reg_file[21] = 25;
       reg_file[22] = 26;
       reg_file[23] = 27;
       
       //t8-t9 
       reg_file[24] = 58;
       reg_file[25] = 59; 
	end
	
	always @(posedge clk or posedge reset or negedge clk) begin
		if (reset) begin
			value_rs <= 0;
			value_rt <= 0;
		end else if (clk) begin
			if (reg_write) begin
				reg_file[address_write] <= data_write;
			end
		end else begin
			value_rs <= reg_file[address_rs];
			value_rt <= reg_file[address_rt];
		end
	end
endmodule