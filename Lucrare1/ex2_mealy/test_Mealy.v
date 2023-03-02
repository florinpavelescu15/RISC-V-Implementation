`timescale 1ns / 1ps
`include "Mealy.v"

module test_Mealy;
    reg clk, clr, w;
    wire out;
    
    always #10 clk = ~clk;
    
    initial
        begin
            $dumpfile("test_Mealy.vcd");
            $dumpvars(0, test_Mealy);
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

    Mealy mealy(clk, clr, w, out);
endmodule
