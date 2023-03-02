`timescale 1ns / 1ps

module NAND2(in1, in2, out);
    input in1, in2;
    output out;
    assign out = ~(in1 & in2);
endmodule
