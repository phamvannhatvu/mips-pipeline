module EXE_stage (
    input       [31:0]  immediate,
    input       [7:0]   pc,
    input       [31:0]  rs_value,
    input               alu_src,
    input       [2:0]   alu_op,
    input               reg_dst,
    input       [31:0]  rt_value,
    input       [4:0]   rt,
    input       [4:0]   rd,

    output      [7:0]   branch_address,
    output      [7:0]   alu_status,
    output      [31:0]  alu_result,
    output      [4:0]   write_register
);

    wire [31:0] shifted_immediate = immediate << 2;
    
    wire [7:0]  next_pc = pc + 4;
    assign branch_address = shifted_immediate + next_pc;
    // adder32bit adder32bit (
    //     .in0(shifted_immediate),
    //     .in1({24'h000000, next_pc}),
        
    //     .out(branch_address)
    // );

    wire [31:0] second_operand;
    mux_2_to_1 #(32) operand_mux (
        .in0(rt_value),
        .in1(immediate),
        .sel(alu_src),

        .out(second_operand)
    );

    mux_2_to_1 #(5) write_reg_mux (
        .in0(rt),
        .in1(rd),
        .sel(reg_dst),
        
        .out(write_register)
    );

    wire [4:0]  alu_control_out;
    wire        exception_out;
    wire        mfhi_enable;
    wire        mflo_enable;
    alu_control alu_control (
        .funct(immediate[5:0]),
        .alu_op(alu_op),

        .control_out(alu_control_out),
        .exception_out(exception_out),
        .mfhi_enable(mfhi_enable),
        .mflo_enable(mflo_enable)
    );

    wire [31:0] high_register_out;
    wire [31:0] low_register_out;
    wire        reg_write_control_out;
    ALU ALU (
        .alu_control(alu_control_out),
        .alu_operand_0(rs_value),
        .alu_operand_1(second_operand),
        .shamt(immediate[10:6]),

        .alu_result(alu_result),
        .alu_status(alu_status),
        .high_register_out(high_register_out),
        .low_register_out(low_register_out),
        .reg_write_control_out(reg_dst_control_out)
    );
    
endmodule