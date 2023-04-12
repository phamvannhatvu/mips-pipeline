module reg_IF_ID(
	input	   [7:0]	reg_IF_ID_PC_in,
	input      [31:0]	reg_IF_ID_instruction,
	input 		       	reg_IF_ID_clk,
	input			    reg_IF_ID_reset,
	
	output reg [4:0] 	reg_IF_ID_rs,
	output reg [4:0] 	reg_IF_ID_rd,
	output reg [4:0] 	reg_IF_ID_rt,
	output reg [5:0]	reg_IF_ID_opcode,
	output reg [4:0]	reg_IF_ID_shamt,
	output reg [5:0]	reg_IF_ID_funct,
	output reg [7:0]	reg_IF_ID_PC_out,
	output reg [31:0]	reg_IF_ID_immediate
);

always @(posedge reg_IF_ID_clk or posedge reg_IF_ID_reset) begin
	if (reg_IF_ID_reset) begin
		reg_IF_ID_rs 		<= 0;
		reg_IF_ID_rd 		<= 0;
		reg_IF_ID_rt 		<= 0;
		reg_IF_ID_opcode 	<= 0;
		reg_IF_ID_shamt 	<= 0;
		reg_IF_ID_funct 	<= 0;
		reg_IF_ID_PC_out 	<= 0;
	end else begin
		reg_IF_ID_opcode 			<= reg_IF_ID_instruction[31:26];
		reg_IF_ID_rs 				<= reg_IF_ID_instruction[25:21];
		reg_IF_ID_rt 				<= reg_IF_ID_instruction[20:16];
		reg_IF_ID_rd 				<= reg_IF_ID_instruction[15:11];
		reg_IF_ID_shamt 			<= reg_IF_ID_instruction[10:6];
		reg_IF_ID_funct 			<= reg_IF_ID_instruction[5:0];
		reg_IF_ID_PC_out			<= reg_IF_ID_PC_in;
		reg_IF_ID_immediate[15:0]	<= reg_IF_ID_instruction[15:0];
		reg_IF_ID_immediate[31:16]	<= 16'b0;
	end
end

endmodule