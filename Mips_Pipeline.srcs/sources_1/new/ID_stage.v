module ID_stage (
    input               clk,
    input               reset,
    input       [5:0]   opcode,
    input       [4:0]   address_rs,
    input       [4:0]   address_rt,
    input       [15:0]  immediate,
    input       [7:0]   pc_in,
    
    input       [31:0]  data_write,
    input               reg_write,
    input       [4:0]   address_write_in,

    output      [13:0]  control_signal,
    output      [31:0]  value_rs,
    output      [31:0]  value_rt,
    output      [31:0]  extended_immediate,
    output      [4:0]   address_write_out
);
    // Them mux regDes, brach haha, so sanh bang

    wire nop;   // Determine nop instruction
    assign nop = ({opcode, address_rs, address_rt, immediate} == 32'b0);

    REG regFile (
        .address_rs(address_rs),
        .address_rt(address_rt),
        .address_write(address_write_in),
        .data_write(data_write),
        .reg_write(reg_write),
        .clk(clk),
        .reset(reset),

        .value_rs(value_rs),
        .value_rt(value_rt)
    );

    sign_extender sign_extender (
        .in(immediate),

        .out(extended_immediate)
    );

    control control (
        .opcode(opcode),
        .nop(nop),
        .reset(reset),
        
        .control_signal(control_signal)
    );
    
endmodule