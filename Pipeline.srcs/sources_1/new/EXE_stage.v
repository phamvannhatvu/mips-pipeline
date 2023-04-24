module EXE_stage (
    input       [31:0]  immediate,
    input       [31:0]  rs_value,
    input       [31:0]  rt_value,
    input               alu_src,
    input       [2:0]   alu_op,
    input   			excep_control_in,

    output      [7:0]   alu_status,
    output      [31:0]  alu_result,
    output  reg			excep_control_out
);
    // Exception chuan bi no cai bum

    wire [31:0] second_operand;
    mux_2_to_1 #(32) operand_mux (
        .in0(rt_value),
        .in1(immediate),
        .sel(alu_src),

        .out(second_operand)
    );

    wire [4:0]  alu_control_out;
    wire        exception_out;
    wire        hilo_write_control;
    wire [1:0]  hilo_read_control;
    alu_control alu_control (
        .funct(immediate[5:0]),
        .alu_op(alu_op),

        .control_out(alu_control_out),
        .exception_out(exception_out),
        .hilo_write(hilo_write_control),
        .hilo_read(hilo_read_control)
    );

    wire [31:0] alu_result_out;
    wire [31:0] high_register_out;
    wire [31:0] low_register_out;
    ALU ALU (
        .alu_control(alu_control_out),
        .alu_operand_0(rs_value),
        .alu_operand_1(second_operand),
        .shamt(immediate[10:6]),

        .alu_result(alu_result_out),
        .alu_status(alu_status),
        .high_register_out(high_register_out),
        .low_register_out(low_register_out)
    );

    wire [31:0] data_hilo_out;
    reg_HI_LO reg_HI_LO (
        .high_register_in(high_register_out),
        .low_register_in(low_register_out),
        .write_control(hilo_write_control),
        .read_control(hilo_read_control),
        .clk(clk),
        .reset(reset),

        .data_out(data_hilo_out)
    );

    wire hilo_read_enable = hilo_read_control[0] | hilo_read_control[1];
    mux_2_to_1 #(32) result_mux (
        .in0(alu_result_out),
        .in1(data_hilo_out),
        .sel(hilo_read_enable),

        .out(alu_result)
    );
    
endmodule