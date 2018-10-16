module MUX32(
	input select,
	input [31:0] in1,
	input [31:0] in2,
 	output [31:0] out
 );
	
	assign out = (select == 1'b0) ? in1 : in2;

endmodule