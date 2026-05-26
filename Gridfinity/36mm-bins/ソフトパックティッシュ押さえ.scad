include <../36mm-bin-generator.scad>;
use <../../common.scad>;
include <../../pc-desk-gridfinity-drawer/constants.scad>;
use <../../pc-desk-gridfinity-drawer/modules.scad>;

preview = true;
preview_cut_y = 20;

difference() {
    union() {
        translate([18, 18, 0]) difference()
        {
            bin_generator(
                gridx = 1,
                gridy = 1,
                gridz = 1,
                scoop = 0,
                include_lip = false,
                divx = 0,
                divy = 0
            );
            translate([7, 0, 0]) pillar_male(w = w + 1);
            translate([-13, 0, 0]) pillar_male(w = w + 1);
        }

        translate(preview ? [0, 36, 7] : [40, 5, 0]) rotate(preview ? [90, 0, 0] : [0, 0, 0]) {
            translate([0, 0, 36]) rotate([0, 90, 0]) intersection() {
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

            translate([8, 1, 18 + (pD / 2)]) rotate([180, 0, 0]) linear_extrude(height = pD) connector_female_2d(height = 6);
            translate([28, 1, 18 + (pD / 2)]) rotate([180, 0, 0]) linear_extrude(height = pD) connector_female_2d(height = 6);
            if (! preview) {
                translate([25, -4.5, 0]) supportPiller(space = 1, length = 4, height = 12.8, repeats = 7, width = 0.2);
                translate([5, -4.5, 0]) supportPiller(space = 1, length = 4, height = 12.8, repeats = 7, width = 0.2);
            }
        }
    }

    if (preview) translate([8, 0, 0]) cube([20, preview_cut_y, 10]);
}
