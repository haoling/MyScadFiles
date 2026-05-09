include <constants.scad>;
use <modules.scad>;

plate130x108();
// 130mm x 108mm プレート

module plate130x108() {
  space = (130 % (PITCH * 2)) / 2;

  {
    // レール
    translate([108, 0, 0])
    {
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

    // 手前側エッジ
    translate([0 * PITCH, 0, 0]) plate_edge(width = space + PITCH, slope = true, joint = false);
    translate([1 * PITCH, 0, 0]) plate_edge(width = space + PITCH, slope = true, joint = true);
    translate([2 * PITCH, 0, 0]) plate_edge(width = space + PITCH, slope = true, joint = false);
    translate([3 * PITCH, 0, 0]) plate_edge(width = space + PITCH, slope = true, joint = false);
    translate([4 * PITCH, 0, 0]) plate_edge(width = space + PITCH, slope = true, joint = true);
    translate([5 * PITCH, 0, 0]) plate_edge(width = space + PITCH, slope = true, joint = false);

    // 中間エリア
    for (y = [1 : 4])
    {
      for (x = [0 : 5])
      {
        translate([x * PITCH, space + (y * PITCH), 0]) plate_edge();
      }
    }

    // 奥側エッジ
    translate([0 * PITCH, space + (5 * PITCH), 0]) plate_edge(rear = true, width = space + PITCH, slope = true, joint = false);
    translate([1 * PITCH, space + (5 * PITCH), 0]) plate_edge(rear = true, width = space + PITCH, slope = true, joint = true);
    translate([2 * PITCH, space + (5 * PITCH), 0]) plate_edge(rear = true, width = space + PITCH, slope = true, joint = false);
    translate([3 * PITCH, space + (5 * PITCH), 0]) plate_edge(rear = true, width = space + PITCH, slope = true, joint = false);
    translate([4 * PITCH, space + (5 * PITCH), 0]) plate_edge(rear = true, width = space + PITCH, slope = true, joint = true);
    translate([5 * PITCH, space + (5 * PITCH), 0]) plate_edge(rear = true, width = space + PITCH, slope = true, joint = false);
  }

  translate([0, space + (PITCH * 1) + (PITCH / 2), 0]) linear_extrude(height = rB) rotate([0, 0, 90]) connector_female_2d(CONNECTOR_DEPTH + CONNECTOR_ELLIPSE_LENGTH + (mfDiff * 2));
  translate([0, space + (PITCH * 4) + (PITCH / 2), 0]) linear_extrude(height = rB) rotate([0, 0, 90]) connector_female_2d(CONNECTOR_DEPTH + CONNECTOR_ELLIPSE_LENGTH + (mfDiff * 2));
}
