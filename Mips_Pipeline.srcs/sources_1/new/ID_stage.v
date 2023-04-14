module ID_stage (
    input        clk,
    input        reset,
    input [4:0]  address_rs,
    input [4:0]  address_rt,
    input [5:0]  opcode,
    input [31:0] data_write,
    input        reg_write,
    input [4:0]  address_write,
    input [15:0] immediate,

    output [10:0] control_signal,
    output [31:0] value_rs,
    output [31:0] value_rt,
    output [31:0] extended_immediate
);
    REG regFile(
        //input
        .address_rs(address_rs),
        .address_rt(address_rt),
        .address_write(address_write),
        .data_write(data_write),
        .reg_write(reg_write),

        .clk(clk),
        .reset(reset),

        //output
        .value_rs(value_rs),
        .value_rt(value_rt)
    );

    sign_extender sign_extender(
        //input
        .in(immediate),

        //output
        .out(extended_immediate)
    );

    control control(
        //input
        .opcode(opcode),

        //output
        .control_signal(control_signal)
    );
endmodule