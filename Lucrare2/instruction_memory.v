`timescale 1ns / 1ps

module instruction_memory(input [9:0] address,
                          output reg [31:0] instruction);
    reg [31:0] codeMemory [0:1023];
    initial $readmemb("code.mem", codeMemory);

    always @(address)
        instruction = codeMemory[address];
endmodule