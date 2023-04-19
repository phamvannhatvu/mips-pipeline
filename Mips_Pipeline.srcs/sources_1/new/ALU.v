module ALU (
	input		[4:0]	alu_control,
	input		[31:0]	alu_operand_0,
	input		[31:0]	alu_operand_1,
	input		[4:0]	shamt,

	output	reg	[31:0]	alu_result,
	output	reg	[7:0]	alu_status,
	output	reg	[31:0]	high_register_out,
	output	reg	[31:0]	low_register_out
);
reg         carry_in;
reg [31:0]  alu_operand_0_r;
reg [31:0]  alu_operand_1_r;

always @(*) begin
	alu_result = 32'b0;
	alu_status = 8'b0;
	high_register_out = 32'b0;
	low_register_out = 32'b0;

	alu_operand_0_r = alu_operand_0;
	alu_operand_1_r = alu_operand_1;
	carry_in = 1'b0;
	
	if (alu_control[2] == 1'b0) begin
		if (alu_control[4] == 1'b1) begin
			alu_operand_0_r	= ~ alu_operand_0;
			carry_in = 1'b1;
		end
		if (alu_control[3] == 1'b1) begin
			alu_operand_1_r	= ~ alu_operand_1;
			carry_in		= 1'b1;
		end
	end

	case (alu_control[2:0])
		3'b000: begin
			alu_result = alu_operand_0_r & alu_operand_1_r;
		end
		3'b001: begin
			alu_result = alu_operand_0_r | alu_operand_1_r;
		end
		3'b010: begin
			alu_result = alu_operand_0_r ^ alu_operand_1_r;
		end
		3'b011: begin
			{alu_status[5], alu_result} = alu_operand_0_r + alu_operand_1_r + carry_in;
		end
		3'b100: begin
			if (alu_control[4:3] == 2'b00) begin
				{high_register_out, low_register_out} = alu_operand_0_r * alu_operand_1_r;
			end else if (alu_control[4:3] == 2'b01) begin
				if (alu_operand_1 == 32'b0) begin
					alu_status[2] = 1'b1;
				end else begin
					high_register_out = alu_operand_0_r % alu_operand_1_r;
					low_register_out = alu_operand_0_r / alu_operand_1_r;
				end
			end
		end
		3'b101: begin
			if (alu_control[4:3] == 2'b00) begin
				alu_result = alu_operand_1_r << shamt;
			end else if (alu_control[4:3] == 2'b01) begin
				alu_result = alu_operand_1_r >> shamt;
			end else if (alu_control[4:3] == 2'b11) begin
				alu_result = alu_operand_1_r >>> shamt;
			end
		end
		3'b110: begin
			{alu_status[5], alu_result} = alu_operand_0_r + ~ alu_operand_1_r + 1'b1;
		end
		3'b111: begin
			{alu_status[5], alu_result} = alu_operand_0_r + alu_operand_1_r;
		end
	endcase
	
	// Overflow check
	if (alu_control[2:0] == 3'b011 || alu_control[2:0] == 3'b110 || alu_control[2:0] == 3'b111) begin
		if (alu_control[3] == 1'b0 && alu_operand_0[31] == 1'b0 && alu_operand_1[31] == 1'b0 && alu_result[31] == 1'b1) begin
			alu_status[6] = 1'b1;
		end else if (alu_control[3] == 1'b0 && alu_operand_0[31] == 1'b1 && alu_operand_1[31] == 1'b1 && alu_result[31] == 1'b0) begin
			alu_status[6] = 1'b1;
		end else if (alu_control[3] == 1'b1 && alu_operand_0[31] == 1'b0 && alu_operand_1[31] == 1'b1 && alu_result[31] == 1'b1) begin
			alu_status[6] = 1'b1;
		end else if (alu_control[3] == 1'b1 && alu_operand_0[31] == 1'b1 && alu_operand_1[31] == 1'b0 && alu_result[31] == 1'b0) begin
			alu_status[6] = 1'b1;
		end
	end

	// Aligned check
	if (alu_control[2:0] == 3'b111) begin
		if (alu_control[4:3] == 2'b01 && alu_result[0] != 1'b0) begin
			alu_status[3] = 1'b1;
		end else if (alu_control[4:3] == 2'b10 && alu_result[1:0] != 2'b00) begin
			alu_status[3] = 1'b1;
		end
	end

	// Reset SLT result
	if (alu_control == 5'b10011) begin
		if (alu_status[5] == 1'b0) begin
			if (alu_result == 32'b0) begin
				alu_result = 32'b0;
			end else if (alu_operand_0[31] == 1'b0 && alu_operand_1[31] == 1'b1) begin
				alu_result = 32'b0;
			end else begin
				alu_result = {31'b0, 1'b1};
			end
		end else begin
			if (alu_operand_0[31] == 1'b1 && alu_operand_1[31] == 1'b0) begin
				alu_result = {31'b0, 1'b1};
			end else begin
				alu_result = 32'b0;
			end
		end
	end

	// Zero check
	if (alu_result == 32'b0) begin
		alu_status[7] = 1'b1;
	end

	// Negative check
	if (alu_result[31] == 1'b1) begin
		alu_status[4] = 1'b1;
	end
end

endmodule