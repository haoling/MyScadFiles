include <constants.scad>;
use <modules.scad>;
use <../common.scad>;
use <../libs/dotSCAD/src/arc.scad>;

depth = 5;
angle = atan(18 / 89);
preview = 1;

// 左
rotate(preview ? [90, 0, 90] : [0, 0, 0]) body();

// 右
translate(preview ? [96.4, 0, 0] : [50, 0, 0]) rotate( preview ? [90, 0, 270] : [0, 0, 0]) mirror([1, 0, 0]) body();

// 奥側柱
translate(preview ? [rB, 20, 15] : [54, 0, 0]) rotate(preview ? [0, 0, 270] : [0, 0, 0]) union() {
    pillar(ymax = 6);
    translate([0, (7 * 14) - 5.6, 0]) mirror([0, 1, 0]) pillar(ymax = 6);
}

// 下側柱
translate(preview ? [94.4, 4.6, w] : [64, 0, 0]) rotate(preview ? [0, 90, 90] : [0, 0, 0]) union() {
    pillar(ymax = 6);
    translate([0, (7 * 14) - 5.6, 0]) mirror([0, 1, 0]) pillar(ymax = 6);
}

// コースター
if (preview) color("aqua") translate([3.5, 2.6, 2]) rotate([90 - angle, 0, 0]) linear_extrude(height = 1.3)  fillet(r=4, r2=4) square([89.7, 89.7]);

module body() {
    difference()
    {
        union() {
            linear_extrude(height = depth)
            {
                translate([20 - depth, 0])
                {
                    fillet(r = 0.7, r2 = 0.7)
                    {
                        square(size = [w, 30]);
                        translate([0, 30 - rB]) square(size = [9, rB]);
                        translate([5.7, 0.08]) rotate([0, 0, -4]) square(size = [1.5, 30]);
                    }
                    // translate([1.75, 0.7]) square(size = [0.2, 15]);
                    translate([85.8, 5]) rotate([0, 0, 3]) mirror([1, 0, 0]) arc(80, 10, 0.2);
                }

                // 底辺
                hull()
                {
                    // 手前下
                    color("red") fillet(r = 0.7, r2 = 0.7) square([4, 1.5]);
                    // 斜めの下側の最前点
                    color("red") translate([0, 1.35]) rotate([0, 0, 0 - angle]) square(size = [1.4, 1]);
                    // 底辺奥側
                    color("red") translate([(18 - depth) + 1.5, 0.7]) circle(r = 0.7);
                    // 斜めの中を適当に通過する点
                    color("red") translate([2, w - 0.7]) circle(r = 0.7);
                    // 奥側上
                    color("red") translate([(18 - depth) + 1.5, w - 0.7]) circle(r = 0.7);
                }
                translate([6, 30 - rB]) square(size = [10, rB]);
                translate([0, 1.35]) rotate([0, 0, 0 - angle]) square(size = [3.4, 86]);
            }
            linear_extrude(height = depth * 3) 
            {
                // 底辺
                hull()
                {
                    // 手前下
                    color("red") fillet(r = 0.7, r2 = 0.7) square([4, 1.5]);
                    // 斜めの下側の最前点
                    color("red") translate([0, 1.35]) rotate([0, 0, 0 - angle]) square(size = [1.4, 1]);
                    // 底辺奥側
                    color("red") translate([2, 0.7]) circle(r = 0.7);
                    // 斜めの中を適当に通過する点
                    color("red") translate([0.8, 2]) circle(r = 0.7);
                    // 奥側上
                    color("red") translate([3.5, 2]) circle(r = 0.7);
                }
            }
        }
        translate([15, 20, 0]) pillar_male();
        translate([9.5, 0, 0]) rotate([0, 0, 90]) pillar_male();
        color("red") translate([1.0, rB, w - 2]) rotate([0, 0, 0 - angle]) cube(size = [1.8, 86, depth * 3]);
    }
}