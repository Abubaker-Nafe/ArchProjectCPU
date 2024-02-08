module immToRs2(
	input wire [15:0] imm,
	output reg [3:0] RS2,
	);

	always @*
		begin
			RS2 <= imm[15:12];
		end
endmodule
