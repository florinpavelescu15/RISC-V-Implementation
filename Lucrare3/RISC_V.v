`timescale 1ns / 1ps
`include "IF_ID_PIPE_REG.v"
`include "ID_EX_PIPE_REG.v"
`include "EX_MEM_PIPE_REG.v"
`include "MEM_WB_PIPE_REG.v"
`include "PC.v"
`include "mux2_1.v"
`include "mux4_1.v"
`include "special_mux.v"
`include "adder.v"
`include "ALUControl.v"
`include "ALU.v"
`include "hazard_detection.v"
`include "control_path.v"
`include "branch_control.v"
`include "registers.v"
`include "imm_gen.v"
`include "forwarding.v"
`include "data_memory.v"
`include "instruction_memory.v"

module RISC_V(input clk,
              input reset,
              
              output [31:0] PC_EX,
              output [31:0] ALU_OUT_EX,
              output [31:0] PC_MEM,
              output PCSrc,
              output [31:0] DATA_MEMORY_MEM,
              output [31:0] ALU_DATA_WB,
              output [1:0] forwardA, forwardB,
              output pipeline_stall);
  
  //IF
  wire [31:0] PC_IF;
  wire [31:0] PC_4_IF;
  wire [31:0] PC_mux;
  wire [31:0] Instruction_IF;
  
  //ID
  wire [31:0] PC_ID;
  wire [31:0] Instruction_ID;
  wire [31:0] IMM_ID;
  wire [31:0] REG_DATA1_ID;
  wire [31:0] REG_DATA2_ID;

  //semnalele de control, inainte de inrearea in mux
  wire c1, c2, c3, c5, c6, c7;
  wire [1:0] c4;
  
  wire RegWrite_ID;
  wire MemtoReg_ID;
  wire MemRead_ID;
  wire MemWrite_ID;
  wire [1:0] ALUop_ID;
  wire ALUSrc_ID;
  wire Branch_ID; 
  
  wire [2:0] func3_ID;
  assign func3_ID = Instruction_ID[14:12];
  wire [6:0] func7_ID;
  assign func7_ID = Instruction_ID[31:25];
  wire [6:0] opcode_ID;
  assign opcode_ID = Instruction_ID[6:0];
  wire [4:0] RD_ID;
  assign RD_ID = Instruction_ID[11:7];
  wire [4:0] RS1_ID;
  assign RS1_ID = Instruction_ID[19:15];
  wire [4:0] RS2_ID;
  assign RS2_ID = Instruction_ID[24:20];
  wire IF_ID_write;
  
  //EX
  wire [31:0] PC_Branch_EX;
  wire [31:0] IMM_EX;
  wire [31:0] REG_DATA1_EX;
  wire [31:0] REG_DATA2_EX;
  wire RegWrite_EX;
  wire MemtoReg_EX;
  wire MemRead_EX;
  wire MemWrite_EX;
  wire Branch_EX;
  wire [1:0] ALUop_EX;
  wire ALUSrc;
  wire [2:0] func3_EX;
  wire [6:0] func7_EX;
  wire [4:0] RD_EX;
  wire [4:0] RS1_EX;
  wire [4:0] RS2_EX;
  
  wire [3:0] ALU_Control;
  wire zero_EX;
  wire [31:0] ALU_Source1;
  wire [31:0] ALU_Source2;
  wire [31:0] MUX_B_temp;
  
  
  //MEM
  wire RegWrite_MEM;
  wire MemtoReg_MEM;
  wire MemRead_MEM;
  wire MemWrite_MEM;
  wire Branch_MEM;
  wire [31:0] REG_DATA2_MEM;
  wire [4:0] RD_MEM;
  wire [31:0] ALU_OUT_MEM;
  wire Zero_MEM;
  wire [2:0] func3_MEM;
  
  //WB
  wire RegWrite_WB;
  wire MemtoReg_WB;
  wire [31:0] DATA_Memory_WB;
  wire [31:0] ALU_OUT_WB;
  wire [4:0] RD_WB;
  
  //registrele de pipe
  IF_ID_PIPE_REG my_if_id_pipe_reg(clk, reset, IF_ID_write,
                                   PC_IF, Instruction_IF,
                                   PC_ID, Instruction_ID);
  
  ID_EX_PIPE_REG my_id_ex_pipe_reg(clk, reset, 1'b1, 
                                   IMM_ID, REG_DATA1_ID, REG_DATA2_ID,
                                   PC_ID, func3_ID, func7_ID, 
                                   RD_ID, RS1_ID, RS2_ID,
                                   RegWrite_ID, MemtoReg_ID,
                                   MemRead_ID, MemWrite_ID,
                                   ALUop_ID, ALUSrc_ID, Branch_ID,

                                   IMM_EX, REG_DATA1_EX, REG_DATA2_EX,
                                   PC_EX, func3_EX, func7_EX,
                                   RD_EX, RS1_EX, RS2_EX,
                                   RegWrite_EX, MemtoReg_EX,
                                   MemRead_EX, MemWrite_EX,
                                   ALUop_EX, ALUSrc, Branch_EX);
  
  EX_MEM_PIPE_REG my_ex_mem_pipe_reg(clk, reset, 1'b1,
                                     zero_EX, ALU_OUT_EX, PC_Branch_EX,
                                     MUX_B_temp, RD_EX, func3_EX,
                                     RegWrite_EX, MemtoReg_EX, MemRead_EX,
                                     MemWrite_EX, Branch_EX,

                                     Zero_MEM, ALU_OUT_MEM, PC_MEM,
                                     REG_DATA2_MEM, RD_MEM, func3_MEM,
                                     RegWrite_MEM, MemtoReg_MEM, MemRead_MEM,
                                     MemWrite_MEM, Branch_MEM);
  
  MEM_WB_PIPE_REG my_mem_wb_pipe_reg(clk, reset, 1'b1,
                                     DATA_MEMORY_MEM, ALU_OUT_MEM,
                                     RD_MEM, RegWrite_MEM, MemtoReg_MEM,

                                     DATA_Memory_WB, ALU_OUT_WB,
                                     RD_WB, RegWrite_WB, MemtoReg_WB);
                                         
  //etape
  //IF
  PC my_pc(clk, reset, PC_write, PC_mux, PC_IF); 
  instruction_memory my_instruction_memory(PC_IF[11:2],Instruction_IF);  
  adder my_adder1(PC_IF, 32'b0100, PC_4_IF);
  mux2_1 my_mux2_1(PC_4_IF, PC_MEM, PCSrc, PC_mux); 
  
  //ID
  control_path my_control_path(opcode_ID, c1, c2, c3, c4, c5, c6, c7);
  registers my_registers(clk, RegWrite_WB, RS1_ID, RS2_ID,
                         RD_WB, ALU_DATA_WB, REG_DATA1_ID, REG_DATA2_ID);
  imm_gen my_imm_gen(Instruction_ID,IMM_ID);
  hazard_detection my_hazard_detection(RD_EX, RS1_ID, RS2_ID, MemRead_EX,
                                       PC_write, IF_ID_write, pipeline_stall);
  special_mux my_special_mux(pipeline_stall, c1, c2, c3, c4, c5, c6, c7,
                              Branch_ID, MemRead_ID, MemtoReg_ID, ALUop_ID,
                              MemWrite_ID, ALUSrc_ID, RegWrite_ID);
                                                                        
  //EX                                     
  ALU my_alu(ALU_Control, ALU_Source1,ALU_Source2, zero_EX, ALU_OUT_EX);
  ALUcontrol my_alu_control(ALUop_EX, func7_EX, func3_EX, ALU_Control);
  mux2_1 my_mux2_2(MUX_B_temp, IMM_EX, ALUSrc, ALU_Source2);   
  adder my_adder2(PC_EX, IMM_EX, PC_Branch_EX);
  forwarding my_forwarding(RS1_EX, RS2_EX, RD_MEM, RD_WB, RegWrite_MEM,
                           RegWrite_WB, forwardA, forwardB);
  mux4_1 my_mux4_1(REG_DATA1_EX, ALU_DATA_WB, ALU_OUT_MEM, 32'b0, forwardA, ALU_Source1);               
  mux4_1 my_mux4_2(REG_DATA2_EX, ALU_DATA_WB, ALU_OUT_MEM, 32'b0, forwardB, MUX_B_temp);
                               
  //MEM
  data_memory my_data_memory(clk, MemRead_MEM, MemWrite_MEM,
                             ALU_OUT_MEM, REG_DATA2_MEM, DATA_MEMORY_MEM);
  branch_control my_branch_control(Zero_MEM, ALU_OUT_MEM[0],
                                   Branch_MEM, func3_MEM, PCSrc);                                
                                                  
  //WB
  mux2_1 my_mux2_3(ALU_OUT_WB, DATA_Memory_WB,MemtoReg_WB, ALU_DATA_WB);   
                                                                   
endmodule
