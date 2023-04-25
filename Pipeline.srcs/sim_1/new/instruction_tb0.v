`timescale 1 ns/10 ps  // time-unit = 1 ns, precision = 10 ps

module instruction_tb0;
    
reg clk, reset;
reg [7:0] pc;
wire [26:0] out;

system uut(.SYS_clk(clk), .SYS_pc_val(pc), .SYS_reset(reset), .SYS_leds(out));

initial begin
    reset = 1;
    pc = 0;
    #5  clk = 0;
    #5  clk = 1;
    #5  clk = 0;
    #5  clk = 1;
    #3  reset = 0;
    #2  clk = 0;
    #5  clk = 1;
    #5  clk = 0;
    #5  clk = 1;
    #5  clk = 0;
    #5  clk = 1;
    #5  clk = 0;
    #5  clk = 1;
    #5  clk = 0;
    #5  clk = 1;
    #5  clk = 0;
    #5  clk = 1;
    #5  clk = 0;    
    #5  clk = 1;
    #5  clk = 0;
    #5  clk = 1;
    #5  clk = 0;
    #5  clk = 1;
    #5  clk = 0;
    #5  clk = 1;
    #5  clk = 0;
    #5  clk = 1;
    #5  clk = 0;
    #5  clk = 1;
    #5  clk = 0;
    #5  clk = 1;
    #5  clk = 0;    
    #5  clk = 1;
    #5  clk = 0;
    #5  clk = 1;
    #5  clk = 0;
    #5  clk = 1;
    #5  clk = 0;    
    #5  clk = 1;
    #5  clk = 0;
    #5  clk = 1;
    #5  clk = 0;
    #5  clk = 1;
    #5  clk = 0;
    #5  clk = 1;
    #5  clk = 0;
    #5  clk = 1;
    #5  clk = 0;
    #5  clk = 1;
    #5  clk = 0;    
    #5  clk = 1;
    #5  clk = 0;
    #5  clk = 1;
    #5  clk = 0;
    #5  clk = 1;
    #5  clk = 0;
    #5  clk = 1;
    #5  clk = 0;
    #5  clk = 1;
    #5  clk = 0;
    #5  clk = 1;
    #5  clk = 0;    
    #5  clk = 1;
    #5  clk = 0;
    #5  clk = 1;
    #5  clk = 0;
    #5  clk = 1;
    #5  clk = 0;
    $finish;
end

endmodule 