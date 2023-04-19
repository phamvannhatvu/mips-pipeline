module DMEM (
	input		[31:0]	address,
	input		[31:0]	data_in,
	input				mem_write,
	input				mem_read,
	input				clk,
	input				reset,

	output	reg [31:0]	data_out
);

	// Same as IMEM: 2^8 words
	reg [7:0] memory [0:1023];
    
    initial begin
        memory[16] = 8'h6a;
        memory[17] = 8'h44;
        memory[18] = 8'h21;
        memory[19] = 8'hb0;
    end
    
	// Write with clock
	always @(posedge clk or posedge reset) begin
	    if (reset) begin
            memory[address]		<= memory[address];
            memory[address + 1]	<= memory[address + 1];
            memory[address + 2]	<= memory[address + 2];
            memory[address + 3]	<= memory[address + 3];
	    end else if (mem_write) begin
            memory[address]		<= data_in[31:24];
            memory[address + 1]	<= data_in[23:16];
            memory[address + 2]	<= data_in[15:8];
            memory[address + 3]	<= data_in[7:0];
        end
    end
    
    // Read with clock
	always @(negedge clk) begin
	    if (reset) begin
			data_out		= 32'b0;
	    end else if (mem_read) begin
			data_out[31:24]	= memory[address];
			data_out[23:16]	= memory[address + 1];
			data_out[15:8]	= memory[address + 2];
			data_out[7:0]	= memory[address + 3];
		end
	end

endmodule