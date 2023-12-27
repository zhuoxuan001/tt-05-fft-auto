module tt_um_zhuoxuan001_fft_auto_top (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    /* verilator lint_off UNUSEDSIGNAL */
    input  wire [7:0] uio_in,   // IOs: Input path
    /* verilator lint_on UNUSEDSIGNAL */
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // will go high when the design is enabled
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
); 

    reg [3:0] counter = 4'b0;
    reg [7:0] x0_re = 8'b0;
    reg [7:0] x1_re = 8'b0;
    reg [7:0] x2_re = 8'b0;
    reg [7:0] x3_re = 8'b0;
    reg [7:0] x4_re = 8'b0;
    reg [7:0] x5_re = 8'b0;
    reg [7:0] x6_re = 8'b0;
    reg [7:0] x7_re = 8'b0;
    /* verilator lint_off UNUSEDSIGNAL */
    wire signed [8:0] a0_re = 9'b0;
    wire signed [8:0] a0_im = 9'b0;
    wire signed [8:0] a1_re = 9'b0;
    wire signed [8:0] a1_im = 9'b0;
    wire signed [8:0] a2_re = 9'b0;
    wire signed [8:0] a2_im = 9'b0;
    wire signed [8:0] a3_re = 9'b0;
    wire signed [8:0] a3_im = 9'b0;
    wire signed [8:0] a4_re = 9'b0;
    wire signed [8:0] a4_im = 9'b0;
    wire signed [8:0] a5_re = 9'b0;
    wire signed [8:0] a5_im = 9'b0;
    wire signed [8:0] a6_re = 9'b0;
    wire signed [8:0] a6_im = 9'b0;
    wire signed [8:0] a7_re = 9'b0;
    wire signed [8:0] a7_im = 9'b0;
    reg signed [8:0] a0 = 9'b0;
    reg signed [8:0] a1 = 9'b0;
    reg signed [8:0] a2 = 9'b0;
    reg signed [8:0] a3 = 9'b0;
    reg signed [8:0] a4 = 9'b0;
    reg signed [8:0] a5 = 9'b0;
    reg signed [8:0] a6 = 9'b0;
    reg signed [8:0] a7 = 9'b0;
    /* verilator lint_on UNUSEDSIGNAL */

    assign uio_oe = {8{1'b1}};
    assign uio_out = {a7[7] & a7[6], a7[7] & a7[5], a6[7] & a6[6], a6[7] & a6[5], a5[7] & a5[6], a5[7] & a5[5], a4[7] & a4[6], a4[7] & a4[5]};
    assign uo_out = {a3[7] & a3[6], a3[7] & a3[5], a2[7] & a2[6], a2[7] & a2[5], a1[7] & a1[6], a1[7] & a1[5], a0[7] & a0[6], a0[7] & a0[5]};

    always @(posedge clk) begin
        if (~rst_n) begin
            uio_out_reg <= 8'b0;
            counter <= 8'b0;
        end
        if (ena) begin
            if (counter == 4'b0000) begin
                x0_re <= ui_in;
            end
            if (counter == 4'b0001) begin
                x1_re <= ui_in;
            end
            if (counter == 4'b0010) begin
                x2_re <= ui_in;
            end
            if (counter == 4'b0011) begin
                x3_re <= ui_in;
            end
            if (counter == 4'b0100) begin
                x4_re <= ui_in;
            end
            if (counter == 4'b0101) begin
                x5_re <= ui_in;
            end
            if (counter == 4'b0110) begin
                x6_re <= ui_in;
            end
            if (counter == 4'b0111) begin
                x7_re <= ui_in;
            end
            if (counter == 4'b1011) begin
                a0 <= a0_re[4:0] * a0_re[4:0] + a0_im[4:0] * a0_im[4:0];
                a1 <= a1_re[4:0] * a1_re[4:0] + a1_im[4:0] * a1_im[4:0];
                a2 <= a2_re[4:0] * a2_re[4:0] + a2_im[4:0] * a2_im[4:0];
                a3 <= a3_re[4:0] * a3_re[4:0] + a3_im[4:0] * a3_im[4:0];
                a4 <= a4_re[4:0] * a4_re[4:0] + a4_im[4:0] * a4_im[4:0];
                a5 <= a5_re[4:0] * a5_re[4:0] + a5_im[4:0] * a5_im[4:0];
                a6 <= a6_re[4:0] * a6_re[4:0] + a6_im[4:0] * a6_im[4:0];
                a7 <= a7_re[4:0] * a7_re[4:0] + a7_im[4:0] * a7_im[4:0];
            end
            counter <= counter + 4'b0001;
        end
    end

    fft inst1 (
        .clk(new_clk),
        .rst(~rst_n),
        .x0_re(x0_re),
        .x1_re(x1_re),
        .x2_re(x2_re),
        .x3_re(x3_re),
        .x4_re(x4_re),
        .x5_re(x5_re),
        .x6_re(x6_re),
        .x7_re(x7_re),
        .a0_re(a0_re),
        .a0_im(a0_im),
        .a1_re(a1_re),
        .a1_im(a1_im),
        .a2_re(a2_re),
        .a2_im(a2_im),
        .a3_re(a3_re),
        .a3_im(a3_im),
        .a4_re(a4_re),
        .a4_im(a4_im),
        .a5_re(a5_re),
        .a5_im(a5_im),
        .a6_re(a6_re),
        .a6_im(a6_im),
        .a7_re(a7_re),
        .a7_im(a7_im)
    );
endmodule

