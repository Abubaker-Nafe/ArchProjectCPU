module RegisterFile(
	input wire clk,
	input wire regWR,
	input wire [3:0] readRegisterOne, 
	input wire [3:0] readRegisterTwo, 
	input wire [3:0] destRegister,
	input wire [31:0] writeData,
	input wire modeFlag,
	output reg [31:0] readDataOne,
	output reg [31:0] readDataTwo
	
	);
	
	reg [15:0] registers [31:0];
	integer i;
	initial
	begin
			for(i=0; i < 16; i = i + 1)
			begin
					registers[i] = 32'b0;
			end
	end	 
	always @* begin
	assign readDataOne = registers[readRegisterOne];
	assign readDataTwo = registers[readRegisterTwo];		  
	end
	always @(posedge clk)
	begin
		if (regWR == 1)
			begin
				registers[destRegister] = writeData;	
			end
		if (modeFlag == 1)
			begin
				readDataOne = readDataOne + 1;
			end
				
	end
			
endmodule

`timescale 1ns/1ps

module RegisterFile_tb;

  reg clk;
  reg regWR;
  reg [3:0] readRegisterOne;
  reg [3:0] readRegisterTwo;
  reg [3:0] destRegister;
  reg [31:0] writeData;
  reg modeFlag;
  
  wire [31:0] readDataOne;
  wire [31:0] readDataTwo;

  RegisterFile uut (
    .clk(clk),
    .regWR(regWR),
    .readRegisterOne(readRegisterOne),
    .readRegisterTwo(readRegisterTwo),
    .destRegister(destRegister),
    .writeData(writeData),
    .modeFlag(modeFlag),
    .readDataOne(readDataOne),
    .readDataTwo(readDataTwo)
  );

  initial begin
    clk = 0;
    regWR = 0;
    readRegisterOne = 4'b0000;
    readRegisterTwo = 4'b0001;
    destRegister = 4'b0010;
    writeData = 32'h12345678;
    modeFlag = 0;

    #10; // Wait for some time

    // Testcase 1: Write to registers
    regWR = 1;
    #10;
    regWR = 0;

    // Testcase 2: Read from registers
    readRegisterOne = 4'b0000;
    readRegisterTwo = 4'b0001;
    destRegister = 4'b0010;
    modeFlag = 0;
    #10;

    // Testcase 3: Modify readDataOne when modeFlag is 1
    modeFlag = 1;
    #10;


    $stop; // Stop simulation
  end

  always begin
    #5 clk = ~clk; // Toggle clock every 5 time units
  end

endmodule
