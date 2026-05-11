include <GridFlock\gridflock.scad>
test_pattern = -1;

plate_size = [108, 252];

/* [Filler] */

// When there is not enough room for a full cell, fill the remaining space with a half-width or dynamic width cell (x direction)
filler_x = 1; // [0:None, 1:Integer Fraction, 2:Dynamic]
// When there is not enough room for a full cell, fill the remaining space with a half-width or dynamic width cell (y direction)
filler_y = 1; // [0:None, 1:Integer Fraction, 2:Dynamic]
// Integer fraction of the reduced size cells, e.g. a value of 2 produces half-width cells, a value of 3 produces third-width cells
filler_fraction = [2, 2];
// Minimum size of filler cells in dynamic mode. If a filler cell would be smaller than this value, it is added to the previous cell instead, producing a cell that is larger than 42mm
filler_minimum_size = [15, 15];
// Padding alignment. The first value is the x direction (east/west), the second value the y direction (north/south). When padding is added to the build plate, this alignment is used to distribute it. A lower value will move the grid towards the west/south direction, adding more padding to the east/north
alignment = [0.5, 0.5]; // [0:0.1:1]

/* [Advanced] */

// Edge adjustment values (clockwise: north, east, south, west). These values are *added* to the plate size as padding, i.e. the final plate will end up different than configured in plate_size. This allows you to customize the padding to be asymmetrical. You can also use negative values to "cut" the plate edges if you want to squeeze an extra square out of limited space.
edge_adjust = [0, 0, 0, 0];

// --------------------------------

bed_size = [140, 140];
BASEPLATE_DIMENSIONS = [36, 36];
$fn=40;

// gap between segments in output
_segment_gap = 30;

_NORTH = 0;
_EAST = 1;
_SOUTH = 2;
_WEST = 3;

space = 30;

segment(
    trace=[[1, 1], [1, 1, 1]],
    connector=[false, true, false, false],
    global_segment_index=0
);

translate([(36 * 2) + space, 0, 0])
segment(
    trace=[[1, 1], [1, 1, 1]],
    connector=[false, true, false, true],
    global_segment_index=1
);

translate([(36 * 4) + (space * 2), 0, 0])
segment(
    trace=[[1, 1, 1], [1, 1, 1]],
    connector=[false, false, false, true],
    global_segment_index=2
);

