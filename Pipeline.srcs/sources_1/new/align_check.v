module align_check (
    input       [3:0]   mem_control_in,
    input       [2:0]   alu_op_in,
    input       [31:0]  alu_result_in,

    output  reg         align_exception_out
);

    always @(*) begin
        align_exception_out = 0;

        if (alu_op_in == 3'b111) begin
            if (mem_control_in[3:2] == 2'b10 || mem_control_in[1:0] == 2'b10) begin
                if (alu_result_in[0] != 1'b0) begin
                    align_exception_out = 1'b1;
                end
            end else if (mem_control_in[3:2] == 2'b11 || mem_control_in[1:0] == 2'b11) begin
                if (alu_result_in[1:0] != 2'b00) begin
                    align_exception_out = 1'b1;
                end
            end
        end
    end

endmodule