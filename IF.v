module IF(
	input clk,
	input rst,
	input br_select,
	input [31:0] br_pc,
	input freeze,
	output reg [31:0] pc_plus,
	output [31:0] inst
);
	wire [31:0] pc_in, pc_out;
	
	MUX32 mux(br_select, pc_plus, br_pc, pc_in);
	Register32 pc(clk, rst, pc_in, pc_out);
	ROM rom(pc_out, inst);
	
	always@(pc) begin
		if(freeze == 1'b0)
			pc_plus <= pc_out + 4;
		else 
			pc_plus <= pc_out;
	end
endmodule