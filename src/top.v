module zhuoxuan001_top (
    input clk,
    input rst,
    input [7:0] x0_re,
    input [7:0] x0_im,
    input [7:0] x1_re,
    input [7:0] x1_im,
    input [7:0] x2_re,
    input [7:0] x2_im,
    input [7:0] x3_re,
    input [7:0] x3_im,
    input [7:0] x4_re,
    input [7:0] x4_im,
    input [7:0] x5_re,
    input [7:0] x5_im,
    input [7:0] x6_re,
    input [7:0] x6_im,
    input [7:0] x7_re,
    input [7:0] x7_im,
    output signed [11:0] a0_re,
    output signed [11:0] a0_im,
    output signed [11:0] a1_re,
    output signed [11:0] a1_im,
    output signed [11:0] a2_re,
    output signed [11:0] a2_im,
    output signed [11:0] a3_re,
    output signed [11:0] a3_im,
    output signed [11:0] a4_re,
    output signed [11:0] a4_im,
    output signed [11:0] a5_re,
    output signed [11:0] a5_im,
    output signed [11:0] a6_re,
    output signed [11:0] a6_im,
    output signed [11:0] a7_re,
    output signed [11:0] a7_im
); 

    // first stage
    /* verilator lint_off UNUSEDSIGNAL */
    reg signed [11:0] y0_re;
    reg signed [11:0] y0_im;
    reg signed [11:0] y1_re;
    reg signed [11:0] y1_im;
    reg signed [11:0] y2_re;
    reg signed [11:0] y2_im;
    reg signed [11:0] y3_re;
    reg signed [11:0] y3_im;
    reg signed [11:0] y4_re;
    reg signed [11:0] y4_im;
    reg signed [11:0] y5_re;
    reg signed [11:0] y5_im;
    reg signed [11:0] y6_re;
    reg signed [11:0] y6_im;
    reg signed [11:0] y7_re;
    reg signed [11:0] y7_im;
    /* verilator lint_on UNUSEDSIGNAL */
    butterfly_unit fft0 (
        .clk(clk),
        .rst(rst),
        .k(2'b00),
        .x0_re({3'b0, x0_re}),
        .x0_im({3'b0, x0_im}),
        .x1_re({3'b0, x4_re}),
        .x1_im({3'b0, x4_im}),
        .a0_re(y0_re),
        .a0_im(y0_im),
        .a1_re(y1_re),
        .a1_im(y1_im)
    );
    butterfly_unit fft1 (
        .clk(clk),
        .rst(rst),
        .k(2'b00),
        .x0_re({3'b0, x2_re}),
        .x0_im({3'b0, x2_im}),
        .x1_re({3'b0, x6_re}),
        .x1_im({3'b0, x6_im}),
        .a0_re(y2_re),
        .a0_im(y2_im),
        .a1_re(y3_re),
        .a1_im(y3_im)
    );
    butterfly_unit fft2 (
        .clk(clk),
        .rst(rst),
        .k(2'b00),
        .x0_re({3'b0, x1_re}),
        .x0_im({3'b0, x1_im}),
        .x1_re({3'b0, x5_re}),
        .x1_im({3'b0, x5_im}),
        .a0_re(y4_re),
        .a0_im(y4_im),
        .a1_re(y5_re),
        .a1_im(y5_im)
    );
    butterfly_unit fft3 (
        .clk(clk),
        .rst(rst),
        .k(2'b00),
        .x0_re({3'b0, x3_re}),
        .x0_im({3'b0, x3_im}),
        .x1_re({3'b0, x7_re}),
        .x1_im({3'b0, x7_im}),
        .a0_re(y6_re),
        .a0_im(y6_im),
        .a1_re(y7_re),
        .a1_im(y7_im)
    );

    // second stage
    /* verilator lint_off UNUSEDSIGNAL */
    reg signed [11:0] z0_re;
    reg signed [11:0] z0_im;
    reg signed [11:0] z1_re;
    reg signed [11:0] z1_im;
    reg signed [11:0] z2_re;
    reg signed [11:0] z2_im;
    reg signed [11:0] z3_re;
    reg signed [11:0] z3_im;
    reg signed [11:0] z4_re;
    reg signed [11:0] z4_im;
    reg signed [11:0] z5_re;
    reg signed [11:0] z5_im;
    reg signed [11:0] z6_re;
    reg signed [11:0] z6_im;
    reg signed [11:0] z7_re;
    reg signed [11:0] z7_im;
    /* verilator lint_on UNUSEDSIGNAL */
    butterfly_unit fft4 (
        .clk(clk),
        .rst(rst),
        .k(2'b00),
        .x0_re(y0_re[10:0]),
        .x0_im(y0_im[10:0]),
        .x1_re(y2_re[10:0]),
        .x1_im(y2_im[10:0]),
        .a0_re(z0_re),
        .a0_im(z0_im),
        .a1_re(z2_re),
        .a1_im(z2_im)
    );
    butterfly_unit fft5 (
        .clk(clk),
        .rst(rst),
        .k(2'b10),
        .x0_re(y1_re[10:0]),
        .x0_im(y1_im[10:0]),
        .x1_re(y3_re[10:0]),
        .x1_im(y3_im[10:0]),
        .a0_re(z1_re),
        .a0_im(z1_im),
        .a1_re(z3_re),
        .a1_im(z3_im)
    );
    butterfly_unit fft6 (
        .clk(clk),
        .rst(rst),
        .k(2'b00),
        .x0_re(y4_re[10:0]),
        .x0_im(y4_im[10:0]),
        .x1_re(y6_re[10:0]),
        .x1_im(y6_im[10:0]),
        .a0_re(z4_re),
        .a0_im(z4_im),
        .a1_re(z6_re),
        .a1_im(z6_im)
    );
    butterfly_unit fft7 (
        .clk(clk),
        .rst(rst),
        .k(2'b10),
        .x0_re(y5_re[10:0]),
        .x0_im(y5_im[10:0]),
        .x1_re(y7_re[10:0]),
        .x1_im(y7_im[10:0]),
        .a0_re(z5_re),
        .a0_im(z5_im),
        .a1_re(z7_re),
        .a1_im(z7_im)
    );

    // third stage
    butterfly_unit fft8 (
        .clk(clk),
        .rst(rst),
        .k(2'b00),
        .x0_re(z0_re[10:0]),
        .x0_im(z0_im[10:0]),
        .x1_re(z4_re[10:0]),
        .x1_im(z4_im[10:0]),
        .a0_re(a0_re),
        .a0_im(a0_im),
        .a1_re(a4_re),
        .a1_im(a4_im)
    );
    butterfly_unit fft9 (
        .clk(clk),
        .rst(rst),
        .k(2'b01),
        .x0_re(z1_re[10:0]),
        .x0_im(z1_im[10:0]),
        .x1_re(z5_re[10:0]),
        .x1_im(z5_im[10:0]),
        .a0_re(a1_re),
        .a0_im(a1_im),
        .a1_re(a5_re),
        .a1_im(a5_im)
    );
    butterfly_unit fft10 (
        .clk(clk),
        .rst(rst),
        .k(2'b10),
        .x0_re(z2_re[10:0]),
        .x0_im(z2_im[10:0]),
        .x1_re(z6_re[10:0]),
        .x1_im(z6_im[10:0]),
        .a0_re(a2_re),
        .a0_im(a2_im),
        .a1_re(a6_re),
        .a1_im(a6_im)
    );
    butterfly_unit fft11 (
        .clk(clk),
        .rst(rst),
        .k(2'b11),
        .x0_re(z3_re[10:0]),
        .x0_im(z3_im[10:0]),
        .x1_re(z7_re[10:0]),
        .x1_im(z7_im[10:0]),
        .a0_re(a3_re),
        .a0_im(a3_im),
        .a1_re(a7_re),
        .a1_im(a7_im)
    );
endmodule

