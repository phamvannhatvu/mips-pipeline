module REG(
	input 	    [4:0] 	REG_address_rs,
	input 	    [4:0] 	REG_address_rt,
	input 	    [4:0] 	REG_address_write,
	input 		   	   REG_write_control,
	input			   REG_clk,
	input			   REG_reset,
	input 	    [31:0] 	REG_write_data,
	
	output reg	[31:0]	REG_value_rs,
	output reg	[31:0]	REG_value_rt
);
	reg 	[31:0]	REG_reg_file [0:31];
	
	initial begin
	   REG_reg_file[8] = 4;
	   REG_reg_file[9] = 5;
	end
	
	always @(posedge REG_clk or posedge REG_reset or negedge REG_clk) begin
		if (REG_reset) begin
			REG_value_rs 		<= 0;
			REG_value_rt 		<= 0;
		end else if (REG_clk) begin
			if (REG_write_control) begin
				REG_reg_file[REG_address_write] <= REG_write_data;
			end
		end else begin
			REG_value_rs 						<= REG_reg_file[REG_address_rs];
			REG_value_rt 						<= REG_reg_file[REG_address_rt];
		end
	end
endmodule