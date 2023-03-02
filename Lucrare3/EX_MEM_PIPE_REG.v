module EX_MEM_PIPE_REG(input clk,
                       input reset,
                       input write,
              
                       input zero_in,
                       input [31:0] ALU_in,
                       input [31:0] PC_in,
                       input [31:0] reg2_data_in,
                       input [4:0] rd_in,
                       input [2:0] func3_in,
                       input RegWrite_in,
                       input MemtoReg_in,
                       input MemRead_in,
                       input MemWrite_in,
                       input Branch_in,
              
                       output reg zero_out,
                       output reg [31:0] ALU_out,
                       output reg [31:0] PC_out,
                       output reg [31:0] reg2_data_out,
                       output reg [4:0] rd_out,
                       output reg [2:0] func3_out,
                       output reg RegWrite_out,
                       output reg MemtoReg_out,
                       output reg MemRead_out,
                       output reg MemWrite_out,
                       output reg Branch_out);
     
     always@(posedge clk) begin
        if (reset) begin 
         zero_out <= 0;
         ALU_out <= 0;
         PC_out <= 32'b0;
         reg2_data_out <= 32'b0;
         rd_out <= 0;
         func3_out <= 3'b0;
         RegWrite_out <= 0;
         MemtoReg_out <= 0;
         MemRead_out <= 0;
         MemWrite_out <= 0;
         Branch_out <= 0;
        end 
        else begin 
           if (write)
           begin 
             zero_out <= zero_in;
             ALU_out <= ALU_in;
             PC_out <= PC_in;
             reg2_data_out <= reg2_data_in;
             rd_out <= rd_in;
             func3_out <= func3_in;
             RegWrite_out <= RegWrite_in;
             MemtoReg_out <= MemtoReg_in;
             MemRead_out <= MemRead_in;
             MemWrite_out <= MemWrite_in;
             Branch_out <= Branch_in;
           end
        end 
     end         
     
endmodule
