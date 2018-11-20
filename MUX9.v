module MUX9(
	input select,
	input [8:0] in1,
	input [8:0] in2,
 	output [8:0] out
 );
	
	assign out = (select == 1'b0) ? in1 : in2;

endmodule