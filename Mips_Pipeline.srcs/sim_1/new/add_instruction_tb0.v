`timescale 1 ns/10 ps  // time-unit = 1 ns, precision = 10 ps

module add_instruction_tb0;
    
reg clk, reset;
reg [7:0] pc;
wire [26:0] out;

system uut(.SYS_clk(clk), .SYS_pc_val(pc), .SYS_leds(out));

initial begin
    reset = 1;
    #5  clk = 0;
        reset = 0;
        pc = 0;
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
