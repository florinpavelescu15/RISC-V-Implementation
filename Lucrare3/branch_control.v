module branch_control(input zero, alu_out, Branch,
                      input [2:0] func3,
                      output PCSrc);

wire beq; assign beq = zero & (~func3[2]) & (~func3[1]) & (~func3[0]);
wire bne; assign bne = (~zero) & (~func3[2]) & (~func3[1]) & func3[0];
wire blt; assign blt = alu_out & func3[2] & (~func3[0]);
wire bge; assign bge = (~alu_out) & func3[2] & func3[0];

assign PCSrc = Branch & (beq|bne|blt|bge); 

endmodule