module MEM_stage (
    input           branch_control,
    input           alu_zero,
    input           mem_read,
    input           mem_write,

    input [31:0]    mem_address,
    input [31:0]    write_data,

    input           clk,
    input           reset,

    output [31:0]   data_read_out,
    output          branch_pc_sel
);
    
    DMEM data_mem(
        //input
        .address(mem_address),
        .data_in(write_data),
        .mem_write(mem_write),
        .mem_read(mem_read),
        .clk(clk),
        .reset(reset),

        //output
        .data_out(data_read_out)
    );

    assign branch_pc_sel = branch_control & alu_zero;

endmodule