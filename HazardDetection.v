module HazardDetection(
	input hasForward,
	input [4:0] src1,
	input [4:0] src2,
	input [4:0] exe_dest,
	input exe_wb_en,
	input [4:0] mem_dest,
	input mem_wb_en,
	input src2_check,
	input exe_mem_read,
	output reg hazard_detected
);

	always @(*) begin
		hazard_detected = 1'b0;
		if (hasForward) begin
			if (exe_mem_read && (exe_dest == src1 || (src2_check && exe_dest == src2) )) begin
				hazard_detected = 1'b1;
			end			
		end
		else begin
			if((exe_dest == src1 && exe_wb_en == 1'b1) || (mem_dest == src1 && mem_wb_en == 1'b1))
				hazard_detected = 1'b1;
				
			if(src2_check == 1'b1) begin
				if((exe_dest == src2 && exe_wb_en == 1'b1) || (mem_dest == src2 && mem_wb_en == 1'b1))
					hazard_detected = 1'b1;
			end
		end
	end

endmodule