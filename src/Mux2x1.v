
module Mux2x1 (
  input wire [31:0] a,
  input wire [31:0] b,
  input wire sel,
  output wire [31:0] out
);

  assign out = (sel == 0) ? a : b;

endmodule

module Mux2x1_tb;

  // Inputs
  reg [31:0] a;
  reg [31:0] b;
  reg sel;

  // Output
  wire [31:0] out;

  // Instantiate the module under test
  Mux2x1 dut (
    .a(a),
    .b(b),
    .sel(sel),
    .out(out)
  );

  // Stimulus
  initial begin
    // Initialize inputs
    a = 0;
    b = 32'h0000_0001;
    sel = 0;

    // Apply stimulus
    #10 sel = 1;
    #10 sel = 0;
    #10 sel = 1;

    // Finish simulation
    #10 $finish;
  end

  // Monitor
  always @(out)
    $display("Output = %b", out);

endmodule
