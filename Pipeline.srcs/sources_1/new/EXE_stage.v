module EXE_stage (
    input       [4:0]   rs_address_in,
    input       [4:0]   rd_address_in,
    input       [4:0]   shamt_in,
    input       [5:0]   funct_in,
    input       [31:0]  rs_value_in,
    input       [31:0]  rt_value_in,
    input       [31:0]  immediate,
    input       [3:0]   mem_control,
    input       [2:0]   alu_op,
    input               alu_src,
    input       [1:0]   wb_control_in,
    input   			excep_enable,
    input               clk,
    input               reset,

    input       [31:0]  prev_alu_result,
    input       [31:0]  prev_wb_result,
    input       [1:0]   operand_0_forward_control,
    input       [1:0]   operand_1_forward_control,
    input       [1:0]   write_address_forward_control,

    output      [31:0]  alu_result,
    output      [31:0]  rt_value_out,
    output      [7:0]   alu_status,
    output              comparator_out,
    output      [1:0]   wb_control_out,
    output  			alu_control_excep,
    output              alu_excep,

    output      [31:0]  operand_0,
    output      [31:0]  operand_1,
    output      [31:0]  alu_out,
    output      [31:0]  data_hilo_out,
    output      [4:0]   alu_control_out
);
    
    mux_4_to_1 #(32) opreand_0_mux (
        .in0(rs_value_in),
        .in1(prev_alu_result),
        .in2(prev_wb_result),
        .sel(operand_0_forward_control),

        .out(operand_0)
    );

    wire [31:0] operand_1_pre;
    mux_2_to_1 #(32) operand_1_pre_mux (
        .in0(rt_value_in),
        .in1(immediate),
        .sel(alu_src),

        .out(operand_1_pre)
    );

    mux_4_to_1 #(32) opreand_1_mux (
        .in0(operand_1_pre),
        .in1(prev_alu_result),
        .in2(prev_wb_result),
        .sel(operand_1_forward_control),

        .out(operand_1)
    );

    mux_4_to_1 #(32) rt_value_mux (
        .in0(rt_value_in),
        .in1(prev_alu_result),
        .in2(prev_wb_result),
        .sel(write_address_forward_control),

        .out(rt_value_out)
    );

    wire        hilo_write_control;
    wire [1:0]  hilo_read_control;
    alu_control alu_control (
        .rs_address(rs_address_in),
        .rd_address(rd_address_in),
        .shamt(shamt_in),
        .funct(funct_in),
        .alu_op(alu_op),

        .control_out(alu_control_out),
        .excep_control_out(alu_control_excep),
        .hilo_write(hilo_write_control),
        .hilo_read(hilo_read_control)
    );

    wire [31:0] high_register_out;
    wire [31:0] low_register_out;
    ALU ALU (
        .alu_control(alu_control_out),
        .alu_operand_0(operand_0),
        .alu_operand_1(operand_1),
        .shamt(shamt_in),

        .alu_result(alu_out),
        .alu_status({alu_status[7:4], alu_status[2:0]}),
        .high_register_out(high_register_out),
        .low_register_out(low_register_out)
    );

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
        .in0(alu_out),
        .in1(data_hilo_out),
        .sel(hilo_read_enable),

        .out(alu_result)
    );

    align_check align_check (
        .mem_control_in(mem_control),
        .alu_op_in(alu_op),
        .alu_result_in(alu_out),

        .align_exception_out(alu_status[3])
    );

    assign comparator_out = (operand_0 == operand_1);
    assign wb_control_out[1] = wb_control_in[1];
    assign wb_control_out[0] = (wb_control_in[0] == 1'b0) ? wb_control_in[0] : ~ hilo_write_control;
    assign alu_excep = (alu_status[6] == 1'b1 || alu_status[3] == 1'b1 || alu_status[2] == 1'b1);
    
endmodule