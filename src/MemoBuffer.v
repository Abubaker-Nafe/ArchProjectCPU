module MemoBuffer(
	input wire clk,
	input wire [31:0] regIn,
	output reg [31:0] regOut
	);
	always @(posedge clk)
		begin
			regOut <= regOut;
	end
endmodule