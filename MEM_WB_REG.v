module MEM_WB_REG(
	input clk,
	input rst,
	input [31:0] pc_in,
	input [31:0] ALU_result, 
	input wb_en,
	input mem_read,
	input [4:0] dest,
	input [31:0] mem_result,
	input freeze,
	output reg[31:0] pc_out,
	output reg[31:0] ALU_result_out,
	output reg wb_en_out,
	output reg mem_read_out,
	output reg [4:0] dest_out,
	output reg [31:0] mem_result_out
);

	always@(posedge clk, posedge rst) begin
		if(rst) begin
			pc_out <= 32'b0;
			ALU_result_out <= 32'b0;
			wb_en_out <= 1'b0;
			mem_read_out <= 1'b0;
			dest_out <= 5'b0;
			mem_result_out <= 32'b0;
		end
		else if(freeze == 1'b0) begin
			pc_out <= pc_in;
			ALU_result_out <= ALU_result;
			wb_en_out <= wb_en;
			mem_read_out <= mem_read;
			dest_out <= dest;
			mem_result_out <= mem_result;
		end
	end

endmodule