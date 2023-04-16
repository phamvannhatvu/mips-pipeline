`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/06/2023 06:13:14 PM
// Design Name: 
// Module Name: DMEM
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module DMEM(
	input 	[31:0] 	address,
	input 	[31:0] 	data_in,
	input 			mem_write,
	input 			mem_read,
	input			clk,
	input			reset,

	output reg [31:0] 	data_out
);
	//same as IMEM: 2^8 words
	reg [7:0] memory [0:1023];
    
    initial begin
        memory[16] = 8'h6a;
        memory[17] = 8'h44;
        memory[18] = 8'h21;
        memory[19] = 8'hb0;
    end
	//read without clock
	always @(posedge clk) begin
        if (mem_write && reset == 0) begin
            memory[address] 	<= data_in[31:24];
            memory[address + 1] <= data_in[23:16];
            memory[address + 2] <= data_in[15:8];
            memory[address + 3] <= data_in[7:0];
        end
    end

	always @(*) begin
	    if (reset) begin
	       data_out = 0;
	    end else if (mem_read) begin
			data_out[31:24] = memory[address];
			data_out[23:16] = memory[address + 1];
			data_out[15:8] = memory[address + 2];
			data_out[7:0] = memory[address + 3];
		end
	end
endmodule
