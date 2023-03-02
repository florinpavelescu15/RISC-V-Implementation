module ID_EX_PIPE_REG(input clk,
                      input reset,
                      input write,

                      input [31:0] IMM_in,
                      input [31:0] ALU_A_in,
                      input [31:0] ALU_B_in,
                      input [31:0] PC_in,
                      input [2:0] func3_in,
                      input [6:0] func7_in,
                      input [4:0] RD_in,
                      input [4:0] RS1_in,
                      input [4:0] RS2_in,
                      input RegWrite_in,
                      input MemtoReg_in,
                      input MemRead_in,
                      input MemWrite_in,
                      input [1:0] ALUop_in,
                      input ALUSrc_in,
                      input Branch_in,
                   
                      output reg [31:0] IMM_out,
                      output reg [31:0] ALU_A_out,
                      output reg [31:0] ALU_B_out,
                      output reg [31:0] PC_out,
                      output reg [2:0] func3_out,
                      output reg [6:0] func7_out,
                      output reg [4:0] RD_out,
                      output reg [4:0] RS1_out,
                      output reg [4:0] RS2_out,
                      output reg RegWrite_out,
                      output reg MemtoReg_out,
                      output reg MemRead_out,
                      output reg MemWrite_out,
                      output reg [1:0] ALUop_out,
                      output reg ALUSrc_out,
                      output reg Branch_out);
                   
     always@(posedge clk) begin
        if (reset) begin 
             IMM_out <= 32'b0;
             ALU_A_out <= 0;
             ALU_B_out <= 0;
             PC_out <= 32'b0;
             func3_out <= 0;
             func7_out <= 0;
             RD_out <= 0;
             RS1_out <= 0;
             RS2_out <= 0;
             RegWrite_out <= 0;
             MemtoReg_out <= 0;
             MemRead_out <= 0;
             MemWrite_out <= 0;
             ALUop_out <= 0;
             ALUSrc_out <= 0;
             Branch_out <= 0;
        end 
        else begin 
           if (write)
           begin 
             IMM_out <= IMM_in;
             ALU_A_out <= ALU_A_in;
             ALU_B_out <= ALU_B_in;
             PC_out <= PC_in;
             func3_out <= func3_in;
             func7_out <= func7_in;
             RD_out <= RD_in;
             RS1_out <= RS1_in;
             RS2_out <= RS2_in;
             RegWrite_out <= RegWrite_in;
             MemtoReg_out <= MemtoReg_in;
             MemRead_out <= MemRead_in;
             MemWrite_out <= MemWrite_in;
             ALUop_out <= ALUop_in;
             ALUSrc_out <= ALUSrc_in;
             Branch_out <= Branch_in;
           end
        end 
     end
     
endmodule
