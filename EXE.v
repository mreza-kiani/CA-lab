module EXE(
	input clk, 
	input rst, 
	input [31:0] pc_in,
	input wb_en,
	input mem_read,
	input mem_write,
	input [1:0] br,
	input [3:0] execute_cammand,
	input [31:0] data1,
	input [31:0] data2,
	input [31:0] reg2,
	input [4:0] dest,
	output [31:0] pc_out,
	output br_select,
	output reg [31:0] br_pc,
	output [31:0] ALU_result,
	output wb_en_out,
	output mem_read_out,
	output mem_write_out,
	output [4:0] dest_out,
	output [31:0] reg2_out
);

	ALU alu(data1, data2, execute_cammand, ALU_result);
	ConditionCheck cc(br, data1, reg2, br_select);

	always @(*) begin
		br_pc <= pc_in + {data2[29:0], 2'b0};
	end

	assign pc_out = pc_in;
	assign wb_en_out = wb_en;
	assign mem_read_out = mem_read;
	assign mem_write_out = mem_write;
	assign dest_out = dest;
	assign reg2_out = reg2;
	
endmodule