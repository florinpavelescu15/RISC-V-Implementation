`timescale 1ns / 1ps
`include "adder.v"

module test_adder;
    reg [31:0] ina, inb;
    wire [31:0] out;

    initial
    begin
        $dumpfile("test_adder.vcd");
        $dumpvars(0, test_adder);
        ina = 10; inb = 20;
        #10 ina = 134; inb = 675;
        #10 ina = 12833; inb = 87098;
        #10 ina = 0; inb = 76890;
        #10 ina = 1; inb = 1;
        #10 ina = 100000; inb = 700000;
    end

    adder my_adder(ina, inb, out);
endmodule