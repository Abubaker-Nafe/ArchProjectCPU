module DataMemo(
  input wire clk,
  input wire [31:0] address,
  input reg [31:0] dataIn,
  input wire memoR,
  input wire memoWR,
  input wire pop,
  input wire push,
  output reg [31:0] dataOut,
  output reg emptyStack = 1'b1,
  output reg fullStack = 1'b0,
  output reg emptyMemo = 1'b1,
  output reg fullMemo = 1'b0
);

  localparam DEPTH = 9'b111111111; // stack depth - 1
  reg [31:0] staticMemo[0:511];
  reg [31:0] stackMemo[0:511]; // Adjusted the size to match stackPtr range
  reg [8:0] sp = 9'b000000000; // stack pointer
  reg emptyStackFlag = 1;
  reg fullStackFlag = 0;
  reg emptyStaticFlag = 1;
  reg fullStaticFlag = 0;
  
  always @(posedge clk)
  begin


    // Update stack pointer for push/pop operations
    if (push && !fullStackFlag) 
    begin
        stackMemo[sp] <= dataIn;
        sp <= sp + 9'b000000001;
    end
    else if (pop && !emptyStackFlag)
    begin
        sp <= sp - 9'b000000001;
    end
    else if (memoWR && !fullStaticFlag)
    begin
      staticMemo[address] <= dataIn;
    end 
    else if (memoR && !emptyStaticFlag) 
    begin
      dataOut <= staticMemo[address];
    end
  end
  
  always @(sp) begin
        if (sp == 9'b000000000) begin
            emptyStack <= 1'b1;
            fullStack <= 1'b0;
        end else if (sp == DEPTH) begin
            fullStack <= 1'b1;
            emptyStack <= 1'b0;
        end else begin
            fullStack <= 1'b0;
            emptyStack <= 1'b0;
        end
  end
  
  always @(sp or emptyStack) begin
        if (!emptyStack) begin
            dataOut <= stackMemo[sp - 9'b000000001];
        end
    end
  
  
  
endmodule



`timescale 1ns/1ps

module DataMemo_tb;

  reg clk;
  reg [31:0] address;
  reg [31:0] dataIn;
  reg memoR;
  reg memoWR;
  reg pop;
  reg push;
  wire [31:0] dataOut;
  wire emptyStack;
  wire fullStack;
  wire emptyMemo;
  wire fullMemo;

  DataMemo uut (
    .clk(clk),
    .address(address),
    .dataIn(dataIn),
    .memoR(memoR),
    .memoWR(memoWR),
    .pop(pop),
    .push(push),
    .dataOut(dataOut),
    .emptyStack(emptyStack),
    .fullStack(fullStack),
    .emptyMemo(emptyMemo),
    .fullMemo(fullMemo)
  );

  initial begin
    // Initialize inputs
    clk = 0;
    address = 0;
    dataIn = 0;
    memoR = 0;
    memoWR = 0;
    pop = 0;
    push = 0;

    // Apply some test cases
    // Testcase 1: Push data into the stack
    push = 1;
    dataIn = 42;
    #10;
    if (emptyStack !== 0 || fullStack !== 0) $fatal("Testcase 1 failed");

    // Testcase 2: Pop data from the stack
    push = 0;
    pop = 1;
    #10;
    if (emptyStack !== 1 || fullStack !== 0 || dataOut !== 42) $fatal("Testcase 2 failed");


    $stop; // Stop simulation
  end

  always #5 clk = ~clk; // Clock generation

endmodule
