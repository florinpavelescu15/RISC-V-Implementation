`timescale 1ns / 1ps
`include "instruction_memory.v"

module test_instruction_memory;
    reg [9:0] address;
    wire [31:0] instruction;

    initial
    begin
        $dumpfile("test_instruction_memory.vcd");
        $dumpvars(0, test_instruction_memory);
        address = 0;
        #10 address = 1;
        #10 address = 2;
        #10 address = 3;
        #10 address = 4;
        #10 address = 5;
        #10 address = 6;
        #10 address = 7;
        #10;
    end

    instruction_memory my_im(address, instruction);
endmodule