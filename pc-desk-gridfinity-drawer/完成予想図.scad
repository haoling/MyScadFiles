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

    // 棚が後ろに落ちないようにする柱
    // を立てるためのレール
    translate([w + mfDiff, 260, 0]) mirror([1, 0, 0]) rotate([0, 0, 90]) back_rail_108();
    // 柱
    translate([54.5, 266, rB]) rotate([90, 0, 90]) pillar(ymax = 18, end_connector = true);
    color("orange") translate([57, (245 + mfDiff) - pD, 142]) mirror([0, 0, 1]) back_rail_connector();
  }

  // 断面図用
  // translate([0, 70, 0]) cube([500, 500, 500]);
}

module finalA() {
  // 左側レール
  rail130(); // 基準点

  // プレート
  translate([w + 1, 0, 0]) plate130x108();

  // プレートに立てる柱
  // side_connectors = [16, 20]; // キャラクターデッキケースW
  side_connectors = [8, 14, 20]; // 3段
  color("lightgreen") let () {
    for (y = [25, /*70,*/ 115]) {
      translate([108 + w + 1, y, rB]) rotate([90, 0, 0]) pillar(ymax = 19, side_connectors = side_connectors);
      translate([w, y, rB]) mirror([1, 0, 0]) rotate([90, 0, 0]) pillar(ymax = 19, side_connectors = side_connectors);
    }
  }

  // 柱に付ける中間レール
  let () {
    for (y = side_connectors) if (y != 20) {
      translate([108, 0, rB + (7 * y)]) rotate([0, 90, 0]) rail130();
      translate([w + 1 + w, 0, rB + (7 * y)]) mirror([1, 0, 0]) rotate([0, 90, 0]) rail130();
    }
  }

  // 板
  let (y = 14) if (y != 0) {
    translate([w + (mfDiff * 2), 0, rB + mfDiff + (7 * y)]) plate130x108(
      connector_left = false,
      rail_right = false,
      snap_clip = true,
    );
  }

  // 天井用コネクタ
  translate([w + 1, 25 - pD, 137]) rotate([0, -90, -90]) roof_connector(center_male = true);
  // translate([w + 1, 70 - pD, 137]) rotate([0, -90, -90]) roof_connector(center_male = false);
  translate([w + 1, 115, 137]) mirror([0, 1, 0]) rotate([0, -90, -90]) roof_connector(center_male = true);
}
