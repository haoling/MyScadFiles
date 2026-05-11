include <constants.scad>;
use <../common.scad>;

// 実験用プレート
let () {
  space = 0;
  translate([0, space + (PITCH * 0), 0]) rail(pillar = false, sideL = false, sideR = false);
  translate([0, space + (PITCH * 1), 0]) rail(pillar = true, sideL = false, sideR = false);
  translate([0, space + (PITCH * 2), 0]) rail(pillar = false, sideL = false, sideR = false);
  translate([0, 32, 8]) rotate([90, 0, 0]) pillar(ymax = 3);

  difference() {
    translate([0, 0, 0]) {
      translate([10, space + (PITCH * 0), 0]) rail(pillar = false, sideL = false, sideR = false);
      translate([10, space + (PITCH * 1), 0]) rail(pillar = true, sideL = false, sideR = false);
      translate([10, space + (PITCH * 2), 0]) rail(pillar = false, sideL = false, sideR = false);
      translate([10, 32, rB]) rotate([90, 0, 0]) pillar(ymax = 3);
    }
    cube([30, 28, 30]);
  }
}

// 天井用
module roof_connector(width = PITCH * 6, center_male = false) {
  translate([0, 0, pD]) mirror([1, 0, 0]) rotate([-90, 0, 90])
  let (width = width - 1) {
    difference() {
      cube([width, pD, w]);

      // 両端のコネクタ
      color("red") translate([((0 - rB) + width) - CONNECTOR_DEPTH, pD / 2, w]) rotate([0, 90, 0]) pillar_male();
      color("red") translate([rB + CONNECTOR_DEPTH, pD / 2, 0]) rotate([0, -90, 0]) pillar_male();

      // 中間のコネクタ
      // color("red") translate([width / 2, rB + CONNECTOR_DEPTH, w]) rotate([90, 90, 0]) pillar_male();
      // color("red") translate([width / 2, rB + CONNECTOR_DEPTH, w]) rotate([-90, 90, 0]) pillar_male();
      if (center_male) {
        translate([(width / 2) - (w / 2), 0, -1]) pillar_male(w = w);
        translate([(width / 2) + (w / 2) + mfDiff, (0 - (pD / 2)) + mfDiff, 1]) cube([mfDiff * 2, pD, 10]);
        translate([(width / 2) - (w / 2) - (mfDiff * 2), (0 - (pD / 2)) + mfDiff, 1]) cube([mfDiff * 2, pD, 10]);
        translate([(width / 2), pD / 2, w - mfDiff]) cube([w + (mfDiff * 2), pD * 2, 2], center = true);
      }
    }
  }
}

// 天井同士の縦方向連結
module ceiling_connector(length = 50 + mfDiff, width = w) {
  translate([0, w - mfDiff, 0]) mirror([0, 1, 0]) rotate([90, 0, 0]) linear_extrude(height = (length - (w * 2)) + (mfDiff * 2)) fillet() square([width, 1]);
  translate([w / 2, w - mfDiff, 0]) rotate([90, 0, 0]) linear_extrude(height = (pD / 2) - mfDiff) connector_female_2d(height = 4);
  translate([w / 2, length, 0]) rotate([90, 0, 0]) linear_extrude(height = (pD / 2) - mfDiff) connector_female_2d(height = 4);
}

// 中間の横2連レール
*let () {
  // translate([4, 64, -12]) rotate([90, 0 ,90])
  translate([w, 0, 0])
  {
    rail(length = space);
    translate([0, space + (PITCH * 0), 0]) rail(pillar = true, sideL = false, sideR = false);
    translate([0, space + (PITCH * 1), 0]) rail(pillar = false, sideL = false, sideR = false);
    translate([0, space + (PITCH * 2), 0]) rail(length = PITCH / 2);
    translate([0, space + (PITCH * 2.5), 0]) rail(pillar = true, sideL = false, sideR = false);
    translate([0, space + (PITCH * 3.5), 0]) rail(length = PITCH / 2);
    translate([0, space + (PITCH * 4), 0]) rail(pillar = false, sideL = false, sideR = false);
    translate([0, space + (PITCH * 5), 0]) rail(pillar = true, sideL = false, sideR = false);
    translate([0, space + (PITCH * 6), 0]) rail(length = space);
    translate([0 - w, 0, 0]) {
      rail(length = space);
      translate([0, space + (PITCH * 0), 0]) rail(pillar = true, sideL = false, sideR = false);
      translate([0, space + (PITCH * 1), 0]) rail(pillar = false, sideL = false, sideR = false);
      translate([0, space + (PITCH * 2), 0]) rail(length = PITCH / 2);
      translate([0, space + (PITCH * 2.5), 0]) rail(pillar = true, sideL = false, sideR = false);
      translate([0, space + (PITCH * 3.5), 0]) rail(length = PITCH / 2);
      translate([0, space + (PITCH * 4), 0]) rail(pillar = false, sideL = false, sideR = false);
      translate([0, space + (PITCH * 5), 0]) rail(pillar = true, sideL = false, sideR = false);
      translate([0, space + (PITCH * 6), 0]) rail(length = space);
    }
  }
}

