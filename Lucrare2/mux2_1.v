`timescale 1ns / 1ps

module mux2_1(input [31:0] ina, inb,
              input sel,
              output reg [31:0] out);
    always @(*)
    begin
        if (!sel)
            out = ina;
        else
            out = inb;
    end
endmodule