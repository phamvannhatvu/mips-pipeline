module MEM_stage (
    input       [7:0]   mem_address,
    input       [31:0]  alu_result,
    input       [31:0]  write_data,
    input       [1:0]   mem_read,
    input       [1:0]   mem_write,
    input               mem2reg,
    input               clk,
    input               reset,

    output      [31:0]  wb_data,

    output      [31:0]  data_read_out
);

    DMEM data_mem (
        .address(mem_address),
        .data_in(write_data),
        .mem_write(mem_write),
        .mem_read(mem_read),
        .clk(clk),
        .reset(reset),

        .data_out(data_read_out)
    );

    mux_2_to_1 #(32) data_reg_sel (
        .in0(data_read_out),
        .in1(alu_result),
        .sel(mem2reg),

        .out(wb_data)
    );

endmodule