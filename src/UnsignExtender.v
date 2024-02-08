module UnsignExtender(
    input wire [15:0] extend,
    output reg [31:0] extended
);

always @*
begin
    extended[15:0] = extend;
    extended[31:16] = 0;
end

endmodule


`timescale 1ns/1ps

module UnsignExtender_tb;

  reg [15:0] extend;
  wire [31:0] extended;

  UnsignExtender uut (
    .extend(extend),
    .extended(extended)
  );

  initial begin
    // Testcase 1: Positive number
    extend = 16'h1234;
    #10;
    if (extended !== 32'h00001234) $fatal("Testcase 1 failed");

    // Testcase 2: Maximum positive number
    extend = 16'hFFFF;
    #10;
    if (extended !== 32'h0000FFFF) $fatal("Testcase 2 failed");

    // Testcase 3: Zero
    extend = 16'h0000;
    #10;
    if (extended !== 32'h00000000) $fatal("Testcase 3 failed");


    $stop; // Stop simulation
  end

endmodule
