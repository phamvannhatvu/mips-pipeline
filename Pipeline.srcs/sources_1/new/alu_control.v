module alu_control (
    input       [5:0]   funct,
    input       [2:0]   alu_op,

    output  reg [4:0]   control_out,
    output  reg         exception_out,
    output  reg         mfhi_enable,
    output  reg         mflo_enable
);

    always @(*) begin
        control_out = 5'b0;
        exception_out = 1'b0;
        mfhi_enable = 1'b0;
        mflo_enable = 1'b0;

        if (alu_op == 3'b111) begin
            // R-TYPE
            case (funct)
                6'b100100: begin
                    // AND
                    control_out = 5'b00000;
                end
                6'b100111: begin
                    // NOR
                    control_out = 5'b11000;
                end
                6'b100101: begin
                    // OR
                    control_out = 5'b00001;
                end
                6'b100110: begin
                    // XOR
                    control_out = 5'b00010;
                end
                6'b100000: begin
                    // ADD
                    control_out = 5'b00011;
                end
                6'b100010: begin
                    // SUB
                    control_out = 5'b01011;
                end
                6'b101010: begin
                    // SLT
                    control_out = 5'b10011;
                end
                6'b011000: begin
                    // MULT
                    control_out = 5'b00100;
                end
                6'b011010: begin
                    // DIV
                    control_out = 5'b01100;
                end
                6'b000000: begin
                    // SLL
                    control_out = 5'b00101;
                end
                6'b000010: begin
                    // SRL
                    control_out = 5'b01101;
                end
                6'b000011: begin
                    // SRA
                    control_out = 5'b11101;
                end
                6'b010000: begin
                    // MFHI
                    mfhi_enable = 1'b1;
                end
                6'b010010: begin
                    // MFLO
                    mflo_enable = 1'b1;
                end
                default: begin
                    // Exception: Out of instruction set
                    exception_out = 1'b1;
                end
            endcase
        end else if (alu_op == 3'b100) begin
            // ADD and check if MOD2
            control_out = 5'b01111;
        end else if (alu_op == 3'b101) begin
            // ADD and check if MOD4
            control_out = 5'b10111;
        end else if (alu_op == 3'b110) begin
            // ADD and check if ZERO
            control_out = 5'b00110;
        end else begin
            control_out = {2'b00, alu_op};
        end
    end
    
endmodule