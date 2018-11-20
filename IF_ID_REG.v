module IF_ID_REG(
	input clk, 
	input rst, 
	input [31:0] pcIn, 
	input [31:0] instIn,
	input flush,
	input freeze,
	output reg[31:0] pcOut,
	output reg[31:0] instOut
);

	always@(posedge clk, posedge rst) begin
		if(rst) begin
			pcOut <= 32'b0;
			instOut <= 32'b0;			
		end
		else if(flush) begin
			pcOut <= 32'b0;
			instOut <= 32'b0;			
		end
		else if(freeze == 1'b0) begin
			pcOut <= pcIn;
			instOut <= instIn;
		end
	end

endmodule