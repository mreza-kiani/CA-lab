 module RegisterFile(
 	input clk, 
 	input rst, 
 	input [4:0] src1, 
 	input [4:0] src2, 
 	input [4:0] dest,
 	input [31:0] write_value, 
 	input write_en, 
 	output [31:0] reg1, 
 	output [31:0] reg2
 );
	reg [31:0] registers [31:0];

	integer i;
	always @(negedge clk, posedge rst) begin
		if (rst) begin
			for (i = 0; i < 32; i = i + 1)
				registers[i] = i;
		end
		else if (write_en) begin 
			registers[dest] = write_value;
		end
	end
	assign reg1 = registers[src1];
	assign reg2 = registers[src2];

endmodule