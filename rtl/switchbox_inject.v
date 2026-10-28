
module switch_box_inject (
    input  wire [1:0] w_neighbor,
    input  wire [1:0] e_neighbor,
    input  wire [1:0] n_neighbor,
    input  wire [1:0] s_neighbor,

    input  wire [1:0] w_clb,
    input  wire [1:0] e_clb,
    input  wire [1:0] n_clb,
    input  wire [1:0] s_clb,

    input  wire [7:0] inject_enable,
    input  wire [15:0] cfg,

    output wire [1:0] w_out,
    output wire [1:0] e_out,
    output wire [1:0] n_out,
    output wire [1:0] s_out
);

    wire [1:0] w_selected, e_selected;
    wire [1:0] n_selected, s_selected;

    assign w_selected = {
        inject_enable[1] ? w_clb[1] : w_neighbor[1],
        inject_enable[0] ? w_clb[0] : w_neighbor[0]
    };

    assign e_selected = {
        inject_enable[3] ? e_clb[1] : e_neighbor[1],
        inject_enable[2] ? e_clb[0] : e_neighbor[0]
    };

    assign n_selected = {
        inject_enable[5] ? n_clb[1] : n_neighbor[1],
        inject_enable[4] ? n_clb[0] : n_neighbor[0]
    };

    assign s_selected = {
        inject_enable[7] ? s_clb[1] : s_neighbor[1],
        inject_enable[6] ? s_clb[0] : s_neighbor[0]
    };

    switch_box u_switch_box (
        .w_in(w_selected),
        .e_in(e_selected),
        .n_in(n_selected),
        .s_in(s_selected),
        .cfg(cfg),
        .w_out(w_out),
        .e_out(e_out),
        .n_out(n_out),
        .s_out(s_out)
    );

endmodule
