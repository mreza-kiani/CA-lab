module WB(
	input clk,
	input rst, 
	input [31:0] pc_in,
	input [31:0] ALU_result, 
	input wb_en,
	input mem_read,
	input [4:0] dest,
	output [31:0] pc_out,
	output wb_en_out,
	output [4:0] dest_out,
	output [31:0] wb_result
);

	MUX32 regMux(1'b0, ALU_result, 32'b0, wb_result);

	assign pc_out = pc_in;
	assign wb_en_out = wb_en;
	assign dest_out = dest;

endmodule