include <constants.scad>;
use <modules.scad>;

// レール2本
for (x = [0 : 1]) {
  translate([x * (w + 2), 0, 0]) rail130();
}
*translate([0 - 9, 0, 0]) cube([9, 130, rB]); // 両面テープ用のりしろ

// レール130mm
module rail130(space = (130 % (PITCH * 2)) / 2) {
  rail(length = space);
  translate([0, space + (PITCH * 0), 0]) rail(pillar = true, sideL = false, sideR = false);
  translate([0, space + (PITCH * 1), 0]) rail(pillar = false, sideL = false, sideR = true);
  translate([0, space + (PITCH * 2), 0]) rail(length = PITCH / 2);
  translate([0, space + (PITCH * 2.5), 0]) rail(pillar = true, sideL = false, sideR = false);
  translate([0, space + (PITCH * 3.5), 0]) rail(length = PITCH / 2);
  translate([0, space + (PITCH * 4), 0]) rail(pillar = false, sideL = false, sideR = true);
  translate([0, space + (PITCH * 5), 0]) rail(pillar = true, sideL = false, sideR = false);
  translate([0, space + (PITCH * 6), 0]) rail(length = space);
}
