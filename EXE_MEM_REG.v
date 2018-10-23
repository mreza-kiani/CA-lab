module EXE_MEM_REG(
	input clk,
	input rst,
	input [31:0] pcIn,
	input [31:0] ALU_result,
	input wb_en,
	input mem_read,
	input mem_write,
	input [4:0] dest,
	output reg[31:0] pcOut,
	output reg[31:0] ALU_result_out,
	output reg wb_en_out,
	output reg mem_read_out,
	output reg mem_write_out,
	output reg [4:0] dest_out
);

	always@(posedge clk, posedge rst) begin
		if(rst) begin
			pcOut <= 32'b0;
			ALU_result_out <= 32'b0;
			wb_en_out <= 1'b0;
			mem_read_out <= 1'b0;
			mem_write_out <= 1'b0;
			dest_out <= 5'b0;
		end
		else begin
			pcOut <= pcIn;
			ALU_result_out <= ALU_result;
			wb_en_out <= wb_en;
			mem_read_out <= mem_read;
			mem_write_out <= mem_write;
			dest_out <= dest;
		end
	end

endmodule