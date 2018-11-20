module Memory(
	input clk,
	input rst,
	input mem_read,
	input mem_write,
	input [31:0] data,
	input [5:0] address,
	output reg [31:0] mem_result
);
	reg [31:0] memory [63:0];

	always @(mem_read, address, memory[address]) begin
		if(mem_read)
			mem_result <= memory[address];
	end

	integer i;
	always @(posedge clk, posedge rst) begin
		if (rst) begin
			for (i = 0; i < 64; i = i + 1)
				memory[i] <= 0;
		end
		else if (mem_write) begin 
			memory[address] <= data;
		end
	end

endmodule