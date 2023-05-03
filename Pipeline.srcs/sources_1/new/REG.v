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
	integer i;
	always @(posedge clk or negedge clk or posedge reset) begin
		if (reset) begin
			value_rs		<= 0;
			value_rt		<= 0;
			for (i = 0; i <= 32; i = i + 1) begin
				reg_file[i] <= 0;
			end
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