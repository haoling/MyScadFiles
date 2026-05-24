include <constants.scad>;
use <modules.scad>;
use <../common.scad>;
use <../libs/dotSCAD/src/arc.scad>;

coaster_size = 89.7;
coaster_depth = 1.3;
angle_distance = 26;
fixed_angle = 0;
depth = 5 + 0;
angle = fixed_angle != 0 ? fixed_angle : atan(angle_distance / coaster_size);
preview = true;

// 左
rotate(preview ? [90, 0, 90] : [0, 0, 0]) body();

// 右
translate(preview ? [coaster_size + 6.7, 0, 0] : [52 + (coaster_depth * 2), 0, 0]) rotate( preview ? [90, 0, 270] : [0, 0, 0]) mirror([1, 0, 0]) body();

// 奥側柱
translate(preview ? [rB, 18.7 + coaster_depth, 15] : [56 + (coaster_depth * 2), 0, 0]) rotate(preview ? [0, 0, 270] : [0, 0, 0]) union() {
    pillar(ymax = ceil((coaster_size / 7) / 2));
    translate([0, coaster_size + 2.7, 0]) mirror([0, 1, 0]) pillar(ymax = ceil((coaster_size / 7) / 2));
}

// 下側柱
translate(preview ? [coaster_size + 4.7, 3.3 + coaster_depth, w] : [66 + (coaster_depth * 2), 0, 0]) rotate(preview ? [0, 90, 90] : [0, 0, 0]) union() {
    pillar(ymax = ceil((coaster_size / 7) / 2));
    translate([0, coaster_size + 2.7, 0]) mirror([0, 1, 0]) pillar(ymax = ceil((coaster_size / 7) / 2));
}

// コースター
if (preview) color("aqua") translate([3.5, 1.3 + coaster_depth, 1.1]) rotate([90 - angle, 0, 0]) linear_extrude(height = coaster_depth)  fillet(r=4, r2=4) square([coaster_size, coaster_size]);

module body() {
    difference()
    {
        union() {
            linear_extrude(height = depth)
            {
                translate([(18.7 + coaster_depth) - depth, 0])
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
                    color("red") translate([(18 - depth) + 0.7 + coaster_depth, 0.7]) circle(r = 0.7);
                    // 斜めの中を適当に通過する点
                    color("red") translate([2, w - 0.7]) circle(r = 0.7);
                    // 奥側上
                    color("red") translate([(18 - depth) + 0.7 + coaster_depth, w - 0.7]) circle(r = 0.7);
                }
                translate([((30 - rB) / tan(90 - angle)) + coaster_depth, 30 - rB]) square(size = [20 - ((30 - rB) / tan(90 - angle)), rB]);
                difference() {
                    translate([0, 1.35]) rotate([0, 0, 0 - angle]) square(size = [coaster_depth + 2.1, coaster_size * 0.9]);
                    // 傾けたことで底辺からはみ出す部分を消す
                    translate([0, -100]) square([10, 100]);
                }
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
                    color("red") translate([2.2 + coaster_depth, 0.7]) circle(r = 0.7);
                    // 斜めの中を適当に通過する点
                    color("red") translate([0.8, 2]) circle(r = 0.7);
                    // 奥側上
                    color("red") translate([2.2 + coaster_depth, 2]) circle(r = 0.7);
                }
            }
        }
        translate([13.7 + coaster_depth, 20, 0]) pillar_male();
        translate([8.2 + coaster_depth, 0, 0]) rotate([0, 0, 90]) pillar_male();
        color("red") translate([1.0, 1.2, w - 2]) rotate([0, 0, 0 - angle]) cube(size = [coaster_depth + 0.4, coaster_size * 0.9, depth * 3]);
    }
}