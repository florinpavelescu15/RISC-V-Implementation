`timescale 1ns / 1ps

module ALU(A, B, Select, Out, Extra_Bit);
    input [3:0]A, B;
    input [2:0]Select;
    output reg [3:0]Out;
    output Extra_Bit;
    wire [4:0]Sum;

    assign Sum = {1'b0, A} + {1'b0, B};
    assign Extra_Bit = Sum[4];

    always @(A, B, Select)
        begin
            case(Select)
                3'b000:
                    Out = A + B;
                3'b001:
                    if (A == B)
                        Out = 4'b1111;
                    else
                        Out = 4'b0000;
                3'b010: 
                    Out = A >> 1;
                3'b011:
                    Out = ~B + 1;
                3'b100:
                    Out = A & B;
                default: 
                    Out = 4'b0000;
            endcase
        end
endmodule
        