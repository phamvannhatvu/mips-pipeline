module pc_update (
    input       [13:0]  control_in,
    input       [7:0]   pc_in,
    input       [15:0]  immediate_in,
    input       [25:0]  jump_immediate_in,

    output      [7:0]   pc_out
);

    wire [7:0]  pc_branch_address;
    wire [7:0]  shifted_immediate = immediate_in << 2;
    assign pc_branch_address = pc_in + shifted_immediate;

    wire [7:0]	pc_jump_address;
	wire [7:0]	shifted_jump_immediate = jump_immediate_in << 2;
	assign pc_jump_address = pc_in + shifted_jump_immediate;
    
    wire [7:0]  pc_branch_mux_out;
    mux_2_to_1 #(8) branch_pc_mux (
		.in0(pc_in),
		.in1(pc_branch_address),
		.sel(control_in[12]),

		.out(pc_branch_mux_out)
	);

	mux_2_to_1 #(8) jump_pc_mux (
		.in0(pc_branch_mux_out),
		.in1(pc_jump_address),
		.sel(control_in[13]),

		.out(pc_out)
	);

endmodule