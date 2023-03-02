`timescale 1ns / 1ps

module registers(input clk, reg_write,
                 input [4:0] read_reg1, read_reg2, write_reg,
                 input [31:0] write_data,
                 output [31:0] read_data1, read_data2);
    reg [31:0] x [31:0], data1, data2;
    integer idx;

    // initializare registri
    initial
    begin
        for (idx = 0; idx < 32; idx = idx + 1)
            x[idx] = idx;
    end

    // scriere in registru
    always @(posedge clk)
    begin 
        if (reg_write)
            x[write_reg] <= write_data;
    end 

    // citire din registri
    always @(read_reg1) 
    begin 
        data1 = x[read_reg1];
    end
        
    always @(read_reg2)
    begin 
        data2 = x[read_reg2];
    end

    assign read_data1 = data1;
    assign read_data2 = data2;

    // assign read_data1 = x[read_reg1];
    // assign read_data2 = x[read_reg2];
endmodule