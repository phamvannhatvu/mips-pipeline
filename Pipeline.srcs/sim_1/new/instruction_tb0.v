`timescale 1 ns / 10 ps  // time-unit = 1 ns, precision = 10 ps

module instruction_tb0;
    
reg clk, reset;
reg [7:0] pc;
wire [26:0] out;

system uut(.SYS_clk(clk), .SYS_pc_val(pc), .SYS_reset(reset), .SYS_leds(out));

always #5 clk = ~ clk;

initial begin
    clk = 0;
    reset = 1;
    pc = 0;
    #13  reset = 0;
    #140 reset = 1;
    #180 reset = 0;
    #220 $finish;
end

endmodule 