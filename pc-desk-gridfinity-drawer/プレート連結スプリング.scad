include <constants.scad>;
use <modules.scad>;

let (space = 4) {
  for (x = [0 : 2]) {
    for (y = [0 : 2]) {
      translate([x * (PITCH + space), y * (PITCH + space), 0]) {
        translate([pD / 2, 0, 0]) plate_joint_spring();
      }
    }
  }
}
