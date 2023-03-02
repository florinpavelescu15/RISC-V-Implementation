`timescale 1ns / 1ps
`include "mux2_1.v"

module test_mux2_1;
    reg [31:0] ina, inb;
    reg sel;
    wire [31:0] out;

    initial
    begin
        $dumpfile("test_mux2_1.vcd");
        $dumpvars(0, test_mux2_1);
        ina = 10; inb = 20; sel = 0;
        #10 sel = 1;
        #10 ina = 134; inb = 675;
        #10 sel = 0;
        #10 ina = 12833; inb = 87098; sel = 1;
        #10 sel = 0;
        #10 ina = 0; inb = 76890; sel = 1;
        #10 ina = 1; inb = 1; sel = 0;
        #10 ina = 100000; inb = 700000; sel = 1;
    end

    mux2_1 my_mux(ina, inb, sel, out);
endmodule