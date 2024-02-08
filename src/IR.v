module IR(
    input wire clk,
    input wire IRWrite,
    input wire [31:0] inputRegister,  // The input register
    output reg [5:0] opcode,    // 0:5
    output reg [3:0] Rs1,       
    output reg [3:0] Rd,        
    output reg [15:0] imm,      
    output reg [1:0] modeBits    
);

always @* begin
    if (IRWrite == 1'b1) begin
        opcode <= inputRegister[31:26];
        Rs1 <= inputRegister[25:22];
        Rd <= inputRegister[21:18];
        imm <= inputRegister[17:2];
        modeBits <= inputRegister[1:0];
    end
end

endmodule
