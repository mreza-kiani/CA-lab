module ID_EXE_REG(
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
	input flush,
	output reg [31:0] pc_out,
	output reg wb_en_out,
	output reg mem_read_out,
	output reg mem_write_out,
	output reg [1:0] br_out,
	output reg [3:0] execute_cammand_out,
	output reg [31:0] data1_out,
	output reg [31:0] data2_out,
	output reg [31:0] reg2_out,
	output reg [4:0] dest_out
);

	always@(posedge clk, posedge rst) begin
		if(rst) begin
			pc_out <= 32'b0;
			wb_en_out <= 1'b0;
			mem_read_out <= 1'b0;
			mem_write_out <= 1'b0;
			br_out <= 2'b0;
			execute_cammand_out <= 4'b0;
			data1_out <= 32'b0;
			data2_out <= 32'b0;
			reg2_out <= 32'b0;
			dest_out <= 5'b0;
		end
		else if(flush) begin
			pc_out <= 32'b0;
			wb_en_out <= 1'b0;
			mem_read_out <= 1'b0;
			mem_write_out <= 1'b0;
			br_out <= 2'b0;
			execute_cammand_out <= 4'b0;
			data1_out <= 32'b0;
			data2_out <= 32'b0;
			reg2_out <= 32'b0;
			dest_out <= 5'b0;
		end
		else begin
			pc_out <= pc_in;
			wb_en_out <= wb_en;
			mem_read_out <= mem_read;
			mem_write_out <= mem_write;
			br_out <= br;
			execute_cammand_out <= execute_cammand;
			data1_out <= data1;
			data2_out <= data2;
			reg2_out <= reg2;
			dest_out <= dest;
		end
	end

endmodule