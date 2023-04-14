module reg_ID_EXE(
	input 	[31:0]	    rs_value_in,
	input	[31:0]	    rt_value_in,
	input	[7:0]	    pc_in,
	input 	[31:0]	    immediate_in,
	input 	[4:0]	    rt_in,
	input 	[4:0]	    rd_in,

	input 	[10:0]		control_in,
	
	input 			    clk,
	input 			    reset,
	
	output 	reg		    reg_dst_control_out,
	output 	reg [1:0]	alu_op_control_out,
	output 	reg		    alu_src_control_out,

	output 	reg	[2:0]   mem_control_out,
	output 	reg	[1:0]   wb_control_out,

	output 	reg [31:0]	rs_value_out,
	output 	reg [31:0]	rt_value_out,
	output 	reg [31:0]	immediate_out,
	output  reg	[7:0]	pc_out,
	output 	reg [4:0]	rt_out,
	output 	reg [4:0]	rd_out
);

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			reg_dst_control_out		<= 0;
			alu_op_control_out		<= 0;
			alu_src_control_out		<= 0;

			mem_control_out 		<= 0;
			wb_control_out			<= 0;

			rs_value_out			<= 0;
			rt_value_out			<= 0;
			immediate_out			<= 0;
			pc_out					<= 0;
			rt_out					<= 0;
			rd_out					<= 0;
		end else begin
			reg_dst_control_out		<= control_in[3];
			alu_op_control_out		<= control_in[6:5];
			alu_src_control_out		<= control_in[4];

 			mem_control_out			<= control_in[9:7];
			wb_control_out			<= control_in[1:0];

			rs_value_out			<= rs_value_in;
			rt_value_out			<= rt_value_in;
			immediate_out			<= immediate_in;
			pc_out					<= pc_in;
			rt_out					<= rt_in;
			rd_out					<= rd_in;
		end
	end

endmodule