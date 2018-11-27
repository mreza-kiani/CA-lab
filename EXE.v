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
	input [1:0] sel_val1,
	input [1:0] sel_val2,
	input [1:0] sel_dest,
	input [31:0] data_MEM,
	input [31:0] data_WB,
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
	wire [31:0] data1_out, data2_out, mem_value_out;


	ALU alu(data1_out, data2_out, execute_cammand, ALU_result);
	ConditionCheck cc(br, data1_out, mem_value_out, br_select);
	
	MUX32_4 data1_mux(sel_val1, data1, data_MEM, data_WB, data1_out);
	MUX32_4 data2_mux(sel_val2, data2, data_MEM, data_WB, data2_out);
	MUX32_4 mem_value_mux(sel_dest, reg2, data_MEM, data_WB, mem_value_out);

	always @(*) begin
		br_pc <= pc_in + {data2_out[29:0], 2'b0};
	end

	assign pc_out = pc_in;
	assign wb_en_out = wb_en;
	assign mem_read_out = mem_read;
	assign mem_write_out = mem_write;
	assign dest_out = dest;
	assign reg2_out = mem_value_out;
	
endmodule