module routing_fabric (
    // Horizontal segments: 5 rows x 4 segments x 2 tracks
    input  wire [39:0] east_drive,
    input  wire [39:0] west_drive,

    // Vertical segments: 4 intervals x 5 segments x 2 tracks
    input  wire [39:0] south_drive,
    input  wire [39:0] north_drive,

    output wire [39:0] east_track,
    output wire [39:0] west_track,
    output wire [39:0] south_track,
    output wire [39:0] north_track
);

    // Horizontal channel wires.
    assign east_track = east_drive;
    assign west_track = west_drive;

    // Vertical channel wires.
    assign south_track = south_drive;
    assign north_track = north_drive;

endmodule
