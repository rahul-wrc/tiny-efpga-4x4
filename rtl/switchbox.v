module switch_box (
    input  wire [1:0] w_in,
    input  wire [1:0] e_in,
    input  wire [1:0] n_in,
    input  wire [1:0] s_in,

    input  wire [15:0] cfg,

    output reg [1:0] w_out,
    output reg [1:0] e_out,
    output reg [1:0] n_out,
    output reg [1:0] s_out
);
    integer i;

    always @(*) begin
        w_out = 2'b00;
        e_out = 2'b00;
        n_out = 2'b00;
        s_out = 2'b00;

        for (i = 0; i < 2; i = i + 1) begin
            case (cfg[i*2 +: 2])
                2'd0: w_out[i] = e_in[i];
                2'd1: w_out[i] = n_in[i];
                2'd2: w_out[i] = s_in[i];
                default: w_out[i] = 1'b0;
            endcase

            case (cfg[4 + i*2 +: 2])
                2'd0: e_out[i] = w_in[i];
                2'd1: e_out[i] = n_in[i];
                2'd2: e_out[i] = s_in[i];
                default: e_out[i] = 1'b0;
            endcase

            case (cfg[8 + i*2 +: 2])
                2'd0: n_out[i] = s_in[i];
                2'd1: n_out[i] = w_in[i];
                2'd2: n_out[i] = e_in[i];
                default: n_out[i] = 1'b0;
            endcase

            case (cfg[12 + i*2 +: 2])
                2'd0: s_out[i] = n_in[i];
                2'd1: s_out[i] = w_in[i];
                2'd2: s_out[i] = e_in[i];
                default: s_out[i] = 1'b0;
            endcase
        end
    end
endmodule

