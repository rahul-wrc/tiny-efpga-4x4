
`timescale 1ns / 1ps

// 4-bit RCA using the same LUT4 and CLB modules.
// Dedicated input path for A, B and Cin.
// Carry propagates from one carry CLB to the next.

module rca_fabric_test (
    input  wire [3:0] A,
    input  wire [3:0] B,
    input  wire       Cin,
    input  wire       clk,
    input  wire       rst,

    output wire [3:0] Sum,
    output wire       Cout
);

    wire [4:0] carry;
    wire [3:0] sum_internal;

    assign carry[0] = Cin;

    genvar i;
    generate
        for (i = 0; i < 4; i = i + 1) begin : RCA_STAGE

            wire [3:0] lut_inputs;
            wire sum_bit;
            wire carry_bit;

            // LUT inputs: bit 0 = A, bit 1 = B,
            // bit 2 = carry-in, bit 3 = unused.
            assign lut_inputs = {1'b0, carry[i], B[i], A[i]};

            clb SUM_CLB (
                .lut_in(lut_inputs),
                .lut_config(16'h9696),
                .use_ff(1'b0),
                .clk(clk),
                .rst(rst),
                .clb_out(sum_bit)
            );

            clb CARRY_CLB (
                .lut_in(lut_inputs),
                .lut_config(16'hE8E8),
                .use_ff(1'b0),
                .clk(clk),
                .rst(rst),
                .clb_out(carry_bit)
            );

            assign sum_internal[i] = sum_bit;
            assign carry[i+1] = carry_bit;

        end
    endgenerate

    assign Sum  = sum_internal;
    assign Cout = carry[4];

endmodule


module tb_rca_fabric_test;

    reg [3:0] A, B;
    reg Cin;
    reg clk, rst;

    wire [3:0] Sum;
    wire Cout;

    reg [4:0] expected;
    integer a, b, c;
    integer passed, failed;

    rca_fabric_test dut (
        .A(A),
        .B(B),
        .Cin(Cin),
        .clk(clk),
        .rst(rst),
        .Sum(Sum),
        .Cout(Cout)
    );

    initial clk = 1'b0;
    always #5 clk = ~clk;

    initial begin
        A = 0;
        B = 0;
        Cin = 0;
        rst = 1;
        passed = 0;
        failed = 0;
        
        #12;
        rst = 0;

        $display("========================================");
        $display("  4-BIT LUT-BASED RIPPLE CARRY ADDER");
        $display("  Exhaustive test: 512 combinations");
        $display("========================================");

        for (a = 0; a < 16; a = a + 1) begin
            for (b = 0; b < 16; b = b + 1) begin
                for (c = 0; c < 2; c = c + 1) begin

                    A = a;
                    B = b;
                    Cin = c;

                    expected = a + b + c;

                    #1;

                    if ({Cout, Sum} === expected) begin
                        passed = passed + 1;
                    end
                    else begin
                        failed = failed + 1;
                        $display(
                            "FAIL: A=%0d B=%0d Cin=%0d | Got=%b_%b Expected=%b",
                            a, b, c, Cout, Sum, expected
                        );
                    end

                end
            end
        end

        $display("----------------------------------------");
        $display("Total tests : %0d", passed + failed);
        $display("Passed      : %0d", passed);
        $display("Failed      : %0d", failed);
        $display("----------------------------------------");

        if (passed == 512 && failed == 0)
            $display("RESULT: ALL 512 TESTS PASSED");
        else
            $display("RESULT: TEST FAILED");

        $finish;
    end

endmodule
