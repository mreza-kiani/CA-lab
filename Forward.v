module Forward(
	input [4:0] src1_EXE, 
	input [4:0] src2_EXE,
	input [4:0] dest_EXE,
	input [4:0] dest_MEM,
	input wb_en_MEM,
	input [4:0] dest_WB,
	input wb_en_WB,
	output reg [1:0] sel_val1,
	output reg [1:0] sel_val2,
	output reg [1:0] sel_dest
);
// TODO: independent if for selectors
	always @(*) begin
		{ sel_val1, sel_val2, sel_dest } = 6'b0;
		if (wb_en_MEM && dest_MEM == src1_EXE)
			sel_val1 = 2'b01;
		else if (wb_en_WB && dest_WB == src1_EXE)
			sel_val1 = 2'b10;

		if(wb_en_MEM && dest_MEM == src2_EXE)
			sel_val2 = 2'b01;
		else if(wb_en_WB && dest_WB == src2_EXE)
			sel_val2 = 2'b10;

		if(wb_en_MEM && dest_MEM == dest_EXE)
			sel_dest = 2'b01;
		else if(wb_en_WB && dest_WB == dest_EXE)
			sel_dest = 2'b10;
	end

	// always @(*) begin
	// 	{ sel_val1, sel_val2, sel_dest } = 6'b0;
	// 	if (wb_en_WB) begin
	// 		if (dest_WB == src1_EXE)
	// 			sel_val1 = 2'b10;
	// 		if (dest_WB == src2_EXE) // TODO: imm -> src2 = 0 instead of sr2_check
	// 			sel_val2 = 2'b10;
	// 		if (dest_WB == dest_EXE)
	// 			sel_dest = 2'b10;
	// 	end
	// 	if (wb_en_MEM) begin
	// 		if (dest_MEM == src1_EXE)
	// 			sel_val1 = 2'b01;
	// 		if (dest_MEM == src2_EXE)
	// 			sel_val2 = 2'b01;
	// 		if (dest_MEM == dest_EXE)
	// 			sel_dest = 2'b01;
	// 	end
	// end

endmodule