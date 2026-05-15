include <../36mm-bin-generator.scad>

difference() {
    bin_generator(
        gridx = 1,
        gridy = 3,
        gridz = 5,
        scoop = 0,
        include_lip = false,
        divx = 0,
        divy = 0
    );

    translate([13, -34.5, 8])
    rotate([0, 0, 90])
    hull()
    {
        r = 2.5;
        // 正面から画面を見て

        // 底辺
        // 手前
        // 左
        sphere(r = r);
        // 右
        translate([69, 0, 0]) sphere(r = r);
        // 奥
        // 左
        translate([24, 25, 0]) sphere(r = r);
        // 右
        translate([69-24, 25, 0]) sphere(r = r);
        // 背中
        // 左の肩甲骨
        translate([10, 25, 110]) sphere(r = r);
        // 右の肩甲骨
        translate([69-10, 25, 110]) sphere(r = r);
        // 左肩
        translate([0, 17.5, 125]) sphere(r = r);
        // 右肩
        translate([69, 17.5, 125]) sphere(r = r);

        // 正面側を垂直に上げるための架空の点
        translate([0, 0, 125]) sphere(r = r);
        translate([69, 0, 125]) sphere(r = r);
    }

    hull() {
        translate([-13, -23, 35]) sphere(r = 3);
        translate([-13, -49, 35]) sphere(r = 3);
        translate([13, -49, 35]) sphere(r = 3);
        translate([-13, -23, 8]) sphere(r = 3);
        translate([-13, -49, 8]) sphere(r = 3);
        translate([13, -49, 8]) sphere(r = 3);
    }

    hull() {
        translate([-13, 23, 35]) sphere(r = 3);
        translate([-13, 49, 35]) sphere(r = 3);
        translate([13, 49, 35]) sphere(r = 3);
        translate([-13, 23, 8]) sphere(r = 3);
        translate([-13, 49, 8]) sphere(r = 3);
        translate([13, 49, 8]) sphere(r = 3);
    }
}
