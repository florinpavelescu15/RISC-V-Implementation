`timescale 1ns / 1ps
`include "ALU.v"

module test_ALU;
    reg [3:0]A, B;
    reg [2:0]Select;
    wire [3:0]Out;
    wire Extra_Bit;

    initial 
        begin
            $dumpfile("test_ALU.vcd");
            $dumpvars(0, test_ALU);
            Select = 3'b000; A = 4'b0100; B = 4'b1001;
            #10 Select = 3'b001; A = 4'b1010; B = 4'b1100;
            #10 Select = 3'b001; A = 4'b1101; B = 4'b1101;
            #10 Select = 3'b010; A = 4'b1010; B = 4'b1110;
            #10 Select = 3'b011; A = 4'b0011; B = 4'b1010; 
            #10 Select = 3'b100; A = 4'b1101; B = 4'b1010;
            #10 Select = 3'b100; A = 4'b1101; B = 4'b1010;
        end
    
    ALU alu(A, B, Select, Out, Extra_Bit);
endmodule
