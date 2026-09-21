use <common.scad>
use <pc-desk-gridfinity-drawer\modules.scad>

$fa = 0.1;
$fs = 0.1;

// コネクタの出る長さ
CL = 8;
// コネクタの遊び
CD = 0.1;

main();

translate([0, 18, 0])
main();

module main() {
    difference()
    {
        union() {
            translate([0, 0, 50])
            rotate([0, 90, 0])
            grip_with_pillars();

            difference() {
                translate([7, 4.5, 0])
                supportPiller(height = 40, length = 7, repeats = 52);

                for(z = [-0.2:1:20])
                translate([0, 0, z])
                translate([0, 0, 50])
                rotate([0, 90, 0])
                grip_with_pillars();
            }
        }

        *linear_extrude(height = 150)
        square([120, 8]);
        *translate([0, 0, 28])
        linear_extrude(height = 150)
        square([120, 40]);
    }


    *difference()
    {
        union()
        {
            grip_with_pillars();
            translate([0, 16, 0]) rotate([0, 0, 180]) grip_with_pillars();
        }

        translate([0, 0, 20])
        linear_extrude(height = 100)
        square([100, 100], center = true);
    }
}

module grip_with_pillars() {
    difference() {
        mirror([1, 0, 0])
        translate([-128, -120, 0])
        import("Nintendo+Switch+2+Joy-con+Grip.3mf");

        translate([CL, 2.5, 7])
        rotate([270, 0, 90])
        pillar_male();

        translate([CL, 8.5, 20])
        rotate([270, 0, 90])
        pillar_male();
    }

    translate([(20 - CL) + 2 + CD, 11, 2])
    rotate([0, 0, 90])
    linear_extrude(height = 10)
    connector_female_2d();

    translate([(20 - CL) + 2 + CD, 5, 15])
    rotate([0, 0, 90])
    linear_extrude(height = 10)
    connector_female_2d();
}

// color("aqua") rulerX();
// color("aqua") rulerY();
// // translate([70, 20, 0])
// color("aqua") rulerZ();