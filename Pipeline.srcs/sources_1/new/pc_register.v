module pc_register #(parameter N = 1) (
    input       [N-1:0] data_in,
    input               clk,
    input               reset,
    input               excep_control_in,
    input       [N-1:0] epc,

    output  reg [N-1:0] data_out
);

    always @(negedge clk or posedge reset) begin
        if (reset) begin
            data_out <= 0;
        end else if (excep_control_in == 1'b0) begin
            data_out <= data_in + 4;
        end else begin
            data_out <= epc;
        end
    end

endmodule