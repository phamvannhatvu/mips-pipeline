module IMEM (
	input		[7:0]	pc,
	input				reset,
	input				clk,

	output		[31:0]	instruction_out
);

	wire [5:0]	pc_word_addr = pc[7:2];
	wire		neg_clk = ~clk;

	imem_lib imem (
        .rsta(reset),
        .clka(neg_clk),
        .addra(pc_word_addr),
        
        .douta(instruction_out)
    );
	
endmodule