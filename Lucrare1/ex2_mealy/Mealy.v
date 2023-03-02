`timescale 1ns / 1ps

module Mealy(clk, clr, w, out);
    input clk, clr, w;
    output reg out;
    reg nextout;
    reg [1:0]state, nextstate;
    
    always @(state, w)
        case (state)
            2'b00:
                if (w)
                    begin
                        nextstate = 2'b01;
                        nextout = 0;
                    end
                else
                    begin
                        nextstate = 2'b00;
                        nextout = 0;
                    end
            2'b01:
                if (w)
                    begin
                        nextstate = 2'b10;
                        nextout = 0;
                    end
                else
                    begin
                        nextstate = 2'b11;
                        nextout = 0;
                    end
            2'b10:
                if (w)
                    begin
                        nextstate = 2'b10;
                        nextout = 0;
                    end
                else
                    begin
                        nextstate = 2'b11;
                        nextout = 1;
                    end
            2'b11:
                if (w)
                    begin
                        nextstate = 2'b01;
                        nextout = 1;
                    end
                else
                    begin
                        nextstate = 2'b00;
                        nextout = 0;
                    end
        endcase

        always @(posedge clk, negedge clr)
            if (clr)
                begin
                    state <= 2'b00;
                    out <= 0;
                end
            else
                begin
                    state <= nextstate;
                    out <= nextout;
                end
endmodule