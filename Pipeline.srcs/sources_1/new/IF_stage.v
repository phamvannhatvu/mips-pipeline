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
        .pc(pc_in),
        
        .instruction_out(instruction_out)
    );
    
    pc_register #(8) pc_reg (
        .data_in(pc_in),
        .clk(clk),
        .reset(reset),

        .data_out(pc_out)
    );

endmodule