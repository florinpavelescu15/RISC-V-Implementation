`timescale 1ns / 1ps

module imm_gen(input [31:0] in, 
               output reg [31:0] out);
    integer i;

    always @(in)
    begin
        case (in[6:0])
            // lw 
            7'b0000011: begin
                            out[0] = in[20];
                            out[4:1] = in[24:21];
                            out[10:5] = in[30:25];
                            for (i = 11; i < 32; i = i + 1)
                                out[i] = in[31];
                        end
            // addi, andi, ori, xori, slti, sltiu, srli, srai, slli
            7'b0010011: begin
                            out[0] = in[20];
                            out[4:1] = in[24:21];
                            out[10:5] = in[30:25];
                            for (i = 11; i < 32; i = i + 1)
                                out[i] = in[31];
                        end
            // sw
            7'b0100011: begin
                            out[0] = in[7];
                            out[4:1] = in[11:8];
                            out[10:5] = in[30:25];
                            for (i = 11; i < 32; i = i + 1)
                                out[i] = in[31];
                        end
            // beq, bne, blt, bge, bltu, bge
            7'b1100011: begin
                            out[0] = 0;
                            out[4:1] = in[11:8];
                            out[10:5] = in[30:25];
                            out[11] = in[7];
                            for (i = 12; i < 32; i = i + 1)
                                out[i] = in[31];
                        end
            // stare x pe intrare => stare x pe iesire
            7'bx: out = 32'bx;
            default: out = 32'b0;  
        endcase
    end
endmodule