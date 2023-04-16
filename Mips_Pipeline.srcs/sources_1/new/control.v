module control(
	input 	[5:0] 	opcode,
	input 			nop,
	input			reset,

	output	[10:0] 	control_signal
);

	//for add instruction only
	assign control_signal = ((reset || nop) ? 0 : 11'b0000xx01011);

endmodule