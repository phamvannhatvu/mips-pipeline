module control (
	input		[5:0]	opcode,
	input				nop,

	output	reg	[13:0]	control_signal
);

	always @(*) begin
		if (nop) begin
			control_signal = 14'b0;
		end else if (opcode == 6'b000000) begin
			// R-TYPE instructions
			//                   32109876543210
			control_signal = 14'b00000001101011;
		end else if (opcode == 6'b001000) begin
			// ADDI
			//                   32109876543210
			control_signal = 14'b00000011110011;
		end else if (opcode == 6'b001100) begin
			// ANDI
			//                   32109876543210
			control_signal = 14'b00000010010011;
		end else if (opcode == 6'b001101) begin
			// ORI
			//                   32109876543210
			control_signal = 14'b00000010110011;
		end else if (opcode == 6'b001110) begin
			// XORI
			//                   32109876543210
			control_signal = 14'b00000011010011;
		end else if (opcode == 6'b100000) begin
			// LB
			//                   32109876543210
			control_signal = 14'b00010011110001;
		end else if (opcode == 6'b100101) begin
			// LH
			//                   32109876543210
			control_signal = 14'b00100011110001;
		end else if (opcode == 6'b100011) begin
			// LW
			//                   32109876543210
			control_signal = 14'b00110011110001;
		end else if (opcode == 6'b101000) begin
			// SB
			//                   32109876543210
			control_signal = 14'b00000111110000;
		end else if (opcode == 6'b101001) begin
			// SH
			//                   32109876543210
			control_signal = 14'b00001011110000;
		end else if (opcode == 6'b101011) begin
			// SW
			//                   32109876543210
			control_signal = 14'b00001111110000;
		end else if (opcode == 6'b000100) begin
			// BEQ
			//                   32109876543210
			control_signal = 14'b01000000001000;
		end else if (opcode == 6'b000010) begin
			// J
			//                   32109876543210
			control_signal = 14'b10000000000000;
		end else begin
			// Exception: Out of instruction set
			//                   32109876543210
			control_signal = 14'b00000000000100;
		end
	end

endmodule