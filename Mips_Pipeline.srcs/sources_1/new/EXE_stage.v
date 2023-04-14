module EXE_stage (
    input [31:0]    immediate,
    input [7:0]     pc,
    input [31:0]    rs_value,
    input           alu_src,
    input [1:0]     alu_op,
    input           reg_dst,
    input [31:0]    rt_value,
    input [4:0]     rt,
    input [4:0]     rd,

    output [7:0]    branch_address,
    output [7:0]    alu_status,
    output [31:0]   alu_result,
    output [4:0]    write_register
);
    wire [31:0] shifted_immediate;
    shift_left_two shift_left_two(
        //input
        .in(immediate),

        //output
        .out(shifted_immediate)
    );
    
    adder32bit adder32bit(
        //input
        .in0(shifted_immediate),
        .in1(pc),
        
        //output
        .sum(branch_address)
    );

    wire [31:0] second_operand;
    mux32bit operand_mux(
        //input
        .in0(rt_value),
        .in1(immediate),
        .sel(alu_src),

        //output
        .out(second_operand)
    );

    mux5bit write_reg_mux(
        //input
        .in0(rt),
        .in1(rd),
        .sel(reg_dst),
        
        //output
        .out(write_register)
    );

    wire [3:0] alu_control_out;
    alu_control alu_control(
        //input
        .funct(immediate[5:0]),
        .alu_op(alu_op),

        //output
        .control_out(alu_control_out)
    );

    ALU ALU(
        //input
        .alu_control(alu_control_out),
        .alu_operand_1(rs_value),
        .alu_operand_2(second_operand),

        .alu_result(alu_result),
        .alu_status(alu_status)
    );
endmodule