// デスク引っ掛け用のツメ
let (depth = 5, width = pD + (mfDiff * 2), length = 5) {
  *linear_extrude(height = rB - mfDiff)
  {
    translate([0, length])
    let (
      r = PLATE_JOINT_SPRING_RADIUS, // 円の半径。バネの傾きを決定する
      depth = PLATE_JOINT_SPRING_DEPTH, // バネの厚み
      arc_length = PLATE_JOINT_SPRING_ARC_LENGTH, // 円弧長
      width = PLATE_JOINT_SPRING_PILLAR_WIDTH, // 直線部分の幅
      length = PLATE_JOINT_SPRING_LENGTH / 2 // 全体の長さ
    ) {
      translate([0, length - depth, 0]) // 直線部分に接続する
      plate_joint_spring_arc_2d(d = depth, r = r, x = arc_length);
      translate([0 - (width / 2), 0, 0])
      square([width, length - (depth * 2)]);
    }
    translate([0, length / 2]) square([width, length], center = true);
  }
}

// 柱
module pillar(ymax = 1, segment_height = 7, end_connector = false, side_connectors = [], pD = pD) {
  linear_extrude(height = pD)
  {
    translate([0,  0 * segment_height, 0]) translate([w / 2, segment_height, 0]) mirror([0, 1, 0]) connector_female_2d(segment_height);
    if (ymax - (end_connector ? 1 : 0) >= 1) for (y = [1 : ymax - (end_connector ? 1 : 0)]) translate([0,  y * segment_height, 0]) fillet() square([w, segment_height]);
    if (end_connector) translate([0,  ymax * segment_height, 0]) translate([w / 2, 0, 0]) connector_female_2d(segment_height);
    if (len(side_connectors) > 0) for (i = [0 : len(side_connectors) - 1]) {
      translate([0, ((side_connectors[i] * segment_height) - (w * 1)) + (w / 2)]) rotate([0, 0, 90]) connector_female_2d(CONNECTOR_DEPTH + 1);
    }
  }
}

module rail(length = PITCH, pillar = false, sideL = false, sideR = false) {
  difference()
  {
    mirror([0, 1, 0]) rotate([90, 0, 0]) linear_extrude(height = length) rail_2d();
    translate([0, PITCH / 2, 0])
    {
      if (pillar) pillar_male();
      if (sideL) side_male();
      if (sideR) side_male(true);
    }
  }
}

module connector_inner_2d(female = false) {
  cW = CONNECTOR_CIRCLE_WIDTH + (female ? (mfDiff * 2) : 0);
  cH = CONNECTOR_DEPTH + (female ? mfDiff : 0);
  cH2 = CONNECTOR_ELLIPSE_LENGTH - (female ? mfDiff : 0);

  color("red") 
  translate([0, cH - (cW / 2)]) difference() {
    circle(r=cW / 2);
    translate([0 - (cW / 2), 0 - cW]) square([cW, cW]);
  }
  color("blue") translate([0 - (cW / 2), cH - (cW / 2) - cH2]) square([cW, cH2]);
  color("green") 
  translate([0, cH - (cW / 2) - cH2])
  difference() {
    circle(r=cW / 2);
    translate([0 - (cW / 2), 0]) square([cW, cW]);
  }
}

module rail_2d() {
  square([w, rH - (w / 2)]);
  translate([w / 2, rH - (w / 2)]) circle(r=w / 2);
}

