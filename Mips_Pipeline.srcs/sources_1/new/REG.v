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
	   reg_file[8] = 4;
	   reg_file[9] = 5;
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