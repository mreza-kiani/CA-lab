module MUX2(
	input select,
	input in1,
	input in2,
 	output out
 );
	
	assign out = (select == 1'b0) ? in1 : in2;

endmodule