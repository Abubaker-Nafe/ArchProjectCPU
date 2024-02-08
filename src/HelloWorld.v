module HelloWorld;
    initial begin
        $display("Hello, hhhhhhhhhhhh!");
        $finish; // Terminate simulation after printing
    end
endmodule

`timescale 1ns/1ps

module tb_HelloWorld;

    // Instantiate the module under test
    HelloWorld dut();

    // Create clock
    reg clk = 0;

    // Clock generation
    always #5 clk = ~clk;

    // Simulation process
    initial begin
        // Display a message
        $display("Simulation started");

        // Simulate for some time
        #50;

        // Finish simulation
        $finish;
    end

endmodule
