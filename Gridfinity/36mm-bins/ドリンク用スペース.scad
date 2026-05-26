use <../../pc-desk-gridfinity-drawer/modules.scad>;
include <../36mm-bin-generator.scad>
use <../../common.scad>;
use <../../libs/dotSCAD/src/polyline2d.scad>;

// difference()
{
    union()
    {
        difference() {
            bin_generator(
                gridx = 3,
                gridy = 3,
                gridz = 2,
                include_lip = false,
                scoop = 0,
                only_corners = true,
                enable_thumbscrew = true
            );
            translate([0, 0, 6.5]) linear_extrude(height = 2) fillet(r=4, r2=4) square([89.7 + 1, 89.7 + 1], center = true);
        }
        translate([32, -40, 0]) screwSupport();
        translate([-40, -40, 0]) screwSupport();
        translate([32, 32, 0]) screwSupport();
        translate([-40, 32, 0]) screwSupport();
    }

    *translate([35, -65, 0]) cube([30, 30, 30]);
}

module screwSupport()
{
    supportSpace = 2;
    supportLength = 8;
    linear_extrude(height = 4.6) 
    polyline2d(
        points = [
            [supportSpace * 0, 0],
            [supportSpace * 0, supportLength],
            [supportSpace * 1, supportLength],
            [supportSpace * 1, 0],
            [supportSpace * 2, 0],
            [supportSpace * 2, supportLength],
            [supportSpace * 3, supportLength],
            [supportSpace * 3, 0],
            [supportSpace * 4, 0],
            [supportSpace * 4, supportLength],
        ],
        width = 0.2
    );
}