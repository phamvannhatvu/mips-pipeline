module lcd_control (
    input [7:0]     pc,
    input [3:0]     out_sel,
    input [31:0]    out_val,
    input           BOARD_clk,
    input           reset,
    input           SYS_clk,

    output reg [7:0]    data,
    output reg          rs,
    output reg          enable
);
    //freq divider
    reg [20:0] count;
    always @(posedge BOARD_clk or posedge reset) begin
        if (reset) begin
            count    <= 0;
            enable     <= 0;
        end else begin
            if (count == 1300000 - 1) begin
                enable <= ~enable;
                count <= 0;
            end else count <= count + 1;
        end
    end

    //pattern: PC:xx Sel:x-Out:xxxxxxxx
    reg [1:0]   state;
    reg [4:0]   idx; 

    wire [7:0] pattern_pc0;
    wire [7:0] pattern_pc1;
    wire [7:0] pattern_sel;
    wire [7:0] pattern_out0;
    wire [7:0] pattern_out1;
    wire [7:0] pattern_out2;
    wire [7:0] pattern_out3;
    wire [7:0] pattern_out4;
    wire [7:0] pattern_out5;
    wire [7:0] pattern_out6;
    wire [7:0] pattern_out7;

    pattern_generator gen_pc0(
        .in(pc[7:4]),
        .out(pattern_pc0)
    );
    
    pattern_generator gen_pc1(
        .in(pc[3:0]),
        .out(pattern_pc1)
    );
    
    pattern_generator gen_sel(
        .in(out_sel),
        .out(pattern_sel)
    );
    
    pattern_generator gen_out0(
        .in(out_val[31:28]),
        .out(pattern_out0)
    );
    
    pattern_generator gen_out1(
        .in(out_val[27:24]),
        .out(pattern_out1)
    );
    
    pattern_generator gen_out2(
        .in(out_val[23:20]),
        .out(pattern_out2)
    );
    
    pattern_generator gen_out3(
        .in(out_val[19:16]),
        .out(pattern_out3)
    );
    
    pattern_generator gen_out4(
        .in(out_val[15:12]),
        .out(pattern_out4)
    );
    
    pattern_generator gen_out5(
        .in(out_val[11:8]),
        .out(pattern_out5)
    );
    
    pattern_generator gen_out6(
        .in(out_val[7:4]),
        .out(pattern_out6)
    );
    
    pattern_generator gen_out7(
        .in(out_val[3:0]),
        .out(pattern_out7)
    );

    always @(posedge enable or posedge reset) begin
        if (reset || SYS_clk) begin
            state   <= 2'b00;
            idx     <= 0;
            rs      <= 0;
            data    <= 0;
        end else begin
            if (state == 2'b00) begin //set 2 lines 
                rs      <= 0; 
                state <= 2'b01;
                data    <= 8'b00111000;
            end else if (state == 2'b01) begin //turn on cursor
                rs      <= 0;
                state   <= 2'b10;
                data    <= 8'b00001111;
            end else if (state == 2'b10) begin //clear
                rs      <= 0;
                state   <= 2'b11;
                data    <= 8'b00000001;
                idx     <= 0;
            end else begin
                if (idx == 25) begin
                    rs <= 0; data <= 8'b00001100;
                end else begin
                    case (idx)
                        0   : begin rs <= 1; data <= 8'b01010000; end
                        1   : begin rs <= 1; data <= 8'b01000011; end
                        2   : begin rs <= 1; data <= 8'b00111010; end
                        3   : begin rs <= 1; data <= pattern_pc0; end
                        4   : begin rs <= 1; data <= pattern_pc1; end
                        5   : begin rs <= 1; data <= 8'b00010000; end
                        6   : begin rs <= 1; data <= 8'b00010000; end
                        7   : begin rs <= 1; data <= 8'b01010011; end
                        8   : begin rs <= 1; data <= 8'b01100101; end
                        9   : begin rs <= 1; data <= 8'b01101100; end
                        10  : begin rs <= 1; data <= 8'b00111010; end
                        11  : begin rs <= 1; data <= pattern_sel; end
                        12  : begin rs <= 0; data <= 8'b11000000; end
                        13  : begin rs <= 1; data <= 8'b01001111; end
                        14  : begin rs <= 1; data <= 8'b01110101; end
                        15  : begin rs <= 1; data <= 8'b01110100; end
                        16  : begin rs <= 1; data <= 8'b00111010; end
                        17  : begin rs <= 1; data <= pattern_out0; end
                        18  : begin rs <= 1; data <= pattern_out1; end
                        19  : begin rs <= 1; data <= pattern_out2; end
                        20  : begin rs <= 1; data <= pattern_out3; end
                        21  : begin rs <= 1; data <= pattern_out4; end
                        22  : begin rs <= 1; data <= pattern_out5; end
                        23  : begin rs <= 1; data <= pattern_out6; end
                        24  : begin rs <= 1; data <= pattern_out7; end
                    endcase
                    idx <= idx + 1;
                end
            end
        end
    end
endmodule