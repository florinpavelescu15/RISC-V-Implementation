`timescale 1ns / 1ps
`include "imm_gen.v"

module test_imm_gen;
    reg [31:0] in;
    wire [31:0] out;

    initial
    begin
        $dumpfile("test_imm_gen.vcd");
        $dumpvars(0, test_imm_gen);
        in = 32'b00000000000000001000000100110011;
        #20 in = 32'b00000000000100001000000010010011;
        #20 in = 32'b00000000001000001111000110110011;
        #20 in = 32'b00000000000100001110001000010011;
        #20 in = 32'b00000000010000101010001000100011;
        #20 in = 32'b00000000100000000010011000000011;
        #20 in = 32'b00000100000010010000111001100011;
        #20 $finish;
    end

    imm_gen my_ig(in, out);
endmodule