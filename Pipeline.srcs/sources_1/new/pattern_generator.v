module pattern_generator (
    input       [4:0] in,
    output  reg [7:0] out
);
    always @(in) begin
        case (in)
            0   : out <= 48; 
            1   : out <= 49;
            2   : out <= 50;
            3   : out <= 51;
            4   : out <= 52;
            5   : out <= 53;
            6   : out <= 54;
            7   : out <= 55;
            8   : out <= 56;
            9   : out <= 57;
            10  : out <= 65;
            11  : out <= 66;
            12  : out <= 67;
            13  : out <= 68;
            14  : out <= 69;
            15  : out <= 70;
            default : out <= 0;
        endcase
    end
endmodule