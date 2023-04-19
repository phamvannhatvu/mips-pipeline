module mux_2_to_1 #(parameter N = 1) (
    input       [N-1:0] in0,
    input       [N-1:0] in1,
    input               sel,

    output      [N-1:0] out
);

assign out = sel ? in1 : in0;

endmodule