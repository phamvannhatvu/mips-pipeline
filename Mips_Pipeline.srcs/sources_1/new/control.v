module control (
	input		[5:0]	opcode,
	input				nop,
	input				reset,

	output	reg	[13:0]	control_signal
);
	// TOi ve vua khoc vua sua
	always @(*) begin
		if (reset || nop) begin
			control_signal = 11'b0;
		end else if (opcode == 6'b000000) begin
			// R-TYPE instructions
			//                   432109876543210
			control_signal = 15'b000000111000000;
		end else if (opcode == 6'b001000) begin
			// ADDI
			//                   432109876543210
			control_signal = 15'b000000011000000;
		end else if (opcode == 6'b001100) begin
			// ANDI
			//                   432109876543210
			control_signal = 15'b000000000000000;
		end else if (opcode == 6'b001101) begin
			// ORI
			//                   432109876543210
			control_signal = 15'b000000001000000;
		end else if (opcode == 6'b001110) begin
			// XORI
			//                   432109876543210
			control_signal = 15'b000000010000000;
		end else if (opcode == 6'b100000 || opcode == 6'b100011) begin
			// LB
			//                   432109876543210
			control_signal = 15'b000000011000000;
		end else if (opcode == 6'b100101) begin
			// LH
			//                   432109876543210
			control_signal = 15'b000000100000000;
		end else if (opcode == 6'b100011) begin
			// LW
			//                   432109876543210
			control_signal = 15'b000000101000000;
		end else if (opcode == 6'b101000) begin
			// SB
			//                   432109876543210
			control_signal = 15'b000000011000000;
		end else if (opcode == 6'b101001) begin
			// SH
			//                   432109876543210
			control_signal = 15'b000000100000000;
		end else if (opcode == 6'b101011) begin
			// SW
			//                   432109876543210
			control_signal = 15'b000000101000000;
		end else if (opcode == 6'b000100) begin
			// BEQ
			//                   432109876543210
			control_signal = 15'b000000110000000;
		end else begin
			// Exception: Out of instruction set
			//                   432109876543210
			control_signal = 15'b000000000000000;
		end
	end

endmodule