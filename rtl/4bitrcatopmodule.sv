
module rca_basys3_top (
    input  wire        clk,
    input  wire [15:0] sw,
    output wire [4:0]  led
);

    // Basys 3 inputs
    wire [3:0] A   = sw[3:0];
    wire [3:0] B   = sw[7:4];
    wire       Cin = sw[8];
    wire       rst = 1'b0;

    // CLB configuration
    wire [15:0] lut_config [0:15];
    wire [3:0] sel_a [0:15];
    wire [3:0] sel_b [0:15];
    wire [3:0] sel_c [0:15];
    wire [3:0] sel_d [0:15];
    wire [15:0] use_ff;

    // Switch-box configuration
    wire [15:0] sb_cfg [0:24];
    wire [4:0] inj_w_src [0:24];
    wire [4:0] inj_e_src [0:24];
    wire [4:0] inj_n_src [0:24];
    wire [4:0] inj_s_src [0:24];

    // Fabric boundaries
    wire [15:0] north_boundary;
    wire [15:0] south_boundary;
    wire [9:0] west_boundary;
    wire [9:0] east_boundary;

    // Fabric outputs
    wire [15:0] clb_outputs;
    wire [15:0] north_out, south_out;
    wire [9:0] west_out, east_out;

    // Disable flip-flops for combinational operation
    assign use_ff = 16'b0;

    // Input A and B on west boundary tracks
    assign west_boundary = {
        2'b00,
        B[3], A[3],
        B[2], A[2],
        B[1], A[1],
        B[0], A[0]
    };

    // Carry-in on the north boundary
    assign north_boundary = {
        8'b0, 2'b0, Cin, 3'b0, Cin
    };

    assign south_boundary = 16'b0;
    assign east_boundary  = 10'b0;

    genvar i;

    // Configure sum and carry CLBs
    generate
        for (i = 0; i < 16; i = i + 1) begin : CONFIG_CLBS

            if ((i % 4) == 0) begin : SUM_CLB
                assign lut_config[i] = 16'h9696;
                assign sel_a[i] = 4'd14;
                assign sel_b[i] = 4'd15;
                assign sel_c[i] = 4'd6;
                assign sel_d[i] = 4'd0;
            end
            else if ((i % 4) == 1) begin : CARRY_CLB
                assign lut_config[i] = 16'hE8E8;
                assign sel_a[i] = 4'd14;
                assign sel_b[i] = 4'd15;
                assign sel_c[i] = 4'd4;
                assign sel_d[i] = 4'd0;
            end
            else begin : UNUSED_CLB
                assign lut_config[i] = 16'h0000;
                assign sel_a[i] = 4'd0;
                assign sel_b[i] = 4'd0;
                assign sel_c[i] = 4'd0;
                assign sel_d[i] = 4'd0;
            end

        end
    endgenerate

    // Configure switch boxes and carry injection
    generate
        for (i = 0; i < 25; i = i + 1) begin : CONFIG_SWITCHES

            assign sb_cfg[i] = 16'h0000;

            assign inj_w_src[i] = 5'd0;
            assign inj_e_src[i] = 5'd0;
            assign inj_s_src[i] = 5'd0;

            assign inj_n_src[i] =
                ((i == 5) || (i == 7))   ? 5'd2  :
                ((i == 10) || (i == 12)) ? 5'd6  :
                ((i == 15) || (i == 17)) ? 5'd10 :
                                           5'd0;
        end
    endgenerate

    // Existing custom eFPGA fabric
    routing_fabric_injected fabric (
        .clk(clk),
        .rst(rst),

        .lut_config(lut_config),
        .sel_a(sel_a),
        .sel_b(sel_b),
        .sel_c(sel_c),
        .sel_d(sel_d),
        .use_ff(use_ff),

        .sb_cfg(sb_cfg),

        .inj_w_src(inj_w_src),
        .inj_e_src(inj_e_src),
        .inj_n_src(inj_n_src),
        .inj_s_src(inj_s_src),

        .north_boundary(north_boundary),
        .south_boundary(south_boundary),
        .west_boundary(west_boundary),
        .east_boundary(east_boundary),

        .clb_outputs(clb_outputs),

        .north_out(north_out),
        .south_out(south_out),
        .west_out(west_out),
        .east_out(east_out)
    );

    // Result from the fabric CLBs
    assign led[4:0] = {
        clb_outputs[13],
        clb_outputs[12],
        clb_outputs[8],
        clb_outputs[4],
        clb_outputs[0]
    };

endmodule
