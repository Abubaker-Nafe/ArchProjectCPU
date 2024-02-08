module InstructionMemo(
    input wire [31:0] inputPC,
    output reg [31:0] Instruction,
	output reg [31:0] outputPC

);

    reg [31:0] memo[2048:0]; // memoory is 32 bits wide for MIPS
	// Example instructions:
    initial begin
		memo[0] = 32'b00000000000000000000000000000000;// No operation
        memo[1] = 32'b00010000010001000000000000011100;//R1=R1+7
        memo[2] = 32'b00010000100010000000000000011100;//R2=R2+3
        memo[3] = 32'b00000100110001001000000000011100;//R3=R2+R1
		memo[4] = 32'b00111100110000000000000000000000;//push R3
        memo[5] = 32'b00011100110010000000000000011100;//sw R3, 7(R2)
        //memo[6] = 32'b00000100110001001000000000011100;//R3=R2+R1
       

    end
    always @* begin
        Instruction = memo[inputPC]; // I'm assuming inputPC is incremented externally
		outputPC <= inputPC + 1;
    end

endmodule

`timescale 1ns/1ps

module InstructionMemo_tb;

  reg [31:0] inputPC;
  wire [31:0] Instruction;
  wire [31:0] outputPC;

  InstructionMemo uut (
    .inputPC(inputPC),
    .Instruction(Instruction),
    .outputPC(outputPC)
  );

  initial begin
    inputPC = 0;

    // Read instructions at different addresses
    #10;
    inputPC = 0;
    #10;

    inputPC = 1;
    #10;

    inputPC = 2;
    #10;

    inputPC = 3;
    #10;

    $stop; // Stop simulation
  end

endmodule



