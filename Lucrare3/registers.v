///////////////////////////////////REGISTER_FILE_MODULE///////////////////////////////////////////////////////
module registers(input clk,reg_write,
                 input [4:0] read_reg1,read_reg2,write_reg,
                 input [31:0] write_data,
                 output [31:0] read_data1,read_data2);
  
  reg [31:0] Registers [0:31];
  
  integer i;
  initial begin
    for (i = 0; i < 32; i = i + 1) begin
      Registers[i] = i;
    end
  end

  //pentru afisarea datelor din registri in gtkwave
  generate
    genvar idx;
    for(idx = 0; idx < 32; idx = idx + 1) begin: register
      wire [31:0] tmp_Registers;
      assign tmp_Registers = Registers[idx];
    end
  endgenerate
  //
  
  always@(posedge clk) begin
    if(reg_write && write_reg)
      Registers[write_reg] <= write_data;
  end
  
  assign read_data1 = (read_reg1 != 5'b0) ? //it is different from x0
                      (((reg_write == 1'b1)&&(read_reg1 == write_reg)) ? 
                      write_data : Registers[read_reg1]) : 32'b0;
                      
  assign read_data2 = (read_reg2 != 5'b0) ? //it is different from x0
                      (((reg_write == 1'b1)&&(read_reg2 == write_reg)) ? 
                      write_data : Registers[read_reg2]) : 32'b0;

endmodule
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
