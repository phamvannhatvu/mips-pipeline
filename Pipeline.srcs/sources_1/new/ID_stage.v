module ID_stage (
    input       [5:0]   opcode,
    input       [4:0]   address_rs,
    input       [4:0]   address_rt,
    input       [4:0]   address_rd,
    input       [15:0]  immediate,
    input       [25:0]  jump_immediate,
    input       [4:0]   address_write_in,
    input       [31:0]  data_write,
    input               reg_write,
    input               hz_control_signal,
    input       [7:0]   pc_in,
    input               clk,
    input               reset,

    output      [4:0]   address_write_out,
    output      [31:0]  value_rs,
    output      [31:0]  value_rt,
    output      [31:0]  extended_immediate,
    output      [13:0]  control_signal,
    output      [1:0]   mem_write_control_out,
    output              regdst_control_out,
    output      [7:0]   pc_calculated
);

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

    wire [13:0] control_out;
    control control (
        .opcode(opcode),
        .nop(nop),
        
        .control_signal(control_out)
    );

    assign regdst_control_out = control_out[3];
    assign mem_write_control_out = control_out[9:8];
    
    mux_2_to_1 #(14) control_signal_mux (
        .in0(control_out),
        .in1(14'b0),
        .sel(hz_control_signal),

        .out(control_signal)
    );

    mux_2_to_1 #(5) address_write_mux (
        .in0(address_rt),
        .in1(address_rd),
        .sel(control_signal[3]),

        .out(address_write_out)
    );

    pc_update pc_update (
		.control_in(control_signal),
    	.pc_in(pc_in),
    	.immediate_in(immediate),
    	.jump_immediate_in(jump_immediate),

    	.pc_out(pc_calculated)
	);
    
endmodule