
module routing_fabric (
    input  wire [15:0] cfg [0:24],

    // Incoming signals from outside the fabric
    input  wire [1:0] west_boundary_in  [0:4],
    input  wire [1:0] east_boundary_in  [0:4],
    input  wire [1:0] north_boundary_in [0:4],
    input  wire [1:0] south_boundary_in [0:4],

    // Outgoing signals to outside the fabric
    output wire [1:0] west_boundary_out  [0:4],
    output wire [1:0] east_boundary_out  [0:4],
    output wire [1:0] north_boundary_out [0:4],
    output wire [1:0] south_boundary_out [0:4]
);

    // Horizontal channels between adjacent switch boxes
    wire [1:0] h_e [0:4][0:3];
    wire [1:0] h_w [0:4][0:3];

    // Vertical channels between adjacent switch boxes
    wire [1:0] v_s [0:3][0:4];
    wire [1:0] v_n [0:3][0:4];

    // Incoming and outgoing signals for every switch box
    wire [1:0] w_in  [0:24];
    wire [1:0] e_in  [0:24];
    wire [1:0] n_in  [0:24];
    wire [1:0] s_in  [0:24];

    wire [1:0] w_out [0:24];
    wire [1:0] e_out [0:24];
    wire [1:0] n_out [0:24];
    wire [1:0] s_out [0:24];

    genvar r, c;

    // Connect all 25 switch boxes.
    generate
        for (r = 0; r < 5; r = r + 1) begin : ROW
            for (c = 0; c < 5; c = c + 1) begin : COL

                localparam integer IDX = r * 5 + c;

                // West-facing input
                if (c == 0) begin
                    assign w_in[IDX] = west_boundary_in[r];
                    assign west_boundary_out[r] = w_out[IDX];
                end else begin
                    assign w_in[IDX] = h_e[r][c-1];
                    assign h_w[r][c-1] = w_out[IDX];
                end

                // East-facing input
                if (c == 4) begin
                    assign e_in[IDX] = east_boundary_in[r];
                    assign east_boundary_out[r] = e_out[IDX];
                end else begin
                    assign e_in[IDX] = h_w[r][c];
                    assign h_e[r][c] = e_out[IDX];
                end

                // North-facing input
                if (r == 0) begin
                    assign n_in[IDX] = north_boundary_in[c];
                    assign north_boundary_out[c] = n_out[IDX];
                end else begin
                    assign n_in[IDX] = v_s[r-1][c];
                    assign v_n[r-1][c] = n_out[IDX];
                end

                // South-facing input
                if (r == 4) begin
                    assign s_in[IDX] = south_boundary_in[c];
                    assign south_boundary_out[c] = s_out[IDX];
                end else begin
                    assign s_in[IDX] = v_n[r][c];
                    assign v_s[r][c] = s_out[IDX];
                end

                switch_box u_switch_box (
                    .w_in  (w_in[IDX]),
                    .e_in  (e_in[IDX]),
                    .n_in  (n_in[IDX]),
                    .s_in  (s_in[IDX]),
                    .cfg   (cfg[IDX]),
                    .w_out (w_out[IDX]),
                    .e_out (e_out[IDX]),
                    .n_out (n_out[IDX]),
                    .s_out (s_out[IDX])
                );

            end
        end
    endgenerate

endmodule
