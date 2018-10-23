module ID(
	input clk,
	input rst, 
	input [31:0] pc_in, 
	input [31:0] inst,
	input [4:0] dest_address,
	input write_en,
	input [31:0] write_value, 
	output [31:0] pc_out,
	output wb_en,
	output mem_read,
	output mem_write,
	output [1:0] br,
	output [3:0] execute_cammand,
	output [31:0] data1,
	output [31:0] data2,
	output [31:0] reg2,
	output [4:0] out_dest
);

	wire [5:0] opcode;
	wire [4:0] src1, src2, dest;
	wire [15:0] imm;

	wire is_imm;
	wire [31:0] imm_out; 

	assign opcode = inst[31:26];
	assign src1 = inst[25:21];
	assign src2 = inst[20:16];
	assign dest = inst[15:11];
	assign imm = inst[15:0];

	ControlUnit CU(opcode, mem_read, mem_write, wb_en, is_imm, br, execute_cammand);
	RegisterFile RF(clk, rst, src1, src2, dest_address, write_value, write_en, data1, reg2);
	SignExtend SE(imm, imm_out);
	MUX32 Reg2Mux(is_imm, reg2, imm_out, data2);
	MUX5 DestMux(is_imm, dest, src2, out_dest);

	assign pc_out = pc_in;
endmodule