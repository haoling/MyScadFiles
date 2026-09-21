include <../36mm-bin-generator.scad>
include <../../common.scad>;
include <../parametric+roll-top+box+1.6.scad>

cube_width = 72;
cube_depth = 71;
cube_height = 52.5;
door_thickness = 0.8; //[0:0.1:10]
show_logo_door = false;
wall_thickness = 1.5;
rail_thickness=0.8; //[0:0.1:10]
rail_radius=30; //[30:1:90]
rail_gap=2.3; //[0:0.1:10]
rail_height = 2; //[0:0.1:10]

difference()
{
    union()
    {
        main();

        *difference() {
            translate([6.3, 3.5, 6])
            rotate([0, 0, 90])
            supportPiller(repeats = 30, height = 50, length = 2.8);

            intersection() for(z = [-0.2:0.2:0.4]) {
                translate([0, 0, z]) main();
            }
        }
    }

    *color("red") translate([10, 0, 0]) cube([100, 100, 100]);
    *color("red") translate([0, 0, -60]) cube([100, 100, 100]);
}

// translate([2, 70.5, 54.1]) mirror([0, 1, 0])
*DoorAssembly();

module main() {
    difference()
    {
        union() {
            translate([36, 36, 0])
            bin_generator(gridx = 2, gridy = 2, gridz = 8, include_lip = false, style_tab = 5, scoop = 0);

            translate([0, 0, 5])
            RailAssembly();

            *translate([1.5, 45.5, 55.2])
            linear_extrude(height = rail_thickness)
            square([69, 25]);
        }

        difference()
        {
            x = -10;
            y = 8;
            z = 54.6;
            r = 1.5;
            translate([x, y - 20, z + 20]) rotate([0, 90, 0]) linear_extrude(height = 90) square([20, 20]);
            translate([x, y, z]) rotate([0, 90, 0]) cylinder(h = 90, r = r);
        }
    }
}

*color("aqua") translate([20, 0.3, 55.2]) rulerY();