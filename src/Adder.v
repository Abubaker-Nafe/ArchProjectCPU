module Adder(
    input [31:0] PC,
    input [15:0] imm16,
    output reg [31:0] BTA
);      
    wire [31:0] extendedImm;   
    assign extendedImm = {16'b0, imm16}; // Concatenation used to append zeros to MSBs of imm
    always @*
        begin
            BTA <= PC + extendedImm; // Non-blocking assignment used in procedural blocks
        end
endmodule
