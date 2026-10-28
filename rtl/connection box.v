module connection_box (
    input  wire [15:0] route_in,
    input  wire [3:0]  sel_a,
    input  wire [3:0]  sel_b,
    input  wire [3:0]  sel_c,
    input  wire [3:0]  sel_d,
    output wire [3:0]  lut_in
);
    assign lut_in[0] = route_in[sel_a];
    assign lut_in[1] = route_in[sel_b];
    assign lut_in[2] = route_in[sel_c];
    assign lut_in[3] = route_in[sel_d];
endmodule
