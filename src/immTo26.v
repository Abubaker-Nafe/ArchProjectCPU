module immTo26(			   
	input wire [3:0] rs1,
	input wire [3:0] rd,
	input wire [15:0] imm16,
	output reg [31:0] immOut
	);
		
	always @*
		begin
			if (rd[3] == 1)
				begin
					immOut[31:24] = 255;
				end	
			else
				begin
					immOut[31:24] = 0;
				end
				
			immOut[23:20] <= rs1[3:0];
			immOut[19:16] <= rd[3:0]; 
			immOut[15:0] <= imm16[15:0];
		end
endmodule

`timescale 1ns/1ps

module immTo26_tb;

  reg [3:0] rs1;
  reg [3:0] rd;
  reg [15:0] imm16;
  wire [31:0] immOut;

  immTo26 uut (
    .rs1(rs1),
    .rd(rd),
    .imm16(imm16),
    .immOut(immOut)
  );

  initial begin
    // Testcase 1: Positive numbers
    rs1 = 4'b0010;
    rd = 4'b0101;
    imm16 = 16'h1234;
    #10;
    if (immOut !== 32'h00051234) $fatal("Testcase 1 failed");

    // Testcase 2: Maximum positive numbers
    rs1 = 4'b1111;
    rd = 4'b1111;
    imm16 = 16'hFFFF;
    #10;
    if (immOut !== 32'h00FFFFFF) $fatal("Testcase 2 failed");

    // Testcase 3: Zero
    rs1 = 4'b0000;
    rd = 4'b0000;
    imm16 = 16'h0000;
    #10;
    if (immOut !== 32'h00000000) $fatal("Testcase 3 failed");


    $stop; // Stop simulation
  end

endmodule
