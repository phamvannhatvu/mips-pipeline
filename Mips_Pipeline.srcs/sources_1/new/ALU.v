module ALU(
	input 	[3:0] 	alu_control,
	input 	[31:0] 	alu_operand_1,
	input 	[31:0] 	alu_operand_2,
	output 	[31:0] 	alu_result,
	output 	[7 :0] 	alu_status
);
	assign alu_result = alu_operand_1 + alu_operand_2;
endmodule