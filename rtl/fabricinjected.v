module routing_fabric_integrated (
    input  wire clk,
    input  wire rst,

    // Routing configuration for 25 switch boxes
    input  wire [15:0] cfg [0:24],

    // Configuration for 16 CLBs
    input  wire [15:0] lut_config [0:15],
    input  wire [3:0] sel_a [0:15],
    input  wire [3:0] sel_b [0:15],
    input  wire [3:0] sel_c [0:15],
    input  wire [3:0] sel_d [0:15],
    input  wire use_ff [0:15],

    // Independent test inputs for CLBs
    input  wire [3:0] clb_test_inputs [0:15],

    // CLB outputs
    output wire [15:0] clb_outputs,

    // Routing boundary inputs
    input  wire [1:0] west_boundary_in  [0:4],
    input  wire [1:0] east_boundary_in  [0:4],
    input  wire [1:0] north_boundary_in [0:4],
    input  wire [1:0] south_boundary_in [0:4],

    // Routing boundary outputs
    output wire [1:0] west_boundary_out  [0:4],
    output wire [1:0] east_boundary_out  [0:4],
    output wire [1:0] north_boundary_out [0:4],
    output wire [1:0] south_boundary_out [0:4]
);

    // ------------------------------------------------
    // Original routing fabric
    // ------------------------------------------------
    routing_fabric u_routing_fabric (
        .cfg(cfg),

        .west_boundary_in(west_boundary_in),
        .east_boundary_in(east_boundary_in),
        .north_boundary_in(north_boundary_in),
        .south_boundary_in(south_boundary_in),

        .west_boundary_out(west_boundary_out),
        .east_boundary_out(east_boundary_out),
        .north_boundary_out(north_boundary_out),
        .south_boundary_out(south_boundary_out)
    );

    // ------------------------------------------------
    // CLB input signals
    // ------------------------------------------------
    wire [3:0] clb_lut_inputs [0:15];

    // ------------------------------------------------
    // Instantiate 16 CLBs and their connection boxes
    // ------------------------------------------------
    genvar i;

    generate
        for (i = 0; i < 16; i = i + 1) begin : CLB_ARRAY

            connection_box u_connection_box (
                .route_in({
                    12'b0,
                    clb_test_inputs[i]
                }),

                .sel_a(sel_a[i]),
                .sel_b(sel_b[i]),
                .sel_c(sel_c[i]),
                .sel_d(sel_d[i]),

                .lut_in(clb_lut_inputs[i])
            );

            clb u_clb (
                .lut_in(clb_lut_inputs[i]),
                .lut_config(lut_config[i]),
                .use_ff(use_ff[i]),
                .clk(clk),
                .rst(rst),
                .clb_out(clb_outputs[i])
            );

        end
    endgenerate

endmodule
