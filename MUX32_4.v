module MUX32_4(
	input [1:0] select,
	input [31:0] in1,
	input [31:0] in2,
	input [31:0] in3,
 	output [31:0] out
);
	
	assign out = (select == 2'b00) ? in1 : 
				 (select == 2'b01) ? in2 :
				 (select == 2'b10) ? in3 :
				  32'b0;

endmodule