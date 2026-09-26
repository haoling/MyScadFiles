include <constants.scad>;
use <modules.scad>;

piller_140_d_x4();

module piller_140_d_x4(xmax = 3) {
    side_connectors = [11];

    for (x = [0 : xmax]) {
        translate([CONNECTOR_DEPTH + 1 + (x * 12), 0, 0])
        pillar(ymax = 19, side_connectors = side_connectors, end_connector = true);
    }
}
