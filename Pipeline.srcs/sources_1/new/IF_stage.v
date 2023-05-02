module IF_stage (
    input       [7:0]   pc_from_id,
    input       [7:0]   pc_from_exe,
    input               pc_hazard_control,
    input               excep_enable,
    input               clk,
    input               reset,
    input       [7:0]   epc,

    output      [31:0]  instruction_out,
    output      [7:0]   pc_out
);

    wire [7:0]  pc_in;
    mux_2_to_1 #(8) pc_next_mux (
		.in0(pc_from_id),
		.in1(pc_from_exe),
		.sel(pc_hazard_control),

		.out(pc_in)
	);

    IMEM imem (
        .reset(reset),
        .clk(clk),
        .pc(pc_in),
        
        .instruction_out(instruction_out)
    );
    
    pc_register #(8) pc_reg (
        .data_in(pc_in),
        .clk(clk),
        .reset(reset),
        .excep_enable(excep_enable),
        .epc(epc),
        
        .data_out(pc_out)
    );

endmodule