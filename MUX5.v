module MUX5(
	input select,
	input [4:0] in1,
	input [4:0] in2,
 	output [4:0] out
 );
	
	assign out = (select == 1'b0) ? in1 : in2;

endmodule