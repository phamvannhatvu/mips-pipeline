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
	always @(posedge clk or negedge clk or posedge reset) begin
		if (reset) begin
			value_rs			<= 0;
			value_rt			<= 0;
			reg_file[0]			<= 0;
			reg_file[1]			<= 0;
			reg_file[2]			<= 0;
			reg_file[3]			<= 0;
			reg_file[4]			<= 0;
			reg_file[5]			<= 0;
			reg_file[6]			<= 0;
			reg_file[7]			<= 0;
			reg_file[8]			<= 0;
			reg_file[9]			<= 0;
			reg_file[10]		<= 0;
			reg_file[11]		<= 0;
			reg_file[12]		<= 0;
			reg_file[13]		<= 0;
			reg_file[14]		<= 0;
			reg_file[15]		<= 0;
			reg_file[16]		<= 0;
			reg_file[17]		<= 0;
			reg_file[18]		<= 0;
			reg_file[19]		<= 0;
			reg_file[20]		<= 0;
			reg_file[21]		<= 0;
			reg_file[22]		<= 0;
			reg_file[23]		<= 0;
			reg_file[24]		<= 0;
			reg_file[25]		<= 0;
			reg_file[26]		<= 0;
			reg_file[27]		<= 0;
			reg_file[28]		<= 0;
			reg_file[29]		<= 0;
			reg_file[30]		<= 0;
			reg_file[31]		<= 0;
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