 module RegisterFile(
 	input clk, 
 	input rst, 
 	input [4:0] src1, 
 	input [4:0] src2, 
 	input [4:0] dest,
 	input [31:0] write_value, 
 	input write_en, 
 	output reg [31:0] reg1, 
 	output reg [31:0] reg2
 );

	reg [31:0] registers [31:0];

	always @(src1, src2, registers[src1], registers[src2]) begin
		reg1 <= registers[src1];
		reg2 <= registers[src2];
	end

	integer i;
	always @(negedge clk, posedge rst) begin
		if (rst) begin
			for (i = 0; i < 32; i = i + 1)
				registers[i] <= i;
		end
		else if (write_en) begin 
			registers[dest] <= write_value;
		end
	end

endmodule