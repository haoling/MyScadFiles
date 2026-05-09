$fa = 0.1;
$fs = 0.1;

w = 15;
h = 29;
roof = 3;
pole = 3;
difference() {
  linear_extrude(w) fillet() difference() {
    square([(roof * 2) + (pole * 2), h]);
    square([roof + (pole * 2), h - (roof + (pole * 2) + roof)]);
    translate([roof + pole, h - (roof + pole)]) circle(r = pole);
    translate([roof + 1, h - (roof + (pole * 2) + roof)]) square([(pole * 2) - 1, roof + pole]);
  }
  translate([roof, h - (roof + pole), roof]) rotate([90, 0, 0]) linear_extrude(roof + pole) fillet(2, 2) square([pole * 2, w - (roof * 2)]);
}

linear_extrude(w) difference() {
  translate([-2, 8, 0]) rotate([0, 0, -30]) difference() {
    fillet(2, 2) difference() {
      square([130, 25]);
      color("red") rotate([0, 0, 8]) translate([14, -27.2, 0]) square([200, 25]);
    }
    translate([100, 25, 0]) rotate([180, 0, 0]) foot_2d_male(l = 2, w = 4, r = 3);
  }
  color("red") translate([-10, 0, 0]) square([20, h]);
}

module foot_2d_male(l = 5, w = 3, r = 5) {
  translate([0, l + r, 0]) circle(r = r);
  polygon([[0 - (w / 2), 0], [w / 2, 0], [w / 2, l + r], [0 - (w / 2), l + r]]);
}

module fillet(r = 0.5, r2 = 0.5) {
  // フィレットモジュール
  // 使用例: fillet(r=0.5) { ... }
  // 注意: フィレットはオフセットの前に適用されるため、オフセットと組み合わせて使用することが一般的です。
  offset(r=r) offset(r=-r2) children();
}
