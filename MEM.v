module MEM(
	input clk,
	input rst,
	input [31:0] pcIn,
	input [31:0] ALU_result,
	input wb_en,
	input mem_read,
	input mem_write,
	input [4:0] dest,
	input [31:0] reg2,
	inout [15:0] SRAM_DQ,
	output [17:0] SRAM_ADDR,
	output SRAM_WE_N,
	output [31:0] pcOut,
	output [31:0] ALU_result_out,
	output wb_en_out,
	output mem_read_out,
	output [4:0] dest_out,
	output [31:0] mem_result,
	output freeze
);

	//wire[5:0] address;
	wire[17:0] address;

	SRAM_AddressMapping S_AM(ALU_result, address);
	SRAM_Controller S_Cntr(clk, rst, mem_read, mem_write, reg2, address, SRAM_DQ, SRAM_ADDR, SRAM_WE_N, mem_result, freeze);
	// AddressMapping AM(ALU_result, address);
	// Memory mem(clk, rst, mem_read, mem_write, reg2, address, mem_result);

	assign pcOut = pcIn;
	assign ALU_result_out = ALU_result;
	assign wb_en_out = wb_en;
	assign mem_read_out = mem_read;
	assign dest_out = dest;

endmodule