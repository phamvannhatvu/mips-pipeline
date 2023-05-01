module reg_IF_ID (
	input		[31:0]	instruction,
	input		[7:0]	pc_in,
	input				excep_enable,
	input				clk,
	input				reset,

	output	reg	[5:0]	opcode,
	output	reg	[4:0]	rs,
	output	reg	[4:0]	rt,
	output	reg	[4:0]	rd,
	output	reg	[4:0]	shamt,
	output	reg	[5:0]	funct,
	output	reg	[15:0]	immediate,
	output	reg	[25:0]	jump_address,
	output	reg	[7:0]	pc_out
);

	always @(posedge clk or posedge reset) begin
		if (reset || excep_enable) begin
			opcode			<= 0;
			rs				<= 0;
			rt				<= 0;
			rd				<= 0;
			shamt			<= 0;
			funct			<= 0;
			immediate		<= 0;
			jump_address	<= 0;
			pc_out			<= 0;
		end else begin
			opcode			<= instruction[31:26];
			rs				<= instruction[25:21];
			rt				<= instruction[20:16];
			rd				<= instruction[15:11];
			shamt			<= instruction[10:6];
			funct			<= instruction[5:0];
			immediate		<= instruction[15:0];
			jump_address	<= instruction[25:0];
			pc_out			<= pc_in;
		end
	end

endmodule