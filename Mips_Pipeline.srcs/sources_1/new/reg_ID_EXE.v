module reg_ID_EXE(
	input 	[31:0]	    reg_ID_EXE_rs_value_in,
	input	[31:0]	    reg_ID_EXE_rt_value_in,
	input	[7:0]	    reg_ID_EXE_PC_in,
	input 	[31:0]	    reg_ID_EXE_immediate,
	input 	[4:0]	    reg_ID_EXE_rt,
	input 	[4:0]	    reg_ID_EXE_rd,
	input 			    reg_ID_EXE_reg_dst_control_in,
	input 	[1:0]	    reg_ID_EXE_alu_op_control_in,
	input 			    reg_ID_EXE_alu_src_control_in,
	input 			    reg_ID_EXE_branch_control_in,
	input 			    reg_ID_EXE_mem_read_control_in,
	input 			    reg_ID_EXE_mem_write_control_in,
	input 			    reg_ID_EXE_reg_write_control_in,
	input 			    reg_ID_EXE_mem_to_reg_control_in,
	input 			    reg_ID_EXE_clk,
	input 			    reg_ID_EXE_reset,
	
	output 	reg		    reg_ID_EXE_branch_control_out,
	output 	reg		    reg_ID_EXE_mem_read_control_out,
	output 	reg		    reg_ID_EXE_mem_write_control_out,
	output 	reg		    reg_ID_EXE_reg_write_control_out,
	output 	reg		    reg_ID_EXE_mem_to_reg_control_out,
	output	reg [4:0]	reg_ID_EXE_write_register,
	output	reg [31:0]	reg_ID_EXE_alu_result,
	output	reg [7:0]	reg_ID_EXE_alu_status,
	output	reg [7:0]	reg_ID_EXE_branch_address,
	output 	reg [31:0]	reg_ID_EXE_rt_value_out
);

	always @(posedge reg_ID_EXE_clk or posedge reg_ID_EXE_reset) begin
		if (reg_ID_EXE_reset) begin
			reg_ID_EXE_branch_control_out 		<= 0;
			reg_ID_EXE_mem_read_control_out 	<= 0;
			reg_ID_EXE_mem_write_control_out 	<= 0;
			reg_ID_EXE_reg_write_control_out	<= 0;
			reg_ID_EXE_mem_to_reg_control_out 	<= 0;
			reg_ID_EXE_write_register			<= 0;
			reg_ID_EXE_alu_result				<= 0;
			reg_ID_EXE_alu_status				<= 0;
			reg_ID_EXE_branch_address			<= 0;
			reg_ID_EXE_rt_value_out				<= 0;
		end else begin
 			reg_ID_EXE_branch_control_out 		<= reg_ID_EXE_branch_control_in;
			reg_ID_EXE_mem_read_control_out 	<= reg_ID_EXE_mem_read_control_in;
			reg_ID_EXE_mem_write_control_out	<= reg_ID_EXE_mem_write_control_in;
			reg_ID_EXE_reg_write_control_out	<= reg_ID_EXE_reg_write_control_in;
			reg_ID_EXE_mem_to_reg_control_out 	<= reg_ID_EXE_mem_to_reg_control_in;
			reg_ID_EXE_write_register 			<= reg_ID_EXE_reg_dst_control_in ? reg_ID_EXE_rd : reg_ID_EXE_rt;
			reg_ID_EXE_alu_result				<= reg_ID_EXE_rs_value_in + reg_ID_EXE_rt_value_in; 
			reg_ID_EXE_alu_status				<= 0;
			reg_ID_EXE_branch_address			<= 0;
			reg_ID_EXE_rt_value_out				<= reg_ID_EXE_rt_value_in;
		end
	end

endmodule