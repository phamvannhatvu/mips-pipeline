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
	input 	[31:0] 	DMEM_address,
	input 	[31:0] 	DMEM_data_in,
	input 			DMEM_mem_write,
	input 			DMEM_mem_read,
	output	[31:0] 	DMEM_data_out
);
endmodule
