module ControlUnit(
	input [5:0] opcode,
	output reg mem_read,
	output reg mem_write,
	output reg wb_en,
	output reg is_immediate,
	output reg [1:0] br, 
	output reg [3:0] execute_cammand
);
	 
	always @(opcode) begin
		mem_read <= 1'b0;
		mem_write <= 1'b0;
		wb_en <= 1'b0;
		is_immediate <= 1'b0;
		br <= 2'b0;
		execute_cammand <= 4'b0;
		case(opcode) 
			6'b000001 : begin //ADD
				wb_en <= 1'b1;
				execute_cammand <= 4'b0000;
			end
			6'b000011 : begin //SUB
				wb_en <= 1'b1;
				execute_cammand <= 4'b0010;
			end
			6'b000101 : begin //AND
				wb_en <= 1'b1;
				execute_cammand <= 4'b0100;
			end
			6'b000110 : begin //OR
				wb_en <= 1'b1;
				execute_cammand <= 4'b0101;
			end
			6'b000111 : begin //NOR
				wb_en <= 1'b1;
				execute_cammand <= 4'b0110;
			end
			6'b001000 : begin //XOR
				wb_en <= 1'b1;
				execute_cammand <= 4'b0111;
			end
			6'b001001 : begin //SLA
				wb_en <= 1'b1;
				execute_cammand <= 4'b1000;
			end
			6'b001010 : begin //SLL
				wb_en <= 1'b1;
				execute_cammand <= 4'b1000;
			end
			6'b001011 : begin //SRA
				wb_en <= 1'b1;
				execute_cammand <= 4'b1001;
			end
			6'b001100 : begin//SRL
				wb_en <= 1'b1;
				execute_cammand <= 4'b1010;
			end
			6'b100000 : begin //ADDI
				is_immediate <= 1'b1;
				wb_en <= 1'b1;
				execute_cammand <= 4'b0000;
			end
			6'b100001 : begin //SUBI
				is_immediate <= 1'b1;
				wb_en <= 1'b1;
				execute_cammand <= 4'b0010;
			end
			6'b100100 : begin //LD
				mem_read <= 1'b1;
				is_immediate <= 1'b1;
				wb_en <= 1'b1;
				execute_cammand <= 4'b0000;
			end
			6'b100101 : begin //ST
				mem_write <= 1'b1;
				is_immediate <= 1'b1;
				execute_cammand <= 4'b0000;
			end
			6'b101000 : begin //BEZ
				is_immediate <= 1'b1;
				br <= 2'b01;
			end
			6'b101001 : begin //BNE
				is_immediate <= 1'b1;
				br <= 2'b10;
			end
			6'b101010 : begin //JMP
				is_immediate <= 1'b1;
				br <= 2'b11;
			end

		endcase
	end
	

endmodule