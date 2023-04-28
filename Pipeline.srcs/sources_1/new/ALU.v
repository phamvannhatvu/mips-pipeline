module ALU (
	input		[4:0]	alu_control,
	input		[31:0]	alu_operand_0,
	input		[31:0]	alu_operand_1,
	input		[4:0]	shamt,

	output	reg	[31:0]	alu_result,
	output	reg	[6:0]	alu_status,
	output	reg	[31:0]	high_register_out,
	output	reg	[31:0]	low_register_out
);

	reg         carry_in;
	reg [31:0]  alu_operand_0_r;
	reg [31:0]  alu_operand_1_r;
	//not consider alu_status
	always @(*) begin
		alu_result				= 32'b0;
		alu_status				= 7'b0;
		high_register_out		= 32'b0;
		low_register_out		= 32'b0;

		alu_operand_0_r			= alu_operand_0;
		alu_operand_1_r			= alu_operand_1;
		carry_in				= 1'b0;
		
		if (alu_control[2] == 1'b1) begin
			if (alu_control[4] == 1'b1) begin
				alu_operand_0_r	= ~ alu_operand_0;
				carry_in		= 1'b1;
			end
			if (alu_control[3] == 1'b1) begin
				alu_operand_1_r	= ~ alu_operand_1;
				carry_in		= 1'b1;
			end
		end

		case (alu_control[2:0])
			3'b001: begin
				if (alu_control[4:3] == 2'b00) begin
					alu_result = alu_operand_1_r << shamt;
				end else if (alu_control[4:3] == 2'b01) begin
					alu_result = alu_operand_1_r >> shamt;
				end
			end
			3'b010: begin
				if (alu_control[4:3] == 2'b00) begin
					{high_register_out, low_register_out} = alu_operand_0_r * alu_operand_1_r;
				end else if (alu_control[4:3] == 2'b11) begin
					if (alu_operand_1 == 32'b0) begin
						alu_status[2] = 1'b1;
					end else begin
						high_register_out = alu_operand_0_r % alu_operand_1_r;
						low_register_out = alu_operand_0_r / alu_operand_1_r;
					end
				end
			end
			3'b011: begin
				alu_result[0] = (alu_operand_0_r < alu_operand_1_r);
			end
			3'b100: begin
				alu_result = alu_operand_0_r & alu_operand_1_r;
			end
			3'b101: begin
				alu_result = alu_operand_0_r | alu_operand_1_r;
			end
			3'b110: begin
				alu_result = alu_operand_0_r ^ alu_operand_1_r;
			end
			3'b111: begin
				{alu_status[4], alu_result} = alu_operand_0_r + alu_operand_1_r + carry_in;
			end
		endcase

		// Overflow check
		if (alu_control[2:0] == 3'b111) begin
			alu_status[5] = (alu_status[4] != alu_result[31] && alu_control[4] == alu_control[3]);
		end

		// Zero check
		if (alu_result == 32'b0) begin
			alu_status[6] = 1'b1;
		end

		// Negative check
		if (alu_result[31] == 1'b1) begin
			alu_status[3] = 1'b1;
		end
	end

endmodule