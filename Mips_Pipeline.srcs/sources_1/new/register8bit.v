module register8bit (
    input [7:0] data_in,
    input       clk,

    output reg [7:0] data_out
);
    always @(negedge clk) begin
        data_out <= data_in;
    end
endmodule