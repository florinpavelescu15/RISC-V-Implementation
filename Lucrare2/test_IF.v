`timescale 1ns / 1ps
`include "IF.v"

module test_IF;
    reg clk, reset, PCSrc, PC_write;
    reg [31:0] PC_Branch;
    wire [31:0] PC_IF, INSTRUCTION_IF;
    
    always #5 clk = ~clk;
    
    initial
    begin
        $dumpfile("test_IF.vcd");
        $dumpvars(0, test_IF);
        clk = 0;
        reset = 1;
        PCSrc = 0;
        PC_write = 1;    
        PC_Branch = 0;  
            
        #10 reset = 0;
        #100 $finish;
    end

    IF my_if(clk, reset, PCSrc, PC_write, PC_Branch, PC_IF, INSTRUCTION_IF);
endmodule