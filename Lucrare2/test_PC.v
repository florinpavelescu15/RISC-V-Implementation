`timescale 1ns / 1ps
`include "PC.v"

module test_PC;
    reg clk, res, write;
    reg [31:0] in;
    wire [31:0] out;
    
    always #5 clk = ~clk;
    
    initial
    begin
        $dumpfile("test_PC.vcd");
        $dumpvars(0, test_PC);
        clk = 0; res = 1; write = 0;
        #5 in = 1352; res = 0;
        #10 write = 1;
        #10 in = 45678;
        #10 write = 0;
        #10 in = 9283;
        #10 write = 1;
        #10 in = 324;
        #10 in = 6188;
        #10 in = 9;
        #10 res = 1;
        #20 write = 0;
        #10 res = 0; write = 1;
        #10 in = 100;       
        #20 $finish;
    end

    PC my_pc(clk, res, write, in, out);
endmodule