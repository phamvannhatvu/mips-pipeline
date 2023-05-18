`timescale 1ns / 1ps

module debouncer(
    input clk,
    input reset,
    input button_in,

    output reg button_out
);

    parameter CYCLE_DEBOUNCE = 25000000;
    reg [24:0] counter_debounce;
    
    always @(posedge clk, posedge reset)
    begin
        if (reset)
        begin
            counter_debounce <= 0;
            button_out <= 0;
        end else
        begin
            if (counter_debounce == CYCLE_DEBOUNCE - 1)
            begin
                counter_debounce <= 0;
                button_out <= button_in;
            end else begin
                counter_debounce <= counter_debounce + 1;
            end
        end
    end
endmodule