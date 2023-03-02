module special_mux (input select,
                    input in1, in2, in3,
                    input [1:0] in4,
                    input in5, in6, in7,
                    output reg out1, out2, out3,
                    output reg [1:0] out4,
                    output reg out5, out6, out7);
    
    always@(in1, in2, in3, in4, in5, in6, in7, select) 
    begin
        if(select)
        begin
            out1 = 1'b0; out2 = 1'b0;
            out3 = 1'b0; out4 = 2'b0;
            out5 = 1'b0; out6 = 1'b0;
            out7 = 1'b0;
        end
        else begin
            out1 = in1; out2 = in2;
            out3 = in3; out4 = in4;
            out5 = in5; out6 = in6;
            out7 = in7;
        end
    end

endmodule
