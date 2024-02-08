module RFBufferTwo(																				   
	input wire regWriteBuffTwo,
	input wire [31:0] regIn,
	output reg [31:0] regOut
	);
	always @*
		begin		
			if(regWriteBuffTwo == 1) begin
			regOut = regIn;
			end	   
	end
endmodule
	