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
