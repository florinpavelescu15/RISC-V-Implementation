module MEM_WB_PIPE_REG(input clk,
                       input reset,
                       input write,
              
                       input [31:0] data_in,
                       input [31:0] alu_in,
                       input [4:0] rd_in,
                       input RegWrite_in,
                       input MemtoReg_in,
             
                       output reg [31:0] data_out,
                       output reg [31:0] alu_out,
                       output reg [4:0] rd_out,
                       output reg RegWrite_out,
                       output reg MemtoReg_out);
    
     always@(posedge clk) begin
        if (reset) begin 
         data_out <= 0;
         alu_out <= 0;
         rd_out <= 0;
         RegWrite_out <= 0;
         MemtoReg_out <= 0;
        end 
        else begin 
           if (write)
           begin 
             data_out <= data_in;
             alu_out <= alu_in;
             rd_out <= rd_in;
             RegWrite_out <= RegWrite_in;
             MemtoReg_out <= MemtoReg_in;
           end
        end 
     end

endmodule
