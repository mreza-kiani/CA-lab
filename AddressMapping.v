module AddressMapping(
	input [31:0] ALU_result,
	output [5:0] address
);
	wire [31:0] address_base;

	assign address_base = (ALU_result - 1024);
	// sram check for [7:1]
	assign address = address_base[7:2];

endmodule