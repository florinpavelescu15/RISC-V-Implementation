`timescale 1ns / 1ps
`include "Moore.v"

module test_Moore;
    reg clk, clr, w;
    wire out;
    
    always #10 clk = ~clk;
    
    initial
        begin
            $dumpfile("test_Moore.vcd");
            $dumpvars(0, test_Moore);
            clk = 0; clr = 1;
            #15 clr = 0;
            #15 w = 0;
            #20 w = 0;
            #20 w = 1;
            #20 w = 1;
            #20 w = 0;
            #20 w = 1;
            #20 w = 0;
            #20 w = 1;
            #20 w = 0;
            #20 w = 0;
            #20 w = 1;
            #20 w = 0;
            #20 w = 1;
            #20 w = 1;
            #20 w = 1;
            #20 w = 0;
            #20 w = 0;
            #20 $finish;
    end

    Moore moore(clk, clr, w, out);
endmodule
