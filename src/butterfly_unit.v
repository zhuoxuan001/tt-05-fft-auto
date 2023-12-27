module butterfly_unit (
    input clk,
    input rst,
    input [1:0] k,
    input signed [8:0] x0_re,
    input signed [8:0] x0_im,
    input signed [8:0] x1_re,
    input signed [8:0] x1_im,
    output signed [8:0] a0_re,
    output signed [8:0] a0_im,
    output signed [8:0] a1_re,
    output signed [8:0] a1_im
); 
    wire signed [8:0] y1_re;
    wire signed [8:0] y1_im;
    /*verilator lint_off UNUSEDSIGNAL*/
    wire signed [9:0] y1_re_add;
    wire signed [9:0] y1_im_add;
    wire signed [13:0] y1_re_mul;
    wire signed [13:0] y1_im_mul;
    reg signed [9:0] a0_re_reg;
    reg signed [9:0] a0_im_reg;
    reg signed [9:0] a1_re_reg;
    reg signed [9:0] a1_im_reg;
    /*verilator lint_on UNUSEDSIGNAL*/
    assign y1_re = (k == 2'b00) ? x1_re : 
                    (k == 2'b01 || k == 2'b11) ? y1_re_mul[13:5] : 
                    x1_im; 
    assign y1_im = (k == 2'b00) ? x1_im : 
                    (k == 2'b01 || k == 2'b11) ? y1_im_mul[13:5] : 
                    -x1_re; 
    assign y1_re_add = (k == 2'b01) ? x1_re + x1_im : 
                       (k == 2'b11) ? x1_im - x1_re : 
                       0; 
    assign y1_im_add = (k == 2'b01) ? x1_im - x1_re : 
                       (k == 2'b11) ? -(x1_re + x1_im) : 
                       0; 
    assign y1_re_mul = y1_re_add[9:3] * 14'sd181;
    assign y1_im_mul = y1_im_add[9:3] * 14'sd181;
    assign a0_re = a0_re_reg[9:1];
    assign a0_im = a0_im_reg[9:1];
    assign a1_re = a1_re_reg[9:1];
    assign a1_im = a1_im_reg[9:1];

    always @(posedge clk) begin
        if (rst) begin
            a0_re_reg <= 0;
            a0_im_reg <= 0;
            a1_re_reg <= 0;
            a1_im_reg <= 0;
        end
        else begin
            a0_re_reg <= x0_re + y1_re;
            a0_im_reg <= x0_im + y1_im;
            a1_re_reg <= x0_re - y1_re;
            a1_im_reg <= x0_im - y1_im;
        end
    end
endmodule

