module alu_control (
    input       [4:0]   rs_address,
    input       [4:0]   rd_address,
    input       [4:0]   shamt,
    input       [5:0]   funct,
    input       [2:0]   alu_op,

    output  reg [4:0]   control_out,
    output  reg         excep_control_out,
    output  reg         hilo_write,
    output  reg [1:0]   hilo_read
);

    always @(*) begin
        control_out         = 5'b0;
        excep_control_out   = 1'b0;
        hilo_write          = 1'b0;
        hilo_read           = 2'b0;

        case (alu_op)
            3'b011: begin               // R-TYPE
                case (funct)
                    6'b000000: begin    // SLL
                        if (rs_address == 0) begin
                            control_out         = 5'b00001;
                        end else begin
                            excep_control_out   = 1'b1;
                        end
                    end
                    6'b000010: begin    // SRL
                        if (rs_address == 0) begin
                            control_out         = 5'b01001;
                        end else begin
                            excep_control_out   = 1'b1;
                        end
                    end
                    6'b011000: begin    // MULT
                        if (rd_address == 0 && shamt == 0) begin
                            control_out         = 5'b00010;
                            hilo_write          = 1'b1;
                        end else begin
                            excep_control_out   = 1'b1;
                        end
                    end
                    6'b011010: begin    // DIV
                        if (rd_address == 0 && shamt == 0) begin
                            control_out         = 5'b11010;
                            hilo_write          = 1'b1;
                        end else begin
                            excep_control_out   = 1'b1;
                        end
                    end
                    6'b010000: begin    // MFHI
                        if (rs_address == 0 && shamt == 0) begin
                            hilo_read[1]        = 1'b1;
                        end else begin
                            excep_control_out   = 1'b1;
                        end
                    end
                    6'b010010: begin    // MFLO
                        if (rs_address == 0 && shamt == 0) begin
                            hilo_read[0]        = 1'b1;
                        end else begin
                            excep_control_out   = 1'b1;
                        end
                    end
                    6'b101010: begin    // SLT
                        if (shamt == 0) begin
                            control_out         = 5'b01011;
                        end else begin
                            excep_control_out   = 1'b1;
                        end
                    end
                    6'b100100: begin    // AND
                        if (shamt == 0) begin
                            control_out         = 5'b00100;
                        end else begin
                            excep_control_out   = 1'b1;
                        end
                    end
                    6'b100111: begin    // NOR
                        if (shamt == 0) begin
                            control_out         = 5'b11100;
                        end else begin
                            excep_control_out   = 1'b1;
                        end
                    end
                    6'b100101: begin    // OR
                        if (shamt == 0) begin
                            control_out         = 5'b00101;
                        end else begin
                            excep_control_out   = 1'b1;
                        end
                    end
                    6'b100110: begin    // XOR
                        if (shamt == 0) begin
                            control_out         = 5'b00110;
                        end else begin
                            excep_control_out   = 1'b1;
                        end
                    end
                    6'b100000: begin    // ADD
                        if (shamt == 0) begin
                            control_out         = 5'b00111;
                        end else begin
                            excep_control_out   = 1'b1;
                        end
                    end
                    6'b100010: begin    // SUB
                        if (shamt == 0) begin
                            control_out         = 5'b01111;
                        end else begin
                            excep_control_out   = 1'b1;
                        end
                    end
                    default: begin      // No instruction
                        excep_control_out   = 1'b1;
                    end
                endcase
            end
            3'b100: begin               // AND
                control_out             = 5'b00100;
            end
            3'b101: begin               // OR
                control_out             = 5'b00101;
            end
            3'b110: begin               // XOR
                control_out             = 5'b00110;
            end
            3'b111: begin               // ADD
                control_out             = 5'b00111;
            end
        endcase
    end
    
endmodule