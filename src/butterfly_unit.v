module butterfly_unit (
    input clk,
    input rst,
    input [1:0] k,
    input signed [10:0] x0_re,
    input signed [10:0] x0_im,
    input signed [10:0] x1_re,
    input signed [10:0] x1_im,
    output reg signed [11:0] a0_re,
    output reg signed [11:0] a0_im,
    output reg signed [11:0] a1_re,
    output reg signed [11:0] a1_im
); 
    wire signed [10:0] y1_re;
    wire signed [10:0] y1_im;
    /*verilator lint_off UNUSEDSIGNAL*/
    wire signed [11:0] y1_re_add;
    wire signed [11:0] y1_im_add;
    wire signed [15:0] y1_re_mul;
    wire signed [15:0] y1_im_mul;
    /*verilator lint_on UNUSEDSIGNAL*/
    assign y1_re = (k == 2'b00) ? x1_re : 
                    (k == 2'b01 || k == 2'b11) ? y1_re_mul[15:5] : 
                    x1_im; 
                    
    assign y1_im = (k == 2'b00) ? x1_im : 
                    (k == 2'b01 || k == 2'b11) ? y1_im_mul[15:5] : 
                    -x1_re; 

    assign y1_re_add = (k == 2'b01) ? x1_re + x1_im : 
                       (k == 2'b11) ? x1_im - x1_re : 
                       0; 

    assign y1_im_add = (k == 2'b01) ? x1_im - x1_re : 
                       (k == 2'b11) ? -(x1_re + x1_im) : 
                       0; 
                       
    assign y1_re_mul = {{8{y1_re_add[11]}}, y1_re_add[10:3]} * 16'd181;
    assign y1_im_mul = {{8{y1_im_add[11]}}, y1_im_add[10:3]} * 16'd181;

    always @(posedge clk) begin
        if (rst) begin
            a0_re <= 0;
            a0_im <= 0;
            a1_re <= 0;
            a1_im <= 0;
        end
        else begin
            a0_re <= x0_re + y1_re;
            a0_im <= x0_im + y1_im;
            a1_re <= x0_re - y1_re;
            a1_im <= x0_im - y1_im;
        end
    end
endmodule

