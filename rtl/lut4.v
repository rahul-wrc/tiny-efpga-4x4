module lut4 (
    input  wire [3:0]  in,
    input  wire [15:0] config_bits,
    output wire        out
);
    assign out = config_bits[in];
endmodule
