include <../36mm-bin-generator.scad>
include <../../common.scad>;

space = 38;

*color("aqua")
translate([37, 0, 0])
rulerZ();

difference()
{
    translate([space * 0, 0, 0]) bin_generator(gridx = 2, gridy = 2, gridz = 5, include_lip = false, style_tab = 5, scoop = 0);
    translate([31, -30, 6.4])
    rotate([0, 0, 0])
    linear_extrude(height = 10) 
    text(text = "2 x 2 x 5", size = 5, halign = "right", valign = "bottom");
}

translate([-1, -6.5, 7])
rotate([90, 0, 90])
linear_extrude(height = 2)
square([41.1, 27]);

difference() {
    translate([-35.2, -5.5, 7])
    rotate([90, 0, 0])
    linear_extrude(height = 2)
    square([70.4, 27]);

    translate([30, -7.3, 12])
    rotate([90, 0, 0])
    linear_extrude(height = 10) 
    text(text = "27mm", size = 5, halign = "right", valign = "bottom");
}