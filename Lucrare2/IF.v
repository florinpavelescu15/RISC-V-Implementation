`timescale 1ns / 1ps
`include "mux2_1.v"
`include "PC.v"
`include "adder.v"
`include "instruction_memory.v"
 
module IF(input clk, reset, 
          input PCSrc, PC_write,
          input [31:0] PC_Branch,
          output [31:0] PC_IF, INSTRUCTION_IF);
    wire [31:0] PC_IF_4, PC_Mux, const4;
    assign const4 =  4;
   
    mux2_1 my_mux(PC_IF_4, PC_Branch, PCSrc, PC_Mux);
    PC my_pc(clk, reset, PC_write, PC_Mux, PC_IF);
    adder my_adder(const4, PC_IF, PC_IF_4);
    instruction_memory my_im(PC_IF[11:2], INSTRUCTION_IF);
endmodule