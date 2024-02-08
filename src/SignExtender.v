module SignExtender(
    input wire [15:0] extend,
    output reg [31:0] extended
);

always @*
begin 
	
    extended[15:0] = extend;
    if (extend[15] == 1)
				begin
					extended[31:16] = 16'b1111111111111111;
				end	
			else
				begin
					extended[31:16] = 16'b0000000000000000;
				end
end

endmodule


`timescale 1ns/1ps

module SignExtender_tb;

  reg [15:0] extend;
  wire [31:0] extended;

  SignExtender uut (
    .extend(extend),
    .extended(extended)
  );

  initial begin
    // Testcase 1: Positive number
    extend = 16'h1234;
    #10;
    if (extended !== 32'h00001234) $fatal("Testcase 1 failed");

    // Testcase 2: Negative number
    extend = 16'hFEDC;
    #10;
    if (extended !== 32'hFFFFEDDC) $fatal("Testcase 2 failed");


    $stop; // Stop simulation
  end

endmodule
