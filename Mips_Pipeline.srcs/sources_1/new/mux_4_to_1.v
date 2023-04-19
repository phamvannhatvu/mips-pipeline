module mux_4_to_1 #(parameter N = 1) (
    input       [N-1:0] in0,
    input       [N-1:0] in1,
    input       [N-1:0] in2,
    input       [N-1:0] in3,
    input       [1:0]   sel,

    output reg  [N-1:0] out
);

always @(*) begin
    case (sel)
        2'b00: begin
            out = in0;
        end
        2'b01: begin
            out = in1;
        end
        2'b10: begin
            out = in2;
        end
        default: begin
            out = in3;
        end
    endcase
end

endmodule