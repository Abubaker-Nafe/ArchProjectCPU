	module ALU(
	  input [31:0] operandOne,
	  input [31:0] operandTwo,
	  input [5:0] opcode,
	  output reg [31:0] ALUOut,
	  output reg zeroFlag = 0,
	  output reg carryFlag = 0,
	  output reg negativeFlag = 0,
	  output reg greaterThan = 0,
	  output reg lessThan = 0
	);
	
	  always @*
	  begin
	
		  case(opcode)
			  //R-Type 
	          6'b000000:ALUOut = operandOne & operandTwo;
	          6'b000001:
	            begin
	              ALUOut = operandOne + operandTwo;
	              if(ALUOut < operandOne)
	                carryFlag = 1;
	            end
	          6'b000010:ALUOut = operandOne - operandTwo; 
			  //I-Type: ALU, Load, store, and branch
			  6'b000011:ALUOut = operandOne & operandTwo;
			  6'b000100:
	            begin
	              ALUOut = operandOne + operandTwo;
	              if(ALUOut < operandOne)
	                carryFlag = 1;
	            end
			  6'b000101:
	            begin
	              ALUOut = operandOne + operandTwo;
	              if(ALUOut < operandOne)
	                carryFlag = 1;
	            end
			  6'b000110:
	            begin
	              ALUOut = operandOne + operandTwo;
	              if(ALUOut < operandOne)
	                carryFlag = 1;
	            end
			  6'b000111:
	            begin
	              ALUOut = operandOne + operandTwo;
	              if(ALUOut < operandOne)
	                carryFlag = 1;
	            end
			  6'b001000:
	            begin
	              ALUOut = (operandOne > operandTwo) ? 1 : 0;
				  greaterThan = ALUOut;
	            end
			  6'b001001:
	            begin
	              ALUOut = (operandOne < operandTwo) ? 1 : 0;
				  lessThan = ALUOut;
	            end
			  6'b001010:
	            begin
	              ALUOut = operandOne - operandTwo; 
	            end
			  6'b001011:
	            begin
	              ALUOut = operandOne - operandTwo; 
	            end
			  //J-Type
			  6'b001100:
	            begin
	              ALUOut = operandOne + operandTwo;
	              if(ALUOut < operandOne)
	                carryFlag = 1;
	            end
			  6'b001101:
	            begin
	              ALUOut = operandOne + operandTwo;
	              if(ALUOut < operandOne)
	                carryFlag = 1;
	            end	
			  //NONE for S-Type 
	        endcase		
		
	    
	    if (ALUOut == 0)
	      begin
	        zeroFlag = 1;  
	      end      
	    if (ALUOut < 0)
	      begin
	        negativeFlag = 1;
	      end
		  
	  end
	endmodule
	
	
`timescale 1ns/1ps

module ALU_tb;

  reg [31:0] operandOne;
  reg [31:0] operandTwo;
  reg [5:0] opcode;
  wire [31:0] ALUOut;
  wire zeroFlag;
  wire carryFlag;
  wire negativeFlag;
  wire greaterThan;
  wire lessThan;

  ALU uut (
    .operandOne(operandOne),
    .operandTwo(operandTwo),
    .opcode(opcode),
    .ALUOut(ALUOut),
    .zeroFlag(zeroFlag),
    .carryFlag(carryFlag),
    .negativeFlag(negativeFlag),
    .greaterThan(greaterThan),
    .lessThan(lessThan)
  );

  initial begin
    // Testcase 1: ADD operation with positive operands
    operandOne = 5;
    operandTwo = 7;
    opcode = 6'b000001;
    #10;
    if (ALUOut !== 12 || zeroFlag !== 0 || carryFlag !== 0 || negativeFlag !== 0 || greaterThan !== 0 || lessThan !== 0) $fatal("Testcase 1 failed");

    // Testcase 2: SUB operation with positive operands
    operandOne = 10;
    operandTwo = 5;
    opcode = 6'b000010;
    #10;
    if (ALUOut !== 5 || zeroFlag !== 0 || carryFlag !== 0 || negativeFlag !== 0 || greaterThan !== 0 || lessThan !== 0) $fatal("Testcase 2 failed");



    $stop; // Stop simulation
  end

endmodule
	