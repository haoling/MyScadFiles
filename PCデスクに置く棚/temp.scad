use <../common.scad>;

$fa = 0.1;
$fs = 0.1;

PITCH = 18;
w = 5;
rH = 7; // 仕切りレール高さ
rB = 2; // 仕切りレールの底面の厚み
pD = 10; // 柱の幅
// pH = 146; // 柱の高さ
pH = 20;
CONNECTOR_CIRCLE_WIDTH = 3; // メスコネクタの幅
CONNECTOR_DEPTH = 3; // メスコネクタの高さ方向の奥行き
CONNECTOR_ELLIPSE_LENGTH = 0.4; // 半円の下にどれくらいの直線区間を付けるか
mfDiff = 0.2; // メスコネクタの差し込み部分の余裕

PLATE_JOINT_SPRING_RADIUS = pD * 2; // プレートジョイントのバネの円の半径
PLATE_JOINT_SPRING_DEPTH = 1.2; // プレートジョイントのバネの厚み
PLATE_JOINT_SPRING_ARC_LENGTH = (pD * 1.5) - (mfDiff * 2); // プレートジョイントのバネの円弧長
PLATE_JOINT_SPRING_PILLAR_WIDTH = 2;
PLATE_JOINT_SPRING_LENGTH = (pD * 2) - (mfDiff * 2); // プレートジョイントのバネの全体の長さ

// 実験用プレート
*let () {
  translate([15, 0, 0]) plate_edge(width = 18, slope = true, joint = true);
  // translate([-23, -18, 0])
  translate([38, 0, 0]) plate_edge(width = 18, slope = true, joint = true, rear = true);
  // translate([23, 0 - (w / 2), rB - mfDiff]) mirror([0, 0, 1]) rotate([0, 0, 90])
  // translate([0, pD - (mfDiff * 2), 0]) rotate([90, 0, 0]) linear_extrude(height = pD - (mfDiff * 2)) translate([w / 2, 0])
  // {
  //   connector_female_2d(rB - mfDiff);
  //   translate([0 - (w / 2), 0]) fillet() square([w, 1 - mfDiff]);
  // }
  // translate([17, 0 - (PLATE_JOINT_SPRING_LENGTH / 2), 0])
  translate([pD / 2, 0, 0])
  plate_joint_spring();
}


// 130mm x 108mm プレート
*let () {
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

// レール130mm
space = (130 % (PITCH * 2)) / 2;
*let () {
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

// 柱 140mm
*for (x = [0 : 5]) {
    translate([CONNECTOR_DEPTH + 1 + (x * 12), 0, 0])
    linear_extrude(height = pD)
    {
      translate([0,  0 * 7, 0]) translate([w / 2, 7, 0]) mirror([0, 1, 0]) connector_female_2d(7);
      for (y = [1 : 18]) translate([0,  y * 7, 0]) fillet() square([w, 7]);
      translate([0,  19 * 7, 0]) translate([w / 2, 0, 0]) connector_female_2d(7);
      translate([0, ((10 * 7) - (w * 1)) + (w / 2) - 1]) rotate([0, 0, 90]) connector_female_2d(CONNECTOR_DEPTH + 1);
      translate([0, ((10 * 7) - (w * 2)) + (w / 2) - 1]) rotate([0, 0, 90]) connector_female_2d(CONNECTOR_DEPTH + 1);
    }
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
module pillar_male() {
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
  echo (str("chord_half: ", chord_half));
  echo (str("y: ", y));
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