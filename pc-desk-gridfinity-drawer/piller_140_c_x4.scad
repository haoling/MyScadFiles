include <constants.scad>;
use <modules.scad>;

side_connectors = [14, 20]; // Bの下の段なし
let (xmax = 3) {
    for (x = [0 : xmax]) {
        translate([CONNECTOR_DEPTH + 1 + (x * 12), 0, 0])
        pillar(ymax = 19, side_connectors = side_connectors);
    }
}
