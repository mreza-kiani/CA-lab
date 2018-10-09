module IF(input clk, rst, output [31:0] pcOut, output [31:0] inst);
	
	reg [31:0] pc;
	
	initial pc = 32'b0;

	ROM rom(pc, inst);
	
	always@(posedge clk, posedge rst) begin
		if(rst)
			pc <= 32'b0;
		else
			pc <= pc + 4;
	end

	assign pcOut = pc;
endmodule