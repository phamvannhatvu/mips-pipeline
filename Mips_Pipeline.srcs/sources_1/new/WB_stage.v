module WB_stage (
    input [1:0]     mem2reg,
    input [31:0]    data_from_dmem,
    input [31:0]    alu_result,

    output [31:0]   data_write2reg
);
    mux_4_to_1 #(32) data_reg_sel(
        //input
        .in0(data_from_dmem),
        .in1(alu_result),
        .in2(0),
        .in3(0),
        .sel(mem2reg),

        .out(data_write2reg)
    );
endmodule