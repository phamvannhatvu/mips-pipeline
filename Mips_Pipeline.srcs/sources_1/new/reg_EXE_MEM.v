module reg_EXE_MEM (
	input 			reg_EXE_MEM_branch_control_in,
	input 			reg_EXE_MEM_mem_read_control_in,
	input 			reg_EXE_MEM_mem_write_control_in,
	input 			reg_EXE_MEM_reg_write_control_in,
	input 			reg_EXE_MEM_mem_to_reg_control_in,
	input	[4:0]	reg_EXE_MEM_write_register_in,
	input	[31:0]	reg_EXE_MEM_alu_result_in,
	input	[7:0]	reg_EXE_MEM_alu_status,
	input	[7:0]	reg_EXE_MEM_branch_address_in,
	input 	[31:0]	reg_EXE_MEM_rt_value_in,
	input			reg_EXE_MEM_clk,
	input			reg_EXE_MEM_reset,
	
	output reg			reg_EXE_MEM_reg_write_control_out,
	output reg			reg_EXE_MEM_mem_to_reg_control_out,
	output reg	        reg_EXE_MEM_pc_source,
	output reg	[7:0]	reg_EXE_MEM_branch_address_out,
	output reg	[31:0]	reg_EXE_MEM_write_data,
	output reg	[7:0] 	reg_EXE_MEM_write_address,
	output reg	[4:0]	reg_EXE_MEM_write_register_out,
	output reg	[31:0]	reg_EXE_MEM_alu_result_out
);

	always @(posedge reg_EXE_MEM_clk or posedge reg_EXE_MEM_reset) begin
		if (reg_EXE_MEM_reset) begin
			reg_EXE_MEM_reg_write_control_out 	<= 0;
			reg_EXE_MEM_mem_to_reg_control_out	<= 0;
			reg_EXE_MEM_pc_source				<= 0;
			reg_EXE_MEM_branch_address_out 		<= 0;
			reg_EXE_MEM_write_data				<= 0;
			reg_EXE_MEM_write_address			<= 0;
			reg_EXE_MEM_write_register_out		<= 0;
			reg_EXE_MEM_alu_result_out			<= 0;
		end else begin
			reg_EXE_MEM_reg_write_control_out 	<= reg_EXE_MEM_reg_write_control_in;
			reg_EXE_MEM_mem_to_reg_control_out	<= reg_EXE_MEM_mem_to_reg_control_in;
			reg_EXE_MEM_pc_source				<= reg_EXE_MEM_branch_control_in & reg_EXE_MEM_alu_status[7];
			reg_EXE_MEM_branch_address_out 		<= reg_EXE_MEM_branch_address_in;
			reg_EXE_MEM_write_data				<= reg_EXE_MEM_rt_value_in;
			reg_EXE_MEM_write_address			<= reg_EXE_MEM_alu_result_in[7:0];
			reg_EXE_MEM_write_register_out		<= reg_EXE_MEM_write_register_in;
			reg_EXE_MEM_alu_result_out			<= reg_EXE_MEM_alu_result_in;
		end
	end
endmodule