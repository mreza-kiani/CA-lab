module ALU(
	input [31:0] data1,
	input [31:0] data2,
	input [3:0] execute_cammand,
	output reg [31:0] result
);
	always @(*) begin
		case(execute_cammand) 
			4'b0000 : begin //ADD
				result <= data1 + data2;
			end
			4'b0010 : begin //SUB
				result <= data1 - data2;
			end
			4'b0100 : begin //AND
				result <= data1 & data2;				
			end
			4'b0101 : begin //OR
				result <= data1 | data2;
			end
			4'b0110 : begin //NOR
				result <= ~(data1 | data2);
			end
			4'b0111 : begin //XOR
				result <= data1 ^ data2;
			end
			4'b1000 : begin //SLA or SLL
				result <= data1 << data2;
			end
			4'b1001 : begin //SRA
				result <= $signed(data1) >>> data2;
			end
			4'b1010 : begin //SRL
				result <= data1 >> data2;
			end
		endcase
	end

endmodule