`timescale 1ns / 1ps

module IF_ID_PIPE_REG(input clk, res, write,
                      input [31:0] PC_in, INSTRUCTION_in, 
                      output reg [31:0] PC_out, INSTRUCTION_out);
    always @(posedge clk) 
    begin
        if (res) 
        begin
            PC_out <= 0;
            INSTRUCTION_out <= 0;
        end
        else if (write)
        begin
            PC_out <= PC_in;
            INSTRUCTION_out <= INSTRUCTION_in;
        end
    end
endmodule