module test();

	reg clk=1, rst=0;

	wire [31:0] IF_PC, IF_Inst, IF_ID_PC, ID_PC, ID_EXE_PC, EXE_PC, EXE_MEM_PC, MEM_PC, MEM_WB_PC, WB_PC;
	IF IF_Stage(clk, rst, IF_PC, IF_Inst);
	IF_ID_REG IF_ID(clk, rst, IF_PC, IF_Inst, IF_ID_PC);
	ID ID_Stage(clk, rst, IF_ID_PC, ID_PC);
	ID_EXE_REG ID_EXE(clk, rst, ID_PC, ID_EXE_PC);
	EXE EXE_Stage(clk, rst, ID_EXE_PC, EXE_PC);
	EXE_MEM_REG EXE_MEM(clk, rst, EXE_PC, EXE_MEM_PC);
	MEM MEM_Stage(clk, rst, EXE_MEM_PC, MEM_PC);
	MEM_WB_REG MEM_WB(clk, rst, MEM_PC, MEM_WB_PC);
	WB WB_STAGE(clk, rst, MEM_WB_PC, WB_PC);

	initial begin
		repeat (50) begin
			#50
			clk=!clk;
		end
	end


endmodule