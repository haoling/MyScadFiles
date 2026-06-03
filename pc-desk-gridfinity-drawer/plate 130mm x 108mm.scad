include <constants.scad>;
use <modules.scad>;

plate130x108(
  // connector_left = false, rail_right = false, snap_clip = true,
);
// 130mm x 108mm プレート

module plate130x108(
  connector_left = true,
  connector_female_right = true,
  connector_female_left = true,
  rail_right = true,
  rail_left = false,
  snap_clip = false,
) {
  space = (130 % (PITCH * 2)) / 2;

  {
    // レール
    if (rail_right) {
      translate([108, 0, 0])
      {
        rail(length = space);
        translate([0, space + (PITCH * 0), 0]) rail(pillar = true, sideL = false, sideR = false);
        translate([0, space + (PITCH * 1), 0]) rail(pillar = false, sideL = false, sideR = connector_female_right);
        translate([0, space + (PITCH * 2), 0]) rail(length = PITCH / 2);
        translate([0, space + (PITCH * 2.5), 0]) rail(pillar = true, sideL = false, sideR = false);
        translate([0, space + (PITCH * 3.5), 0]) rail(length = PITCH / 2);
        translate([0, space + (PITCH * 4), 0]) rail(pillar = false, sideL = false, sideR = connector_female_right);
        translate([0, space + (PITCH * 5), 0]) rail(pillar = true, sideL = false, sideR = false);
        translate([0, space + (PITCH * 6), 0]) rail(length = space);
      }
    }

    // 手前側エッジ
    if (rail_left) translate([-1, 0, 0]) plate_edge(width = space + PITCH, slope = true, joint = false);
    translate([0 * PITCH, 0, 0]) plate_edge(width = space + PITCH, slope = true, joint = false);
    translate([1 * PITCH, 0, 0]) plate_edge(width = space + PITCH, slope = true, joint = true);
    translate([2 * PITCH, 0, 0]) plate_edge(width = space + PITCH, slope = true, joint = false);
    translate([3 * PITCH, 0, 0]) plate_edge(width = space + PITCH, slope = true, joint = false);
    translate([4 * PITCH, 0, 0]) plate_edge(width = space + PITCH, slope = true, joint = true);
    translate([5 * PITCH, 0, 0]) plate_edge(width = space + PITCH, slope = true, joint = false);

    // 中間エリア
    for (y = [1 : 4])
    {
      if (rail_left) translate([-1, space + (y * PITCH), 0]) plate_edge();
      for (x = [0 : 5])
      {
        translate([x * PITCH, space + (y * PITCH), 0]) plate_edge();
      }
    }

    // 奥側エッジ
    if (rail_left) translate([-1, space + (5 * PITCH), 0]) plate_edge(rear = true, width = space + PITCH, slope = true, joint = false);
    translate([0 * PITCH, space + (5 * PITCH), 0]) plate_edge(rear = true, width = space + PITCH, slope = true, joint = false);
    translate([1 * PITCH, space + (5 * PITCH), 0]) plate_edge(rear = true, width = space + PITCH, slope = true, joint = true);
    translate([2 * PITCH, space + (5 * PITCH), 0]) plate_edge(rear = true, width = space + PITCH, slope = true, joint = false);
    translate([3 * PITCH, space + (5 * PITCH), 0]) plate_edge(rear = true, width = space + PITCH, slope = true, joint = false);
    translate([4 * PITCH, space + (5 * PITCH), 0]) plate_edge(rear = true, width = space + PITCH, slope = true, joint = true);
    translate([5 * PITCH, space + (5 * PITCH), 0]) plate_edge(rear = true, width = space + PITCH, slope = true, joint = false);
  }

  if (rail_left) {
    translate([-1 - w, 0, 0])
    {
      rail(length = space);
      translate([0, space + (PITCH * 0), 0]) rail(pillar = true, sideL = false, sideR = false);
      translate([0, space + (PITCH * 1), 0]) rail(pillar = false, sideL = connector_female_left, sideR = false);
      translate([0, space + (PITCH * 2), 0]) rail(length = PITCH / 2);
      translate([0, space + (PITCH * 2.5), 0]) rail(pillar = true, sideL = false, sideR = false);
      translate([0, space + (PITCH * 3.5), 0]) rail(length = PITCH / 2);
      translate([0, space + (PITCH * 4), 0]) rail(pillar = false, sideL = connector_female_left, sideR = false);
      translate([0, space + (PITCH * 5), 0]) rail(pillar = true, sideL = false, sideR = false);
      translate([0, space + (PITCH * 6), 0]) rail(length = space);
    }
  }
  if (connector_left) {
    translate([0, space + (PITCH * 1) + (PITCH / 2), 0]) linear_extrude(height = rB) rotate([0, 0, 90]) connector_female_2d(CONNECTOR_DEPTH + CONNECTOR_ELLIPSE_LENGTH + (mfDiff * 2));
    translate([0, space + (PITCH * 4) + (PITCH / 2), 0]) linear_extrude(height = rB) rotate([0, 0, 90]) connector_female_2d(CONNECTOR_DEPTH + CONNECTOR_ELLIPSE_LENGTH + (mfDiff * 2));
  }

  // 前後に動かないようにするツメ
  if (snap_clip) {
    translate([2.25, space + (PITCH * 3) - (pD / 2), rB]) rotate([-90, 0, 0]) linear_extrude(height = pD) difference() { connector_female_2d(height = w + rB - (1 - mfDiff)); square([10, 20]);}
    translate([106.05, space + (PITCH * 3) - (pD / 2), rB]) rotate([-90, 0, 0]) linear_extrude(height = pD) mirror([1, 0, 0]) difference() { connector_female_2d(height = w + rB - (1 - mfDiff)); square([10, 20]);}
  }
}
