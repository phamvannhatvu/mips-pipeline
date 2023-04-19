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
	   reg_file[8] = 4; //t0
	   reg_file[9] = 5; //t1
	   reg_file[11] = 3; //t3
	   reg_file[10] = 4; //t2
       reg_file[13] = 24; //t5
       reg_file[15] = 9; //t7
       reg_file[18] = 5; //s2
       reg_file[19] = 4; //s3
       reg_file[16] = 2; //s0
       reg_file[21] = 2; //s5
       reg_file[17] = 9; //s1
       reg_file[22] = 3; //s6
       reg_file[0] = 0; //zero
       reg_file[25] = 12; //t9
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