module forward_unit (
    input               exe_mem_reg_write,
    input       [4:0]   exe_mem_address_write,
    input               mem_wb_reg_write,
    input       [4:0]   mem_wb_address_write,
    input       [1:0]   mem_write_control,

    input       [4:0]   id_exe_address_rs,
    input               id_exe_regdst_control,
    input       [4:0]   id_exe_address_rt,

    output  reg [1:0]   operand_0_control,
    output  reg [1:0]   operand_1_control,
    output  reg [1:0]   write_address_control
);

    always @(*) begin
        if (exe_mem_reg_write == 1'b1 && exe_mem_address_write != 5'b0 && exe_mem_address_write == id_exe_address_rs) begin
            operand_0_control = 2'b01;
        end else if (mem_wb_reg_write == 1'b1 && mem_wb_address_write != 5'b0 && mem_wb_address_write == id_exe_address_rs) begin
            operand_0_control = 2'b10;
        end else begin
            operand_0_control = 2'b00;
        end

        if (exe_mem_reg_write == 1'b1 && exe_mem_address_write != 5'b0 && id_exe_regdst_control == 1'b1 && exe_mem_address_write == id_exe_address_rt) begin
            operand_1_control = 2'b01;
        end else if (mem_wb_reg_write == 1'b1 && mem_wb_address_write != 5'b0 && id_exe_regdst_control == 1'b1 && mem_wb_address_write == id_exe_address_rt) begin
            operand_1_control = 2'b10;
        end else begin
            operand_1_control = 2'b00;
        end

        if (mem_write_control != 2'b00) begin
                if (exe_mem_reg_write == 1'b1 && exe_mem_address_write != 5'b0 && exe_mem_address_write == id_exe_address_rt) begin
                    write_address_control = 2'b01;
                end else if (mem_wb_reg_write == 1'b1 && mem_wb_address_write != 5'b0 && mem_wb_address_write == id_exe_address_rt) begin
                    write_address_control = 2'b10;
                end else begin
                    write_address_control = 2'b00;
                end   
        end else begin
            write_address_control = 2'b00;
        end
    end

endmodule