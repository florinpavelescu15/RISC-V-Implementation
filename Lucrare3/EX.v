`timescale 1ns / 1ps
`include "mux2_1.v"
`include "mux4_1.v"
`include "ALUControl.v"
`include "adder.v"
`include "ALU.v"

module EX(input [31:0] IMM_EX,         
          input [31:0] REG_DATA1_EX,
          input [31:0] REG_DATA2_EX,
          input [31:0] PC_EX,
          input [2:0] FUNCT3_EX,
          input [6:0] FUNCT7_EX,
          input [4:0] RD_EX,
          input [4:0] RS1_EX,
          input [4:0] RS2_EX,
          input RegWrite_EX,
          input MemtoReg_EX,
          input MemRead_EX,
          input MemWrite_EX,
          input [1:0] ALUop_EX,
          input ALUSrc_EX,
          input Branch_EX,
          input [1:0] forwardA, forwardB,
          
          input [31:0] ALU_DATA_WB,
          input [31:0] ALU_OUT_MEM,
          
          output ZERO_EX,
          output [31:0] ALU_OUT_EX,
          output [31:0] PC_Branch_EX,
          output [31:0] REG_DATA2_EX_FINAL);

    wire [3:0] ALU_Control;
    wire [31:0] ALU_Source1, MUX_B_temp, ALU_Source2;

    ALUcontrol my_alu_control(ALUop_EX, FUNCT7_EX, FUNCT3_EX, ALU_Control);
    ALU my_alu(ALU_Control, ALU_Source1, ALU_Source2, ZERO_EX, ALU_OUT_EX);
    mux4_1 my_mux4_1(REG_DATA1_EX, ALU_DATA_WB, ALU_OUT_MEM, 32'b0, forwardA, ALU_Source1);
    mux4_1 my_mux4_2(REG_DATA2_EX, ALU_DATA_WB, ALU_OUT_MEM, 32'b0, forwardB, REG_DATA2_EX_FINAL); 
    mux2_1 my_mux2(REG_DATA2_EX_FINAL, IMM_EX, ALUSrc_EX, ALU_Source2);
    adder my_adder(PC_EX, IMM_EX, PC_Branch_EX);

endmodule
