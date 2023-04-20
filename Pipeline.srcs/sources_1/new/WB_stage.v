module WB_stage (
    input               mem2reg,
    input       [31:0]  data_from_dmem,
    input       [31:0]  alu_result,

    output      [31:0]  data_write2reg
);

    mux_2_to_1 #(32) data_reg_sel (
        .in0(data_from_dmem),
        .in1(alu_result),
        .sel(mem2reg),

        .out(data_write2reg)
    );

endmodule