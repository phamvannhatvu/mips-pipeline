module alu_control (
    input       [5:0]   funct,
    input       [2:0]   alu_op,

    output  reg [4:0]   control_out,
    output  reg         exception_out,
    output  reg         hilo_write,
    output  reg [1:0]   hilo_read
);

    always @(*) begin
        control_out     = 5'b0;
        exception_out   = 1'b0;
        hilo_write      = 1'b0;
        hilo_read       = 2'b0;

        case (alu_op)
            3'b011: begin               // R-TYPE
                case (funct)
                    6'b000000: begin    // SLL
                        control_out     = 5'b00001;
                    end
                    6'b000010: begin    // SRL
                        control_out     = 5'b01001;
                    end
                    6'b000011: begin    // SRA
                        control_out     = 5'b11001;
                    end
                    6'b011000: begin    // MULT
                        control_out     = 5'b00010;
                        hilo_write      = 1'b1;
                    end
                    6'b011010: begin    // DIV
                        control_out     = 5'b11010;
                        hilo_write      = 1'b1;
                    end
                    6'b010000: begin    // MFHI
                        hilo_read[1]    = 1'b1;
                    end
                    6'b010010: begin    // MFLO
                        hilo_read[0]    = 1'b1;
                    end
                    6'b101010: begin    // SLT
                        control_out     = 5'b01011;
                    end
                    6'b100100: begin    // AND
                        control_out     = 5'b00100;
                    end
                    6'b100111: begin    // NOR
                        control_out     = 5'b11100;
                    end
                    6'b100101: begin    // OR
                        control_out     = 5'b00101;
                    end
                    6'b100110: begin    // XOR
                        control_out     = 5'b00110;
                    end
                    6'b100000: begin    // ADD
                        control_out     = 5'b00111;
                    end
                    6'b100010: begin    // SUB
                        control_out     = 5'b01111;
                    end
                    default: begin      // No instruction
                        exception_out   = 1'b1;
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
