
module clb (
    input  wire [3:0]  lut_in,
    input  wire [15:0] lut_config,
    input  wire        use_ff,
    input  wire        clk,
    input  wire        rst,
    output wire        clb_out
);
    wire lut_out;
    reg  ff_out;

    lut4 u_lut4 (
        .in          (lut_in),
        .config_bits (lut_config),
        .out         (lut_out)
    );

    always @(posedge clk) begin
        if (rst)
            ff_out <= 1'b0;
        else
            ff_out <= lut_out;
    end

    assign clb_out = use_ff ? ff_out : lut_out;
endmodule