// メス側
module connector_female_2d(height = pH) {
  translate([0 - (w / 2), height])
  mirror([0, 1, 0])
  fillet() difference() {
    square([w, height]);
    translate([w / 2, 0]) connector_inner_2d(female = true);
  }
}

// 柱用の切り欠き
module pillar_male(w = w) {
  translate([0, mfDiff + (pD / 2), 0]) 
  rotate([90, 0, 0])
  linear_extrude(height = pD + (mfDiff * 2)) {
    translate([0, rB]) difference() {
      translate([0 - mfDiff, 0]) square([w + (mfDiff * 2), pH]);
      translate([w / 2, 0]) connector_inner_2d();
    }
  }
}

// 横用の切り欠き
module side_male(mirror = false) {
  translate([(w/ 2) + (mfDiff * 2 * (mirror ? -1 : 1)), 0, 0])
  rotate([0, 0, 90 * (mirror ? -1 : 1)])
  translate([0 - (w / 2), 0, rH])
  mirror([0, 0, 1]) 
  difference()
  {
    linear_extrude(height = rH) {
      difference() {
        translate([0 - (mfDiff * 2), 0]) square([w + (mfDiff * 4), pH]);
        translate([w / 2, 0]) connector_inner_2d();
      }
    }
    // translate([w + 1, 0 - ((w / 2) * 1.6), 1]) rotate([-90, 0, 90])
    // linear_extrude(height = w + 2) {
    //   square([w, rH - (w / 2)]);
    //   translate([w / 2, 0]) circle(r=w / 2);
    // }
    translate([-1, -1, -4.5]) rotate([30, 0, 0])
    cube([10, 5, 10]);
  }
}

// プレート間のジョイントの切り欠き
module plate_joint_male() {
  // rotate([0, 0, 90]) {
  //   translate([0 - (w / 2), 0, 0 - rB]) pillar_male();
  //   translate([0 - (w / 2), 0 - ((pD + (mfDiff * 2)) / 2), (rB - 1) - mfDiff]) cube([w, pD + (mfDiff * 2), 5]);
  // }

  r = PLATE_JOINT_SPRING_RADIUS;
  arc_length = PLATE_JOINT_SPRING_ARC_LENGTH;
  x = arc_length;
  chord_half = r * sin((x / (2 * r)) * (180 / PI)); // 円弧長から弦の半幅を求める
  y = r - sqrt(pow(r, 2) - pow(chord_half, 2)); // 矢高（サジッタ）
  depth = 5;
  width = (chord_half * 2) + (mfDiff * 2);
  pillar_width = PLATE_JOINT_SPRING_PILLAR_WIDTH + (mfDiff * 2);
  spring_depth = 0.2; // バネをたわませる距離
  yi = y * (r - PLATE_JOINT_SPRING_DEPTH) / r; // 内側円弧の矢高（スプリング端の下側の位置）
  translate([0 - (width / 2), (PLATE_JOINT_SPRING_LENGTH / 2) - (yi + PLATE_JOINT_SPRING_DEPTH) + spring_depth, 0]) cube([width, depth, 10]);
  translate([0 - (pillar_width / 2), 0, 0]) cube([pillar_width, PLATE_JOINT_SPRING_LENGTH / 2, 10]);
}

// プレートの端
module plate_edge(width = PITCH, slope = false, joint = false, rear = false) {
  translate([0, rear ? width : 0, 0]) mirror([0, rear ? 1 : 0, 0])
  difference()
  {
    cube([PITCH, width, rB]);
    if (slope) color("red") translate([0, w / 2, rB]) rotate([5, 0, 0]) translate([0, 0 - (w / 2), 0]) cube([PITCH, width, 10]);
    if (joint) translate([PITCH / 2, 0, 0]) plate_joint_male();
  }
}

