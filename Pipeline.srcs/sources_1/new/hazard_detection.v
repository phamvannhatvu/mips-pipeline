module hazard_detection (
    input       [4:0]   address_write,
    input               comparator_in,
    input               jump_control_in,
    input               branch_control_in,
    input       [1:0]   mem_read_control_in,
    input       [4:0]   next_address_rs,
    input       [4:0]   next_address_rt,
    input       [1:0]   next_mem_write_control_in,
    input               next_regdst_control_in,

    output  reg         pc_control_out,
    output  reg         control_signal
);

    always @(*) begin
        pc_control_out  = 1'b0;
        control_signal  = 1'b0;

        if (jump_control_in == 1'b1) begin
            pc_control_out      = 1'b1;
            control_signal      = 1'b1;
        end else if (branch_control_in == 1'b1 && comparator_in == 1'b1) begin
            pc_control_out      = 1'b1;
            control_signal      = 1'b1;
        end else if (mem_read_control_in != 2'b00) begin
            if (address_write == next_address_rs || ((next_regdst_control_in == 1'b1 || next_mem_write_control_in != 2'b00) && address_write == next_address_rt)) begin
                pc_control_out  = 1'b1;
                control_signal  = 1'b1;
            end
        end
    end

endmodule