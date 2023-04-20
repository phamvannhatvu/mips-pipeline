module MEM_stage (
    input       [1:0]   mem_read,
    input       [1:0]   mem_write,
    input       [31:0]  mem_address,
    input       [31:0]  write_data,
    input               clk,
    input               reset,

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

endmodule