module ID(
	input clk,
	input rst, 
	input [31:0] pc_in, 
	input [31:0] inst,
	input [4:0] dest_address,
	input write_en,
	input [31:0] write_value,
	input freeze, 
	output [31:0] pc_out,
	output wb_en,
	output mem_read,
	output mem_write,
	output [1:0] br,
	output [3:0] execute_cammand,
	output [31:0] data1,
	output [31:0] data2,
	output [31:0] reg2,
	output [4:0] out_dest,
	output src2_check,
	output [4:0] src1,
	output [4:0] src2_out
);

	wire [5:0] opcode;
	wire [4:0] dest, src2;
	wire [15:0] imm;

	wire is_imm;
	wire [31:0] imm_out; 

	wire temp_wb_en, temp_mem_read, temp_mem_write;
	wire [3:0] temp_execute_cammand;
	wire [1:0] temp_br;

	assign opcode = inst[31:26];
	assign src1 = inst[25:21];
	assign src2 = inst[20:16];
	assign dest = inst[15:11];
	assign imm = inst[15:0];
	assign src2_out = is_imm ? 5'b0 : src2;

	ControlUnit CU(opcode, temp_mem_read, temp_mem_write, temp_wb_en, is_imm, temp_br, temp_execute_cammand, src2_check);
	RegisterFile RF(clk, rst, src1, src2, dest_address, write_value, write_en, data1, reg2);
	SignExtend SE(imm, imm_out);
	MUX32 Reg2Mux(is_imm, reg2, imm_out, data2);
	MUX5 DestMux(is_imm, dest, src2, out_dest);
	MUX9 HazardMux(freeze, {temp_wb_en, temp_mem_read, temp_mem_write, temp_br, temp_execute_cammand}, 9'b0,
					{wb_en, mem_read, mem_write, br, execute_cammand});

	assign pc_out = pc_in;
endmodule