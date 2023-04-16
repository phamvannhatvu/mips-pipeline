module control(
	input 	[5:0] 	opcode,
	input 			nop,
	input			reset,

	output reg	[10:0] 	control_signal
);

	//for add instruction only
	always @(*) begin
	   if (reset || nop) begin
	       control_signal = 0;
	   end else if (opcode == 6'b100011) begin
	       control_signal = 11'b0010xx10001;
	   end else begin
           control_signal = 11'b0000xx01011;
	   end
	end
endmodule