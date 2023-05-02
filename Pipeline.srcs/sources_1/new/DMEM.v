module DMEM (
	input		[7:0]	address,
	input		[31:0]	data_in,
	input		[1:0]	mem_write,
	input		[1:0]	mem_read,
	input				clk,
	input				reset,

	output reg	[31:0]	data_out
);

	wire		read_enable = (mem_read != 2'b00);
	wire		write_enable = (mem_write != 2'b00);
	wire [5:0]	word_address = address[7:2];
	wire [31:0]	data_word_out;
	wire		neg_clk = ~clk;

	reg [31:0]	data_write_in;
	reg [3:0]	wea;

	dmem_lib dmem (
		// a: write
		.addra(word_address),
		.clka(clk),
		.rsta(reset),
		.dina(data_write_in),
		.ena(write_enable),
		.wea(wea),

		// b: read
		.addrb(word_address),
		.clkb(neg_clk),
		.rstb(reset),
		.dinb(0),
		.enb(read_enable),
		.web(4'b0),

		.doutb(data_word_out)
	);

	always @(*) begin
		case (mem_read)
			2'b11: begin
				data_out = data_word_out;
			end
			2'b10: begin
				data_out = {16'b0, address[1] == 1'b0 ? data_word_out[31:16] : data_word_out[15:0]};
			end
			2'b01: begin
				case (address[1:0])
					2'b00 : data_out = {24'b0, data_word_out[31:24]};
					2'b01 : data_out = {24'b0, data_word_out[23:16]};
					2'b10 : data_out = {24'b0, data_word_out[15:8]};
					2'b11 : data_out = {24'b0, data_word_out[7:0]};
				endcase
			end
			default: begin
				data_out = 0;
			end
		endcase
	end

	always @(*) begin
		case (mem_write)
			2'b11: begin
				wea = 4'b1111;
				data_write_in = data_in;
			end
			2'b10: begin
				if (address[1] == 1'b0) begin
					wea = 4'b1100;
					data_write_in = data_in << 16;
				end else begin
					wea = 4'b0011;
					data_write_in = data_in;
				end
			end
			2'b01: begin
				case (address[1:0])
					2'b00 : begin
						data_write_in = data_in << 24;
						wea = 4'b1000;
					end 
					2'b01 : begin
						data_write_in = data_in << 16;
						wea = 4'b0100;
						
					end 
					2'b10 : begin
						data_write_in = data_in << 8;
						wea = 4'b0010;
					end 
					2'b11 : begin
						data_write_in = data_in;
						wea = 4'b0001;
					end 
				endcase
			end
			default: begin
				data_write_in = 0;
				wea = 0;
			end
		endcase
	end

endmodule