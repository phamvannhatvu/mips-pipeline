module control(
	input 	[5:0] 	opcode,
	output	[10:0] 	control_signal
);

	//for add instruction only
	assign control_signal = 11'b0000xx01011;

endmodule