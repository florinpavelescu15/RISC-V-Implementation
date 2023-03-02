`timescale 1ns / 1ps
`include "registers.v"

module test_registers;
    reg clk, reg_write;
    reg [4:0] read_reg1, read_reg2, write_reg;
    reg [31:0] write_data;
    wire [31:0] read_data1, read_data2;
    
    always #5 clk = ~clk;
    
    initial
    begin
        $dumpfile("test_registers.vcd");
        $dumpvars(0, test_registers);
        clk = 0; 
        reg_write = 1; write_reg = 7; write_data = 2022;
        #10 reg_write = 0; read_reg1 = 7; read_reg2 = 23;
        #10 reg_write = 0; read_reg1 = 10; read_reg2 = 17;
        #10 reg_write = 1; write_reg = 17; write_data = 2023;
        #20 $finish;
    end

    registers my_reg(clk, reg_write, read_reg1, read_reg2, write_reg, write_data, read_data1, read_data2);
endmodule