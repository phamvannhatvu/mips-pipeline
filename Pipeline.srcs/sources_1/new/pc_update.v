module pc_update (
    input       [13:0]  control_in,
    input       [7:0]   pc_in,
    input       [15:0]  immediate_in,
    input       [25:0]  jump_immediate_in,

    output	reg	[7:0]   pc_out
);

	always @(*) begin
		if (control_in[13] == 1'b1) begin
			pc_out = pc_in + (jump_immediate_in[7:0] << 2);
		end else if (control_in[12] == 1'b1) begin
			pc_out = pc_in + (immediate_in[7:0] << 2);
		end else begin
			pc_out = pc_in;
		end
	end

endmodule