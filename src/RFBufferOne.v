module RFBufferOne(		
	input wire regWriteBuffOne,
	input wire [31:0] regIn,
	output reg [31:0] regOut
	);
	always @* 
		begin			 
			if (regWriteBuffOne == 1) begin
				regOut <= regIn;

		end	
	end
endmodule
	