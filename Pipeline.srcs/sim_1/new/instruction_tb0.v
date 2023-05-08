`timescale 1 ns / 10 ps  // time-unit = 1 ns, precision = 10 ps

module instruction_tb0;
    
reg clk, reset;
reg BOARD_clk;
reg [3:0] out_sel;
reg [7:0] pc;
wire [31:0] out;
wire [7:0] lcd_data;
wire lcd_rs;
wire lcd_enable;

system uut(
    .SYS_clk(clk), 
    .SYS_pc_val(pc), 
    .BOARD_clk(BOARD_clk),
    .SYS_reset(reset),
    .SYS_load(0), 
    .SYS_output_sel(out_sel), 
    
    .SYS_leds(out),
    .LCD_data(lcd_data),
    .LCD_rs(lcd_rs),
    .LCD_enable(lcd_enable));

always #5 clk = ~ clk;
always #0.02 BOARD_clk = ~BOARD_clk;

initial begin
    clk = 0;
    BOARD_clk = 0;
    reset = 1;
    pc = 0;
    out_sel = 4'b0110;
    #33 reset = 0;
    #80 out_sel = 4'b0000;
    #153 $finish;
end

endmodule 