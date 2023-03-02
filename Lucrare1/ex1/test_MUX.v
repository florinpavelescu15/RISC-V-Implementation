`timescale 1ns / 1ps
`include "MUX.v"

module test_MUX;
    reg A, B, C, D, a, b;
    wire Q;
    
    initial begin
        $dumpfile("test_MUX.vcd");
        $dumpvars(0, test_MUX);
        
        A = 0; B = 0; C = 0; D = 0; a = 0; b = 0;
        #10 a = 1; b = 0;
        #10 a = 0; b = 1;
        #10 a = 1; b = 1;
        #10 A = 0; B = 1; C = 0; D = 1; a = 0; b = 0;
        #10 a = 1; b = 0;
        #10 a = 0; b = 1;
        #10 a = 1; b = 1;
        #10 A = 1; B = 0; C = 1; D = 0; a = 0; b = 0;
        #10 a = 1; b = 0;
        #10 a = 0; b = 1;
        #10 a = 1; b = 1;
        #10 A = 1; B = 1; C = 0; D = 0; a = 0; b = 0;
        #10 a = 1; b = 0;
        #10 a = 0; b = 1;
        #10 a = 1; b = 1;
        #10 A = 0; B = 0; C = 1; D = 1; a = 0; b = 0;
        #10 a = 1; b = 0;
        #10 a = 0; b = 1;
        #10 a = 1; b = 1;
        #10 A = 0; B = 1; C = 1; D = 0; a = 0; b = 0;
        #10 a = 1; b = 0;
        #10 a = 0; b = 1;
        #10 a = 1; b = 1;
        #10 A = 0; B = 0; C = 1; D = 0; a = 0; b = 0;
        #10 a = 1; b = 0;
        #10 a = 0; b = 1;
        #10 a = 1; b = 1;
        #10 A = 1; B = 1; C = 1; D = 0; a = 0; b = 0;
        #10 a = 1; b = 0;
        #10 a = 0; b = 1;
        #10 a = 1; b = 1;
    end
    
    MUX mux(A, B, C, D, a, b, Q);
endmodule
