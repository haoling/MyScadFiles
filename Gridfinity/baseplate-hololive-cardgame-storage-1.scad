include <GridFlock\gridflock.scad>
test_pattern = -1;

bed_size = [140, 140];
BASEPLATE_DIMENSIONS = [36, 36];

cells = 4;
rows = 3;
stacked_print_duplicates = 1;

stacked_print_min_gap = 0.5;
trace = [[ for (i = [0 : cells - 1]) 1 ], [ for (i = [0 : rows - 1]) 1 ]];

connector_x_minus = false;
connector_x_plus = true;
connector_y_minus = false;
connector_y_plus = false;
connector = [connector_y_plus, connector_x_plus, connector_y_minus, connector_x_minus];
global_segment_index = 0;

total_height = ceil(_total_height / stacked_print_layer_height + stacked_print_min_gap) * stacked_print_layer_height;

for (i = [0 : stacked_print_duplicates - 1]) {
    translate([0, 0, total_height * i]) flip_segment_conditional([0, i % 2]) intersection() {
        segment(trace=trace, connector=connector, global_segment_index=global_segment_index);
        *translate([0 - (bed_size[0] / 2), 0 - (bed_size[1] / 2), 0]) cube([bed_size[0], bed_size[1], total_height - (stacked_print_layer_height * stacked_print_min_gap)]);
    }
}

// サポート
translate([0, -53, 0]) cylinder(h = total_height * (stacked_print_duplicates - 1), r = 0.2);