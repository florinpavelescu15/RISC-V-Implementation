`timescale 1ns / 1ps

module Moore(clk, clr, w, out);
    input clk, clr, w;
    output reg out;
    reg [2:0]state, nextstate;
    
    always @(state, w)
        case (state)
            3'b000:
                if (w)
                        nextstate = 3'b001;
                else
                        nextstate = 3'b000;
            3'b001:
                if (w)
                        nextstate = 3'b010;
                else
                        nextstate = 3'b011;
            3'b010:
                if (w)
                        nextstate = 3'b010;
                else
                        nextstate = 3'b100;
            3'b011:
                if (w)
                        nextstate = 3'b101;
                else
                        nextstate = 3'b000;
            3'b100:
                if (w)
                        nextstate = 3'b101;
                else
                        nextstate = 3'b000;
            3'b101:
                if (w)
                        nextstate = 3'b010;
                else
                        nextstate = 3'b011;
            
        endcase

        always @(posedge clk, negedge clr)
            if (clr)
                state <= 3'b000;
            else
                state <= nextstate;

        always @(state)
            if (state == 3'b100 | state == 3'b101)
                out = 1;
            else 
                out = 0;
endmodule