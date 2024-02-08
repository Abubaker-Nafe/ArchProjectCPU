// THIS MODULE IS FOR THE FULL FINAL DATAPATH
module Datapath(
	input wire clk
	);

    // PC register
    wire [31:0] PCregOut;
    // intruction memory
    wire [31:0] instruction;
    wire [31:0] PCPlused;// PC+1

    // MEMORY
    wire [31:0] MemDataOut;

    // Instruction register
    wire [5:0] opcodeIn;
    wire [3:0] Rs1;
    wire [3:0] Rd;
    wire [15:0] imm;
    wire [1:0] modeBits;


    // memDataReg
    wire [31:0] memDataRegOut;

    // mux 2to1 between memory and ALUout
    wire [31:0] writeData;
	// mux 2to1 between memory and ALUout
    wire [31:0] writeData2;
	
    // imm to Rs2
    wire [3:0] Rs2;

    // mux 2to1 between rs2 and rd
    wire [3:0] readRegister2;


    // registers
    wire [31:0] readData1;
    wire [31:0] readData2;

    // imm26 for jump
    wire [31:0] Jumping;

    // sign extender
    wire [31:0] signExtended;

    // unsign extender
    wire [31:0] unsignExtended;

    // register A
    wire [31:0] regOne;

    // register B
    wire [31:0] regTwo;


    // mux 2x1 for sign vs unsign
    wire [31:0] extneded;

    // mux 2x1 for opOne
    wire [31:0] operandOne;

    //mux 4x1 for opTwo
    wire [31:0]  operandTwo;

    // BranchAdder
    wire [31:0]  branchAddress;

    // mux2to1 for branching
    wire [31:0] branchPC;

    // ALU
    wire [31:0] result;
    wire zeroFalg;
    wire carryFlag;
    wire negativeFlag;
	wire greaterThanFlag;
	wire lessThanFlag;

    //ALUoutReg
    wire [31:0]  ALUout;

    wire emptyStack;
    wire fullStack;
	wire emptyMemo;
	wire fullMemo;

    // mux 4x1 for PC target
    wire [31:0] target;

    // mux 2 to 1 betwen stack and pc target
    wire [31:0] nextPC;

    // CU(next semester), AKA Contol Unit
    wire BranchFlag;
    wire pop;
    wire push;
    wire [1:0] PCSource;
    wire [5:0] opcode;	 
    wire [1:0] ALUSrcTwo;
    wire ALUSrcOne;
    wire RFWR;
    wire ExtensionSrc;
    wire EN;
    wire MemoR;
    wire MemoWR;
    wire MemoToRF;
    wire IRWR;
    wire ReadRegisterTwoSrc;
	wire isStackAddress;
	wire regWriteOne;
	wire regWriteTwo;
	wire callFlag;
	wire modeFlag;

    //***********************COMPONENTS WIRING*********************
    // PC
    ProgramCounter pcregister(clk, nextPC, PCregOut, EN);
	
    // INSTRUCTION MEMORY
    InstructionMemo IM(PCregOut, instruction, PCPlused);
	
	// mux2x1
    Mux2x1 nextPCorDin(regTwo, PCPlused, callFlag, writeData2);
	
    // DATA MEMORY
    DataMemo DM(clk, ALUout, writeData2, MemoR, MemoWR, pop, push, MemDataOut);

    // INSTRUCTION REGISTER
    IR InstReg(clk, IRWR, instruction, opcodeIn, Rs1, Rd, imm, modeBits);

    // MemoBuffer
    MemoBuffer mbuff(clk, MemDataOut, memDataRegOut);

    // mux2x1
    Mux2x1 writeDataMux(memDataRegOut, ALUout, MemoToRF,writeData);

    // immToRs2
    immToRs2 immRs2(imm, Rs2);

    // mux2to1 read register
    Mux2x1 readRegister2Mux(Rs2, Rd, ReadRegisterTwoSrc,readRegister2);

    // Registers
    RegisterFile registerFile(clk, RFWR, Rs1, readRegister2, Rd, writeData, modeFlag, readData1, readData2);

    // imm24 for J-Type
    immTo26 imm26(Rs1, Rd, imm, Jumping);

    // SignExtender
    SignExtender SE(imm, signExtended);

    // UnsignExtender
    UnsignExtender UE(imm, unsignExtended);

    // mux 2x1 for extender SE or UE
    Mux2x1 SEorUE(signExtended, unsignExtended, ExtensionSrc, extneded);


    // RF - ALU 2ND BUFFER
    RFBufferTwo RegTwoComponent(regWriteTwo, readData2, regTwo);


    // RF - ALU 1ST BUFFER
    RFBufferOne RegOneComponenet(regWriteOne, readData1, regOne);

    // mux 2x1 oP1
    Mux2x1 opAMux(PCregOut, regOne, ALUSrcOne, operandOne);

    // mux 4x1 for op2
    Mux4x1 opBMux(regTwo, Jumping, extneded, extneded, ALUSrcTwo, operandTwo);

    // ALU
    ALU ALUComponent(operandA, operandB, opcode, result, zeroFalg, carryFlag, negativeFlag, greaterThanFlag, lessThanFlag);
    
    // branch adder 
    Adder BranchComponent(PCregOut, imm, branchAddress);

    // mux 2x1 for PC and adder
    Mux2x1 PCorBranch(PCPlused, branchAddress, BranchFlag, branchPC);

    // ALUOut Register
    ALUBuffer ALUOutRegsiterComponent(clk, result, ALUout);

    // mux4x1 PCMUX
    Mux4x1 PCMUX(result, ALUout, PCPlused, branchPC, PCSource, target);

    // mux 2x1 for PC or Stack ADDRESS
    Mux2x1 PCorStackMux(target, MemDataOut, isStackAddress, nextPC);
	

	
    // CU
    ControlUnit CUComponent(clk, opcodeIn, modeBits, emptyStack, fullStack, emptyMemo, fullMemo, negativeFlag, zeroFalg, carryFlag, greaterThanFlag, lessThanFlag,EN,IRWR,MemoR,MemoWR, pop, push,MemoToRF, ReadRegisterTwoSrc, BranchFlag,  isStackAddress,	PCSource,  opcode,ALUSrcTwo,ALUSrcOne,RFWR, ExtensionSrc, regWriteOne, regWriteTwo, callFlag, modeFlag);

endmodule


`timescale 1ns / 1ps 

module Datapath_tb;

    // Inputs
    reg clk;	 

    // Instantiate the Unit Under Test (UUT)
    Datapath uut (
	.clk(clk)
    );	
	

    always
    #10 clk = ~clk; 

    initial begin
        // Initialize Inputs
        clk = 0;
		
		#5
		clk = 0; 
		#2000
		$finish;
    end	
	

endmodule
