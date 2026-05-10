include <constants.scad>;
use <modules.scad>;
use <plate 130mm x 108mm.scad>;
use <rail 130mm.scad>;

// difference()
{
  union() {
    finalA();
    translate([0, 130 + mfDiff, 0]) finalA();

    // 天井のプレート間接続コネクタ
    color("orange") translate([57, 115 - pD, 142]) mirror([0, 0, 1]) ceiling_connector();
  }
  // translate([60, 0, 0]) cube([500, 500, 500]);

  // 棚が後ろに落ちないようにする柱
  // を立てるためのレール
  translate([w + mfDiff, 260, 0]) mirror([1, 0, 0]) rotate([0, 0, 90]) back_rail_108();
  // 柱
  translate([57, 266, rB]) rotate([90, 0, 90]) pillar(ymax = 18, end_connector = true);
}

module finalA() {
  // 左側レール
  rail130(); // 基準点

  // プレート
  translate([w + 1, 0, 0]) plate130x108();

  // プレートに立てる柱
  side_connectors = [16, 20]; // キャラクターデッキケースW
  color("lightgreen") let () {
    for (y = [25, /*70,*/ 115]) {
      translate([108 + w + 1, y, rB]) rotate([90, 0, 0]) pillar(ymax = 19, side_connectors = side_connectors);
      translate([w, y, rB]) mirror([1, 0, 0]) rotate([90, 0, 0]) pillar(ymax = 19, side_connectors = side_connectors);
    }
  }

  // 柱に付ける中間レール
  let () {
    translate([108, 0, 114]) rotate([0, 90, 0]) rail130();
    translate([w + 1 + w, 0, 114]) mirror([1, 0, 0]) rotate([0, 90, 0]) rail130();
  }

  // 天井用コネクタ
  translate([w + 1, 25 - pD, 137]) rotate([0, -90, -90]) roof_connector(center_male = true);
  // translate([w + 1, 70 - pD, 137]) rotate([0, -90, -90]) roof_connector(center_male = false);
  translate([w + 1, 115, 137]) mirror([0, 1, 0]) rotate([0, -90, -90]) roof_connector(center_male = true);
}
