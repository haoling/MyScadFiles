include <../36mm-bin-generator.scad>;
use <../../common.scad>;
include <../../pc-desk-gridfinity-drawer/constants.scad>;
use <../../pc-desk-gridfinity-drawer/modules.scad>;

baseH = 3; // 床の厚さ
pillerD = 4; // 柱の厚さ
roofH = 5; // 天井の厚さ

for (x = [0:1:1])
translate([(35.5 + 2) * x, 0, 0])
union() {
    tissue_box_arm();
    translate([36, 108, 0]) rotate([0, 0, 180])
    tissue_box_arm();
}

module tissue_box_arm() {
    translate([18, 36, 0])
    bin_generator(
        gridx = 1,
        gridy = 2,
        gridz = 1,
        scoop = 0,
        include_lip = false,
        divx = 0,
        divy = 0
    );

    translate([36, 0.5-0.26, 4]) rotate([90, 0, 180]) {
        translate([0, 0, 36 - 0.26]) rotate([0, 90, 0])
        intersection()
        {
            linear_extrude(height = 36) {
                difference()
                {
                    union() {
                        // 柱部分
                        translate([10, 0]) {
                            fillet(r = 4, r2 = 4) square([26, 62 + baseH + roofH]);
                            square([26, 20]);
                        }
                        // 天井部分
                        translate([0, 62 + baseH]) fillet(r = 2, r2 = 2) square([30, roofH]);

                        // 中間部分
                        translate([0, 39.5 + baseH]) fillet(r = 1, r2 = 1) square([30, roofH / 2]);

                        // 床部分
                        square([30, baseH]);
                    }

                    // くり抜く部分
                    color("red") translate([0, baseH]) fillet(r = 6, r2 = 6) square([36 - pillerD, 39.5]);
                    color("red") translate([0, baseH + 42]) fillet(r = 6, r2 = 6) square([36 - pillerD, 20]);
                }
            }
            translate([18, -5, 18]) rotate([-90, 0, 0]) bin_generator(
                gridx = 1,
                gridy = 1,
                gridz = 12,
                scoop = 0,
                include_lip = false,
                divx = 0,
                divy = 0
            );
        }
    }

    translate([1, 9.6, 7.7]) color("aqua") supportPiller(space = 2, length = 25, height = 38.6, repeats = 18, width = 0.2);
    translate([1, 9.6, 49.5]) color("aqua") supportPiller(space = 2, length = 25, height = 19.3, repeats = 18, width = 0.2);

}
