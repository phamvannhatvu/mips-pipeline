module system_control (
	input		[3:0]	SYS_output_sel,
    input       [31:0]  imem_instruction,
    input       [31:0]  reg_rs_value,
    input       [31:0]  reg_rt_value,
    input       [7:0]   id_pc_calculated,
    input       [31:0]  alu_operand_0,
    input       [31:0]  alu_operand_1,
    input       [31:0]  alu_out,
    input       [31:0]  hilo_reg_out,
    input       [31:0]  exe_out,
    input       [31:0]  exe_write_data,
    input       [7:0]   alu_status,
    input       [31:0]  dmem_data,
    input       [13:0]  control,
    input       [4:0]   alu_control,
    input       [7:0]   pc,
    input       [7:0]   epc,

    output  reg [31:0]  SYS_led
);

    always @(*) begin
        SYS_led = 0;

        case (SYS_output_sel)
            4'b0000: begin
                SYS_led         = imem_instruction;
            end
            4'b0001: begin
                SYS_led         = reg_rs_value;
            end
            4'b0010: begin
                SYS_led         = reg_rt_value;
            end
            4'b0011: begin
                SYS_led         = {24'b0, id_pc_calculated};
            end
            4'b0100: begin
                SYS_led         = alu_operand_0;
            end
            4'b0101: begin
                SYS_led         = alu_operand_1;
            end
            4'b0110: begin
                SYS_led         = alu_out;
            end
            4'b0111: begin
                SYS_led         = hilo_reg_out;
            end
            4'b1000: begin
                SYS_led         = exe_out;
            end
            4'b1001: begin
                SYS_led         = exe_write_data;
            end
            4'b1010: begin
                SYS_led         = {24'b0, alu_status};
            end
            4'b1011: begin
                SYS_led         = dmem_data;
            end
            4'b1100: begin
                SYS_led         = {18'b0, control};
            end
            4'b1101: begin
                SYS_led         = {28'b0, alu_control};
            end
            4'b1110: begin
                SYS_led         = {24'b0, pc};
            end
            4'b1111: begin
                SYS_led         = {24'b0, epc};
            end
        endcase
    end

endmodule