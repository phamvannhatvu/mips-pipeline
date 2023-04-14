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

	//read without clock
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			data_out <= 0;
		end else begin
			if (mem_write) begin
				memory[address] 	<= data_in[31:24];
				memory[address + 1] <= data_in[23:16];
				memory[address + 2] <= data_in[15:8];
				memory[address + 3] <= data_in[7:0];
			end
		end
	end

	always @(*) begin
		if (mem_read && reset != 0) begin
			data_out[31:24] = memory[address];
			data_out[23:16] = memory[address + 1];
			data_out[15:8] = memory[address + 2];
			data_out[7:0] = memory[address + 3];
		end
	end
endmodule
