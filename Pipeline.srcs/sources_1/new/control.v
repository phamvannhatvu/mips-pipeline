module control (
	input		[5:0]	opcode,
	input				nop,

	output	reg	[13:0]	control_signal
);

	always @(*) begin
		if (nop) begin				// NOP
			//					  		  32109876543210
			control_signal			= 14'b00000000000000;
		end else begin
			case (opcode)
				6'b000000: begin	// R-TYPE instructions
					control_signal	= 14'b00000001101011;
				end
				6'b001000: begin	// ADDI
					control_signal	= 14'b00000011110011;
				end
				6'b001100: begin	// ANDI
					control_signal	= 14'b00000010010011;
				end
				6'b001101: begin	// ORI
					control_signal	= 14'b00000010110011;
				end
				6'b001110: begin	// XORI
					control_signal	= 14'b00000011010011;
				end
				6'b100000: begin	// LB
					control_signal	= 14'b00010011110001;
				end
				6'b100001: begin	// LH
					control_signal	= 14'b00100011110001;
				end
				6'b100011: begin	// LW
					control_signal	= 14'b00110011110001;
				end
				6'b101000: begin	// SB
					control_signal	= 14'b00000111110000;
				end
				6'b101001: begin	// SH
					control_signal	= 14'b00001011110000;
				end
				6'b101011: begin	// SW
					control_signal	= 14'b00001111110000;
				end
				6'b000100: begin	// BEQ
					control_signal	= 14'b01000000001000;
				end
				6'b000010: begin	// J
					control_signal	= 14'b10000000000000;
				end
				default: begin		// Exception: Out of instruction set
					control_signal	= 14'b00000000000100;
				end
			endcase
		end
	end

endmodule