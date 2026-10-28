
module routing_link (
    input  wire [1:0] east_out_from_left,
    input  wire [1:0] west_out_from_right,

    output wire [1:0] east_in_to_right,
    output wire [1:0] west_in_to_left
);
    // Eastbound tracks travel from left to right.
    assign east_in_to_right = east_out_from_left;

    // Westbound tracks travel from right to left.
    assign west_in_to_left = west_out_from_right;
endmodule
