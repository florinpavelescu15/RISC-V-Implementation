`timescale 1ns / 1ps
`include "RISC_V.v"

module RISC_V_TB;
  //input
  reg clk;
  reg reset;

  //output
  wire [31:0] PC_EX;
  wire [31:0] ALU_out_EX;
  wire [31:0] PC_MEM;
  wire PCSrc;
  wire [31:0] DATA_MEMORY_MEM;
  wire [31:0] ALU_DATA_WB;
  wire [1:0] forwardA, forwardB;
  wire Pipeline_stall;

  RISC_V my_risc_v(clk,reset, PC_EX, ALU_out_EX, PC_MEM, PCSrc,
            DATA_MEMORY_MEM, ALU_DATA_WB,
            forwardA, forwardB, Pipeline_stall);
  
  always #5 clk = ~clk;
  initial begin
    $dumpfile("test_RISC_V.vcd");
    $dumpvars;
    #0 clk = 1'b0;
       reset = 1'b1;
    #10 reset = 1'b0;
    #120 $finish;
  end

endmodule
