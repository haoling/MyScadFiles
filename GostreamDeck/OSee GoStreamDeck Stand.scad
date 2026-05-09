use <../common.scad>;

$fa = 0.1;
$fs = 0.1;

fillet_r = 0.3; // フィレット半径（mm）

// linear_extrude(height=20) front_2d();
// difference() {
//   linear_extrude(height=26) back_2d();
//   translate([0, 17, 26]) rotate([0, 90, 0]) linear_extrude(height=500) circle(r = 8);
// }
// linear_extrude(height=2.5) side_2d();
// rotate([90, 0, 0]) translate([0, 0, -3]) curved_panel();
// linear_extrude(height=26) translate([100.5, 0, 0]) rotate([180, 0, 0]) foot_2d_male(l = 2, r = 2.5);

mirror([1, 0, 0]) {
  linear_extrude(height=20) front_2d();
  difference() {
    linear_extrude(height=26) back_2d();
    translate([0, 7, 47]) rotate([0, 90, 0]) linear_extrude(height=500) offset(r=4) offset(r=-4) {
      square(27);
    }
  }
  linear_extrude(height=2.5) side_2d();
  rotate([90, 0, 0]) translate([0, 0, -3]) curved_panel();
  linear_extrude(height=26) translate([100.5, 0, 0]) rotate([180, 0, 0]) foot_2d_male(l = 2, r = 2.5);
}

module foot_2d_male(l = 5, w = 3, r = 5) {
  translate([0, l + r, 0]) circle(r = r);
  polygon([[0 - (w / 2), 0], [w / 2, 0], [w / 2, l + r], [0 - (w / 2), l + r]]);
}

module curved_panel() {
  // カーブ付き平面パネル
  // 左短辺: 27mm, 右短辺: 21mm
  // 上辺: [0,27]→[10,27] 水平 → カーブ → [93,21]→[103,21] 水平
  length       = 106;  // 長辺の長さ (mm)
  h_left       = 20;   // 左の短辺 (mm)
  h_right      = 26;   // 右の短辺 (mm)
  thickness    = 3;    // 厚さ (mm)
  x_flat_left  = 10;  // 左の水平部分が終わるX座標
  x_flat_right = 93;  // 右の水平部分が始まるX座標
  ctrl_offset  = 28;  // ベジェ制御点のオフセット（大きいほど緩やかなカーブ）
  steps        = 100; // カーブの滑らかさ

  // 水平接線のベジェ: P1のY=P0のY、P2のY=P3のY → 両端で水平
  // 右(x_flat_right, h_right) → 左(x_flat_left, h_left) の順で生成
  curve = [for(i = [0:steps])
    [bz(i/steps, x_flat_right, x_flat_right - ctrl_offset, x_flat_left + ctrl_offset, x_flat_left),
     bz(i/steps, h_right,      h_right,                    h_left,                    h_left)]
  ];
  linear_extrude(thickness)
    polygon(concat(
      [[0, 0], [length, 0], [length, h_right], [x_flat_right, h_right]],
      curve,
      [[x_flat_left, h_left], [0, h_left]]
    ));
}

module front_2d() {
  fillet() {
    polygon(
      points=[
        [0, 0],
        [0, 3],
        [-3, 19],
        [0, 19.4],
        [4, 3],
        [4, 0],
      ]
    );
  }
}

module back_2d() {
  fillet() {
    polygon(
      points=[
        [103, 0],
        [103, 34.5],
        [105.5, 34.5],
        [105, 39],
        [95.5, 43],
        [92, 42],
        [94.5, 46],
        [108, 41],
        [106, 0],
      ]
    );
  }
}

module side_2d() {
  difference() {
    fillet() {
      polygon(
        points=[
          [0, 0],
          [0, 3],
          [-3, 19],
          [103, 34.5],
          [103, 0]
        ]
      );
    }
    fillet(2.4, 0.3) {
      hole(24, 6, 12.5);
      hole(39, 6, 14.5);
      hole(54, 6, 16.5);
      hole(69, 6, 18.5);
      hole(84, 6, 20.5);
    }
  }
}

module hole(base_x, base_y, height) {
  polygon(
    points=[
      [base_x, base_y],
      [base_x - 2, base_y + height],
      [base_x + 7, base_y + height + 1.25],
      [base_x + 9, base_y]
    ]
  );
}

function bz(t, p0, p1, p2, p3) =
  pow(1-t,3)*p0 + 3*pow(1-t,2)*t*p1 + 3*(1-t)*pow(t,2)*p2 + pow(t,3)*p3;
