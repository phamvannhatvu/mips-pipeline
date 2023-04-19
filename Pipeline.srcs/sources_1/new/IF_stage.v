module IF_stage (
    input       [7:0]   pc_in,
    input               clk,
    input               reset,
    
    output      [31:0]  instruction_out,
    output      [7:0]   pc_out
);

    IMEM imem (
        .reset(reset),
        .clk(clk),
        .pc(pc_out),
        
        .instruction_out(instruction_out)
    );

    register8bit pc_reg(
        .data_in(pc_in),
        .clk(clk),

        .data_out(pc_out)
    );

endmodule