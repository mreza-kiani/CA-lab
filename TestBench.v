module test();

	reg clk=1, rst=0;

	wire [31:0] IF_PC, IF_Inst, IF_ID_PC, IF_ID_Inst, 
				ID_PC, ID_EXE_PC, 
				EXE_PC, EXE_MEM_PC, 
				MEM_PC, MEM_WB_PC, 
				WB_PC ;
			
	wire [31:0] ID_reg1, ID_reg2;
	wire [4:0] ID_dest;
	wire [1:0] ID_br;
	wire [3:0] ID_execute_cammand;
	wire ID_wb_en, ID_mem_read, ID_mem_write;
	wire ID_EXE_wb_en_out;
	wire ID_EXE_mem_read_out;
	wire ID_EXE_mem_write_out;
	wire [1:0] ID_EXE_br_out;
	wire [3:0] ID_EXE_execute_cammand_out;
	wire [31:0] ID_EXE_reg1_out;
	wire [31:0] ID_EXE_reg2_out;
	wire [4:0] ID_EXE_dest_out;

	wire [4:0] WB_dest_address;
	wire WB_write_en;
	wire [31:0] WB_write_value;

	IF IF_Stage(clk, rst, IF_PC, IF_Inst);
	IF_ID_REG IF_ID(clk, rst, IF_PC, IF_Inst, IF_ID_PC, IF_ID_Inst);
	ID ID_Stage(clk, rst, IF_ID_PC, IF_ID_Inst, WB_dest_address, WB_write_en, WB_write_value, 
				ID_PC, ID_wb_en, ID_mem_read, ID_mem_write, ID_br, ID_execute_cammand, ID_reg1, ID_reg2, ID_dest);
	ID_EXE_REG ID_EXE(clk, rst, ID_PC, ID_wb_en, ID_mem_read, ID_mem_write, ID_br, ID_execute_cammand, ID_reg1, ID_reg2, ID_dest, 
				ID_EXE_PC, ID_EXE_wb_en_out, ID_EXE_mem_read_out, ID_EXE_mem_write_out, ID_EXE_br_out, ID_EXE_execute_cammand_out, ID_EXE_reg1_out, ID_EXE_reg2_out, ID_EXE_dest_out);
	EXE EXE_Stage(clk, rst, ID_EXE_PC, EXE_PC);
	EXE_MEM_REG EXE_MEM(clk, rst, EXE_PC, EXE_MEM_PC);
	MEM MEM_Stage(clk, rst, EXE_MEM_PC, MEM_PC);
	MEM_WB_REG MEM_WB(clk, rst, MEM_PC, MEM_WB_PC);
	WB WB_STAGE(clk, rst, MEM_WB_PC, WB_PC);

	initial begin
		#50
		rst = 1'b1;
		#100
		clk = ~clk;
		#1000
		clk = ~clk;
		#1000
		rst = 1'b0;
		repeat (100) begin
			#1000
			clk=~clk;
		end
	end
endmodule