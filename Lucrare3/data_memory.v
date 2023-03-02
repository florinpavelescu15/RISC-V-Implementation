module data_memory(input clk,       
                   input mem_read,
                   input mem_write,
                   input [31:0] address,
                   input [31:0] write_data,
                   output reg [31:0] read_data);

    reg [31:0] Memory [0:1023];
    integer i;
    
    initial begin
        for (i = 0; i< 1024; i = i + 1) 
        begin 
            Memory[i] = 32'b0; 
        end
    end 

    //pentru afisarea datelor din memorie in gtkwave
    generate
        genvar idx;
        for(idx = 0; idx < 32; idx = idx + 1) begin: register
            wire [31:0] tmp_Memory;
            assign tmp_Memory = Memory[idx];
        end
    endgenerate
  
     
    always@(posedge clk) 
    begin
        if(mem_write)
          Memory[address[11:2]] <= write_data;
    end
    
    always@(*)
    begin
      if (mem_read == 1) 
          read_data <= Memory[address[11:2]];
      else 
          read_data <= read_data;  
    end
    
endmodule
