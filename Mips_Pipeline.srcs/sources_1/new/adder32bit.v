module adder32bit (
    input  [31:0] in0,
    input  [31:0] in1,
    output [31:0] sum
);
    assign out = in0 + in1;
endmodule