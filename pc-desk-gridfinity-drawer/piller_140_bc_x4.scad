include <constants.scad>;
use <modules.scad>;

side_connectorsL = [8, 14, 20]; // 3段
side_connectorsR = [14, 20]; // Bの下の段なし
let (xmax = 3) {
  for (x = [0 : xmax]) {
    translate([CONNECTOR_DEPTH + 1 + (x * 16), 0, 0])
    {
      pillar(ymax = 19, side_connectors = side_connectorsL);
      translate([w, 0, 0]) mirror([1, 0, 0]) pillar(ymax = 19, side_connectors = side_connectorsR);
    }
  }
}
