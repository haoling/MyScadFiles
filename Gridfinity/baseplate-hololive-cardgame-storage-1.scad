include <GridFlock\gridflock.scad>
test_pattern = -1;

bed_size = [140, 140];
BASEPLATE_DIMENSIONS = [36, 36];

cells = 2;
rows = 3;

trace = [[ for (i = [0 : cells - 1]) 1 ], [ for (i = [0 : rows - 1]) 1 ]];

connector_x_minus = false;
connector_x_plus = true;
connector_y_minus = false;
connector_y_plus = false;
connector = [connector_y_plus, connector_x_plus, connector_y_minus, connector_x_minus];
global_segment_index = 0;

segment(trace=trace, connector=connector, global_segment_index=global_segment_index);