// プレート同士を接続するバネコネクタ
module plate_joint_spring(
  height = rB - mfDiff, // バネの高さ、プレートの厚みから差し込み部分の余裕を引いた値
  r = PLATE_JOINT_SPRING_RADIUS, // 円の半径。バネの傾きを決定する
  depth = PLATE_JOINT_SPRING_DEPTH, // バネの厚み
  arc_length = PLATE_JOINT_SPRING_ARC_LENGTH, // 円弧長
  width = PLATE_JOINT_SPRING_PILLAR_WIDTH, // 直線部分の幅
  length = PLATE_JOINT_SPRING_LENGTH // 全体の長さ
) {
  // arc_length = r * 2 * asin(spring_width / r) * (PI / 180); // 弦の半幅から円弧長に変換

  linear_extrude(height = height)
  {
    translate([0, length - depth, 0]) // 直線部分に接続する
    translate([0, depth, 0]) // バネの天端の内側を原点に合わせる
    plate_joint_spring_arc_2d(d = depth, r = r, x = arc_length);
    translate([0 - (width / 2), depth, 0])
    square([width, length - (depth * 2)]);
    mirror([0, 1, 0]) 
    plate_joint_spring_arc_2d(d = depth, r = r, x = arc_length);
  }
}
module plate_joint_spring_arc_2d(d, r, x) {
  // x: 円弧の曲線の長さ
  chord_half = r * sin((x / (2 * r)) * (180 / PI)); // 円弧長から弦の半幅を求める
  y = r - sqrt(pow(r, 2) - pow(chord_half, 2)); // 矢高（サジッタ）
  t = atan2(0 - chord_half, sqrt(pow(r, 2) - pow(chord_half, 2)));
  difference()
  {
    translate([0, 0 - (r - y), 0]) // バネの上端を原点に合わせる
    difference()
    {
      translate([0, 0 - y, 0]) difference() {
        circle(r = r);
        circle(r = r - d);
      }
      mirror([1, 0, 0]) rotate([0, 0, t]) square(pD * 10);
      rotate([0, 0, t]) square(pD * 10);
      translate([0 - pD * 5, 0 - (pD * 10), 0]) square(pD * 10);
    }
    plate_joint_spring_arc_fillet_2d(r, d, chord_half, y, t);
    mirror([1, 0, 0]) plate_joint_spring_arc_fillet_2d(r, d, chord_half, y, t);
  }
}
module plate_joint_spring_arc_fillet_2d(r, d, x, y, t) {
  q = sqrt(pow(r, 2) - pow(x, 2));
  K = (0 - d / 2 - y * x / r) / (r - d / 2);
  C = sqrt(1 - pow(K, 2));
  px = (r - d / 2) * (K * q + C * x) / r;
  py = -y + (r - d / 2) * (C * q - K * x) / r;
  color("red")
  translate([px, py - q, 0])
  difference()
  {
    circle(r = d * 10);
    circle(r = d / 2);
    mirror([1, 0]) rotate([0, 0, 0 - t]) translate([0, 0 - (pD * 5)]) square(pD * 10);
  }
}

// 棚が後ろに落ちないようにする柱
module back_rail_108() {
  length = (108 + 1) - (mfDiff * 2); // 余裕を持たせる
  space = (length % (PITCH * 2)) / 2;
  // を立てるためのレール
  translate([11 - w, 0, 0]) {
    rail(length = space);
    translate([0, space + (PITCH * 0), 0]) rail(pillar = false, sideL = false, sideR = false);
    translate([0, space + (PITCH * 1), 0]) rail(pillar = false, sideL = false, sideR = false);
    translate([0, space + (PITCH * 2), 0]) rail(length = PITCH / 2);
    translate([0, space + (PITCH * 2.5), 0]) rail(pillar = true, sideL = false, sideR = false);
    translate([0, space + (PITCH * 3.5), 0]) rail(length = PITCH / 2);
    translate([0, space + (PITCH * 4), 0]) rail(pillar = false, sideL = false, sideR = false);
    translate([0, space + (PITCH * 5), 0]) rail(pillar = false, sideL = false, sideR = false);
    translate([0, space + (PITCH * 6), 0]) rail(length = space);
    translate([0, space + (PITCH * 6) + space, 0]) rail(length = w);
  }
  // 両面テープ用のりしろ
  cube([11 - w, length, rB]);
}
module back_rail_connector() {
  // 柱と天井を接続するT字コネクタ
  ceiling_connector();
  translate([(PITCH / 2) + (w / 2), 31 - mfDiff, 5]) rotate([0, 0, 90]) rail(pillar = true);
  translate([0, pD + mfDiff, 0.5]) cube([w, 10, 10]);
}
