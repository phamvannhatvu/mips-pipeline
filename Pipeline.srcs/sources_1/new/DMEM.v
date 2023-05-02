module DMEM (
	input		[7:0]	address,
	input		[31:0]	data_in,
	input		[1:0]	mem_write,
	input		[1:0]	mem_read,
	input				clk,
	input				reset,

	output reg	[31:0]	data_out
);
	wire read_enable = (mem_read != 2'b00);
	reg [31:0] data_write_in;
	wire neg_clk = ~clk;
	wire [5:0] word_address = address[7:2];
	wire [31:0] data_word_out;
	wire write_enable = (mem_write != 2'b00);
	reg [3:0] wea;

	dmem_lib dmem (
		//a: write
		.addra(word_address),
		.clka(clk),
		.rsta(reset),
		.dina(data_write_in),
		.ena(write_enable),
		.wea(wea),

		//b: read
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
			2'b11	: data_out = data_word_out;
			2'b10	: data_out = {16'b0, address[1] == 1'b0 ? data_word_out[31:16] : data_word_out[15:0]};
			2'b01	: 
				case (address[1:0])
					2'b00 : data_out = {24'b0, data_word_out[31:24]};
					2'b01 : data_out = {24'b0, data_word_out[23:16]};
					2'b10 : data_out = {24'b0, data_word_out[15:8]};
					2'b11 : data_out = {24'b0, data_word_out[7:0]};
				endcase
			default	: data_out = 0;
		endcase
	end

	always @(*) begin
		case (mem_write)
			2'b11	: begin
				wea = 4'b1111;
				data_write_in = data_in;
			end
			2'b10	: begin
				if (address[1] == 1'b0) begin
					wea = 4'b1100;
					data_write_in = data_in << 16;
				end else begin
					wea = 4'b0011;
					data_write_in = data_in;
				end
			end
			2'b01	: begin
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
			default	: begin
				data_write_in = 0;
				wea = 0;
			end 
		endcase
	end
	// // Same as IMEM: 2^8 words
	// reg [7:0]	memory [0:1023];
    
	// // Write with clock
	// always @(posedge clk or posedge reset) begin
	//     if (reset) begin
	// 		memory[0]			<= 8'h00;
	// 		memory[1]			<= 8'h00;
	// 		memory[2]			<= 8'h00;
	// 		memory[3]			<= 8'h64;
	// 		memory[4]			<= 8'h00;
	// 		memory[5]			<= 8'h00;
	// 		memory[6]			<= 8'h00;
	// 		memory[7]			<= 8'h65;
	//     end else if (mem_write == 2'b01) begin
    //         memory[address]		<= data_in[7:0];
    //     end else if (mem_write == 2'b10) begin
    //         memory[address]		<= data_in[15:8];
    //         memory[address + 1]	<= data_in[7:0];
    //     end else if (mem_write == 2'b11) begin
    //         memory[address]		<= data_in[31:24];
    //         memory[address + 1]	<= data_in[23:16];
    //         memory[address + 2]	<= data_in[15:8];
    //         memory[address + 3]	<= data_in[7:0];
    //     end
    // end
    
    // // Read with clock
	// always @(negedge clk or posedge reset) begin
	//     if (reset) begin
	// 		data_out			<= 32'b0;
	//     end else if (mem_read == 2'b01) begin
	// 		data_out[31:24]		<= 0;
	// 		data_out[23:16]		<= 0;
	// 		data_out[15:8]		<= 0;
	// 		data_out[7:0]		<= memory[address];
	// 	end else if (mem_read == 2'b10) begin
	// 		data_out[31:24]		<= 0;
	// 		data_out[23:16]		<= 0;
	// 		data_out[15:8]		<= memory[address];
	// 		data_out[7:0]		<= memory[address + 1];
	// 	end else if (mem_read == 2'b11) begin
	// 		data_out[31:24]		<= memory[address];
	// 		data_out[23:16]		<= memory[address + 1];
	// 		data_out[15:8]		<= memory[address + 2];
	// 		data_out[7:0]		<= memory[address + 3];
	// 	end
	// end

endmodule