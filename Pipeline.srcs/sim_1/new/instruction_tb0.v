`timescale 1 ns / 10 ps  // time-unit = 1 ns, precision = 10 ps

module instruction_tb0;
    
reg clk, reset;
reg BOARD_clk;
reg load;
reg [3:0] out_sel;
reg [7:0] pc;
wire [31:0] out;
wire [7:0] lcd_data;
wire lcd_rs;
wire lcd_enable;

system uut(
    .SW_clk(clk), 
    .SYS_pc_val(pc), 
    .SYS_load(load),
    .BOARD_clk(BOARD_clk),
    .SYS_reset(reset),
    .SYS_output_sel(out_sel), 
    
    .SYS_leds(out));

always #5 clk = ~ clk;
always #0.02 BOARD_clk = ~BOARD_clk;

initial begin
    clk = 0;
    BOARD_clk = 0;
    reset = 1;
    load = 1;
    pc = 4;
    out_sel = 4'b1100;
    #33 reset = 0;
    #44 load = 0;
    #80 out_sel = 4'b1100;
    #300 $finish;
end

endmodule 