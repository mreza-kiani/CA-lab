module ConditionCheck(
	input [1:0] br,
	input [31:0] data1,
	input [31:0] data2,
	output reg br_select
);
	always @(*) begin
		case(br) 
			2'b01 : begin //BEZ
				br_select = (data1 == 0);
			end
			2'b10 : begin //BNE
				br_select = (data1 != data2);
			end
			2'b11 : begin //JMP
				br_select = 1;
			end
			default: begin
				br_select = 0;
			end
		endcase
	end
endmodule