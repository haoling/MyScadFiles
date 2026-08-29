include <../36mm-bin-generator.scad>;
use <../../common.scad>;
include <../../pc-desk-gridfinity-drawer/constants.scad>;
use <../../pc-desk-gridfinity-drawer/modules.scad>;

tissue_box_arm();
translate([36, 108, 0]) rotate([0, 0, 180])
tissue_box_arm();

module tissue_box_arm() {
    translate([18, 36, 0])
    bin_generator(
        gridx = 1,
        gridy = 2,
        gridz = 1.5,
        scoop = 0,
        include_lip = false,
        divx = 0,
        divy = 0
    );

    translate([36, 0.5-0.26, 7]) rotate([90, 0, 180]) {
        translate([0, 0, 36 - 0.26]) rotate([0, 90, 0]) intersection() {
            linear_extrude(height = 36) {
                baseH = 3; // 床の厚さ
                pillerD = 4; // 柱の厚さ
                roofH = 5; // 天井の厚さ
                difference() {
                    union() {
                        // 柱部分
                        translate([10, 0]) {
                            fillet(r = 4, r2 = 4) square([26, 40 + baseH + roofH]);
                            square([26, 20]);
                        }
                        // 天井部分
                        translate([0, 40 + baseH]) fillet(r = 2, r2 = 2) square([30, roofH]);

                        // 床部分
                        square([30, baseH]);
                    }

                    // くり抜く部分
                    color("red") translate([0, baseH]) fillet(r = 6, r2 = 6) square([36 - pillerD, 40]);
                }
            }
            translate([18, -5, 18]) rotate([-90, 0, 0]) bin_generator(
                gridx = 1,
                gridy = 1,
                gridz = 8,
                scoop = 0,
                include_lip = false,
                divx = 0,
                divy = 0
            );
        }
    }

    translate([1, 9.6, 10.7]) color("aqua") supportPiller(space = 2, length = 25, height = 39.1, repeats = 18, width = 0.2);
}
