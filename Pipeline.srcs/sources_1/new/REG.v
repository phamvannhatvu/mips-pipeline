module REG (
	input		[4:0]	address_rs,
	input		[4:0]	address_rt,
	input		[4:0]	address_write,
	input				reg_write,
	input				clk,
	input				reset,
	input		[31:0]	data_write,
	
	output	reg	[31:0]	value_rs,
	output	reg	[31:0]	value_rt
);

	reg	[31:0]	reg_file [0:31];
	
	initial begin
       reg_file[0]	= 0;	// zero

	   reg_file[8]	= 10;	// t0
	   reg_file[9]	= 11;	// t1
	   reg_file[10]	= 12;	// t2
	   reg_file[11]	= 13;	// t3
       reg_file[12]	= 14;	// t4
       reg_file[13]	= 15;	// t5
       reg_file[14]	= 16;	// t6
	   reg_file[15] = 17;	// t7

	   reg_file[16] = 50;	// s0
	   reg_file[17] = 55;	// s1
	end
	
	always @(posedge clk or negedge clk or posedge reset) begin
		if (reset) begin
			value_rs	<= 0;
			value_rt	<= 0;
		end else if (clk) begin
			if (reg_write) begin
				reg_file[address_write]	<= data_write;
			end
		end else begin
			value_rs	<= reg_file[address_rs];
			value_rt	<= reg_file[address_rt];
		end
	end
endmodule