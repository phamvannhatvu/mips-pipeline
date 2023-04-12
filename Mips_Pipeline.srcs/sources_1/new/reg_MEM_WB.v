module reg_MEM_WB(
	input 			reg_MEM_WB_reg_write_control_in,
	input			reg_MEM_WB_mem_to_reg_control_in,
	input	[31:0]	reg_MEM_WB_read_data,
	input 	[31:0]	reg_MEM_WB_alu_result,
	input	[4:0]	reg_MEM_WB_write_register_in,
	input			reg_MEM_WB_clk,
	input			reg_MEM_WB_reset,
	
	output  reg			reg_MEM_WB_reg_write_control_out,
	output	reg [31:0]	reg_MEM_WB_write_data,
	output	reg [4:0]	reg_MEM_WB_write_register_out
);
	always @(posedge reg_MEM_WB_reset or posedge reg_MEM_WB_clk) begin
		if (reg_MEM_WB_reset) begin
			reg_MEM_WB_reg_write_control_out	<= 0;
			reg_MEM_WB_write_data				<= 0;
			reg_MEM_WB_write_register_out		<= 0;
		end else begin
			reg_MEM_WB_reg_write_control_out	<= reg_MEM_WB_reg_write_control_in;
			reg_MEM_WB_write_data				<= reg_MEM_WB_mem_to_reg_control_in ? reg_MEM_WB_read_data : reg_MEM_WB_alu_result;
			reg_MEM_WB_write_register_out		<= reg_MEM_WB_write_register_in;
		end
	end
endmodule