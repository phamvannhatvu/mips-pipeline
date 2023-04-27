module EXE_stage (
    input       [31:0]  immediate,
    input       [31:0]  rs_value,
    input       [31:0]  rt_value,
    input               alu_src,
    input       [2:0]   alu_op,
    input       [3:0]   mem_control,
    input       [1:0]   wb_control_in,
    input   			excep_control_in,
    input               clk,
    input               reset,

    input       [31:0]  prev_alu_result,
    input       [31:0]  prev_wb_result,
    input       [1:0]   operand_0_forward_control,
    input       [1:0]   operand_1_forward_control,

    output      [7:0]   alu_status,
    output      [31:0]  alu_result,
    output      [1:0]   wb_control_out,
    output              comparator_out,
    output  reg			excep_control_out
);
    // Exception chuan bi no cai bum

    wire [31:0] operand_0;
    mux_4_to_1 #(32) opreand_0_mux (
        .in0(rs_value),
        .in1(prev_alu_result),
        .in2(prev_wb_result),
        .sel(operand_0_forward_control),

        .out(operand_0)
    );

    wire [31:0] operand_1_pre;
    mux_2_to_1 #(32) operand_1_pre_mux (
        .in0(rt_value),
        .in1(immediate),
        .sel(alu_src),

        .out(operand_1_pre)
    );

    wire [31:0] operand_1;
    mux_4_to_1 #(32) opreand_1_mux (
        .in0(operand_1_pre),
        .in1(prev_alu_result),
        .in2(prev_wb_result),
        .sel(operand_1_forward_control),

        .out(operand_1)
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
        .alu_operand_0(operand_0),
        .alu_operand_1(operand_1),
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

    align_check align_check (
        .mem_control_in(mem_control),
        .alu_op_in(alu_op),
        .alu_result_in(alu_result_out),

        .align_exception_out(alu_status[3])
    );

    assign comparator_out = (rs_value == rt_value);
    assign wb_control_out[1] = wb_control_in[1];
    assign wb_control_out[0] = (wb_control_in[0] == 1'b0) ? wb_control_in[0] : ~ hilo_write_control;
    
endmodule