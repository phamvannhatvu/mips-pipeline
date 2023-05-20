module IF_stage (
    input       [7:0]   SYS_pc_val,
    input       [7:0]   pc_from_id,
    input       [7:0]   pc_from_exe,
    input       [7:0]   epc,
    input               SYS_load,
    input               pc_hazard_control,
    input               excep_enable,
    input               clk,
    input               reset,

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

    wire [7:0]  real_pc;
    mux_2_to_1 #(8) real_pc_mux (
        .in0(pc_in),
        .in1(SYS_pc_val),
        .sel(SYS_load),

        .out(real_pc)
    );

    pc_register #(8) pc_reg (
        .data_in(real_pc),
        .epc(epc),
        .excep_enable(excep_enable),
        .clk(clk),
        .reset(reset),
        
        .data_out(pc_out)
    );

    IMEM imem (
        .pc(real_pc),
        .clk(clk),
        .reset(reset),
        
        .instruction_out(instruction_out)
    );

endmodule