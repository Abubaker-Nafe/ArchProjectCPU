module ProgramCounter(
	input wire clk,		   
	input wire [31:0] inputRegister,
	output reg [31:0] outputRegister,
	input wire enable
	); 			 
	initial begin
		outputRegister <= 0;
	end

	always @(posedge clk)
		begin						
			if (enable == 1) 	 
				begin
					outputRegister = inputRegister;
			end
	end
endmodule
	