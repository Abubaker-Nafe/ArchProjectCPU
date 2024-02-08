module Mux4x1 (
    input wire [31:0] a,       // Input 0
    input wire [31:0] b,       // Input 1
    input wire [31:0] c,       // Input 2
    input wire [31:0] d,       // Input 3
    input wire [1:0] sel,      // Select lines (2 bits)
    output wire [31:0] out     // Output
);

assign out = (sel == 2'b00) ? a :
             (sel == 2'b01) ? b :
             (sel == 2'b10) ? c :
             d;
endmodule

module tb_Mux4x1();
    reg [31:0] a, b, c, d;
    reg [1:0] sel;
    wire [31:0] out;

    // Instantiate the mux4x1 module
    Mux4x1 mux (
        .a(a),
        .b(b),
        .c(c),
        .d(d),
        .sel(sel),
        .out(out)
    );

    // Stimulus generation
    initial begin
        // Test Case 1: When sel is 00, output should be equal to input a
        a = 32'b0000_0000_0000_0000_0000_0000_0000_0001;
        b = 32'b0000_0000_0000_0000_0000_0000_0000_0010;
        c = 32'b0000_0000_0000_0000_0000_0000_0000_0100;
        d = 32'b0000_0000_0000_0000_0000_0000_0000_1000;
        sel = 2'b00;
        #10;
        $display("a=%b, b=%b, c=%b, d=%b, sel=%b, out=%b", a, b, c, d, sel, out);
        
        // Test Case 2: When sel is 01, output should be equal to input b
        sel = 2'b01;
        #10;
        $display("a=%b, b=%b, c=%b, d=%b, sel=%b, out=%b", a, b, c, d, sel, out);
        
        // Test Case 3: When sel is 10, output should be equal to input c
        sel = 2'b10;
        #10;
        $display("a=%b, b=%b, c=%b, d=%b, sel=%b, out=%b", a, b, c, d, sel, out);

        // Test Case 4: When sel is 11, output should be equal to input d
        sel = 2'b11;
        #10;
        $display("a=%b, b=%b, c=%b, d=%b, sel=%b, out=%b", a, b, c, d, sel, out);

        // End simulation
        $finish;
    end

endmodule
