module SignExtend(
	input [15:0] imm, 
	output [31:0] imm_out
);
	assign imm_out = ((imm[15] == 1'b0) ? {16'b0, imm} : {16'b1, imm});
	
endmodule
