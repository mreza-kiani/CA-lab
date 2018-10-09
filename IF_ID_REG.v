module IF_ID_REG(input clk, rst, input [31:0] pcIn, input [31:0] inst, output reg[31:0] pcOut);

	always@(posedge clk, posedge rst) begin
		if(rst)
			pcOut <= 32'b0;
		else 
			pcOut <= pcIn;
	end

endmodule