module reg_HI_LO (
    input       [31:0]  high_register_in;
    input       [31:0]  low_register_in;
    input               write_control;
    input       [1:0]   read_control;
    input               clk;
    input               reset;

    output      [31:0]  data_out;
);

    reg [31:0]  reg_hilo [0:1];

    always @(posedge clk or negedge clk or posedge reset) begin
        if (reset) begin
            data_out <= 0;
        end else if (clk) begin
            if (write_control) begin
                reg_hilo[0] <= low_register_in;
                reg_hilo[1] <= high_register_in;
            end
        end else begin
            if (read_control[0]) begin
                data_out <= reg_hilo[0];
            end else if (read_control[1]) begin
                data_out <= reg_hilo[1];
            end else begin
                data_out <= 32'b0;
            end
        end
    end
    
endmodule