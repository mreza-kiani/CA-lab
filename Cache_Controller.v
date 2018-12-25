module Cache_Controller(
	input clk,
	input rst,
	input [15:0] address,
	input mem_read,
	input mem_write,
	input [63:0] SRAM_data,
	input SRAM_ready,
	output [31:0] data,
	output reg SRAM_mem_read,
	output reg SRAM_mem_write,
	output freeze
);
	reg [63:0] way1_data [0:63];
	reg [8:0] way1_tag [0:63];
	reg [63:0] way1_valid ;
	reg [63:0] way2_data [0:63];
	reg [8:0] way2_tag [0:63];
	reg [63:0] way2_valid;
	reg LRU [0:63];

	wire eq_tag1, eq_tag2, valid1, valid2;
	wire [8:0] tag_address;
	wire [5:0] index_address;
	wire word_num;
	wire hit;

	assign tag_address = address[15:7];
	assign index_address = address[6:1];
	assign word_num = address[0];

	integer i;
	always @(posedge clk, posedge rst) begin
		if (rst) begin
			way1_valid <= 64'b0;
			way2_valid <= 64'b0;
		end
		else begin
			{SRAM_mem_read, SRAM_mem_write} <= 2'b0;
			if(mem_read) begin
				if(hit == 0) begin
					SRAM_mem_read <= 1'b1;
					if(SRAM_ready) begin
						if(LRU[index_address] == 0) begin
							way1_data[index_address] <= SRAM_data;
							way1_tag[index_address] <= tag_address;
							way1_valid[index_address] <= 1'b1;	
							LRU[index_address] <= 1'b1;
						end
						else begin
							way2_data[index_address] <= SRAM_data;
							way2_tag[index_address] <= tag_address;
							way2_valid[index_address] <= 1'b1;
							LRU[index_address] <= 1'b0;
						end
					end
				end
				else begin
					if(valid1) begin
						LRU[index_address] <= 1'b1;
					end
					else begin
						LRU[index_address] <= 1'b0;
					end
				end
			end
			if(mem_write) begin
				SRAM_mem_write <= 1'b1;
				if(valid1) 
					way1_valid[index_address] <= 1'b0;
				if(valid2) 
					way2_valid[index_address] <= 1'b0;
			end
			if(SRAM_ready) begin
				SRAM_mem_read <= 0;
				SRAM_mem_write <= 0;
			end
		end
	end



	assign data = (hit == 1'b0) ? SRAM_data[31:0] : 
				  (valid1 == 1'b1) ? 
				  		((word_num == 1'b0) ? way1_data[index_address][31:0] : way1_data[index_address][63:32])
				  		:
				  		((word_num == 1'b0) ? way2_data[index_address][31:0] : way2_data[index_address][63:32])
				  		;

	assign eq_tag1 = (tag_address == way1_tag[index_address]);
	assign valid1 = (eq_tag1 & way1_valid[index_address]);
	assign eq_tag2 = (tag_address == way2_tag[index_address]);
	assign valid2 = (eq_tag2 & way2_valid[index_address]);
	assign hit = (mem_write) ? 1'b0 : (valid1 || valid2);
	assign freeze = ((mem_read || mem_write) && ~(hit || SRAM_ready));


endmodule