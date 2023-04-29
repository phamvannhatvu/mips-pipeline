module DMEM (
	input		[31:0]	address,
	input		[31:0]	data_in,
	input		[1:0]	mem_write,
	input		[1:0]	mem_read,
	input				clk,
	input				reset,

	output	reg [31:0]	data_out
);

	// Same as IMEM: 2^8 words
	reg [7:0]	memory [0:1023];
    
	// Write with clock
	always @(posedge clk or posedge reset) begin
	    if (reset) begin
			memory[0] <= 8'h00;
			memory[1] <= 8'h00;
			memory[2] <= 8'h00;
			memory[3] <= 8'h64;
			memory[4] <= 8'h00;
			memory[5] <= 8'h00;
			memory[6] <= 8'h00;
			memory[7] <= 8'h65;
	    end else if (mem_write == 2'b01) begin
            memory[address]		<= data_in[7:0];
        end else if (mem_write == 2'b10) begin
            memory[address]		<= data_in[15:8];
            memory[address + 1]	<= data_in[7:0];
        end else if (mem_write == 2'b11) begin
            memory[address]		<= data_in[31:24];
            memory[address + 1]	<= data_in[23:16];
            memory[address + 2]	<= data_in[15:8];
            memory[address + 3]	<= data_in[7:0];
        end
    end
    
    // Read with clock
	always @(negedge clk or posedge reset) begin
	    if (reset) begin
			data_out		<= 32'b0;
	    end else if (mem_read == 2'b01) begin
			data_out[31:24]	<= 0;
			data_out[23:16]	<= 0;
			data_out[15:8]	<= 0;
			data_out[7:0]	<= memory[address];
		end else if (mem_read == 2'b10) begin
			data_out[31:24]	<= 0;
			data_out[23:16]	<= 0;
			data_out[15:8]	<= memory[address];
			data_out[7:0]	<= memory[address + 1];
		end else if (mem_read == 2'b11) begin
			data_out[31:24]	<= memory[address];
			data_out[23:16]	<= memory[address + 1];
			data_out[15:8]	<= memory[address + 2];
			data_out[7:0]	<= memory[address + 3];
		end
	end

endmodule