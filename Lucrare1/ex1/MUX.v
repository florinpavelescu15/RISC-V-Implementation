`timescale 1ns / 1ps
`include "NAND2.v"
`include "NAND3.v"
`include "NAND4.v"

module MUX(A, B, C, D, a, b, Q);
    input A, B, C, D, a, b;
    output Q;
    wire w1, w2, w3, w4, w5, w6, w7;
    NAND2 n5(b, b, w5);
    NAND2 n6(a, a, w6);
    NAND3 n1(A, w5, w6, w1);
    NAND3 n2(B, w5, a, w2);
    NAND3 n3(C, w6, b, w3);
    NAND3 n4(D, b, a, w4);
    NAND4 n7(w1, w2, w3, w4, Q);
endmodule
