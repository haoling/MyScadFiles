use <./common.scad>;
use <./libs/dotSCAD/src/polyhedron_hull.scad>;

$fa = 0.1;
$fs = 0.1;

d = 3;
h = 30;
w = 140;

// translate([0, 0, h + (d / 2)]) mirror([0, 0, 1])
rotate([90, 0, 0])
{
    translate([0, 0, h + (d / 2)]) rotate([-90, 0, 0]) linear_extrude(height = w)
    fillet(r = d / 3, r2 = d / 3)
    {
        // 天板
        translate([0, h - (d / 2)]) square([80, d]);

        // 奥側の壁
        translate([5 - (d / 2), h / 2]) square([d, h / 2]);

        // 手前側の壁
        translate([40 + (d / 2), 0]) square([d, h]);

        // 柵
        translate([74 + d, h + (d / 2)]) square([d, 5]);
    }

    translate([5 - (d / 2), 0, d - 1]) mirror([1, 0, 0]) triangle(3.5, (h / 2) * 0.8);
    translate([5 - (d / 2), w, d - 1]) mirror([0, 1, 0]) mirror([1, 0, 0]) triangle(3.5, (h / 2) * 0.8);
    translate([40 + (d * 1.5), 0, d - 0.5]) triangle(30, h * 0.8);
    translate([40 + (d * 1.5), w, d - 0.5]) mirror([0, 1, 0]) triangle(30, h * 0.8);

}

*color("aqua") union() {
    translate([3, 0, 0]) rotate([0, 0, 90]) supportPiller(height = h - (d / 2) - 0.3, length = 3, repeats = 3);
    translate([12, 4, 0]) rotate([0, 0, 90]) supportPiller(height = h - (d / 2) - 0.3, length = 12, repeats = 67);
    translate([3, w - 4, 0]) rotate([0, 0, 90]) supportPiller(height = h - (d / 2) - 0.3, length = 3, repeats = 3);
    translate([47, 0, 0]) rotate([0, 0, 90]) supportPiller(height = h - (d / 2) - 0.3, length = 29, repeats = 71);
    translate([70, 0, 0]) rotate([0, 0, 90]) supportPiller(height = h - (d / 2) - 0.3, length = 3, repeats = 3);
    translate([70, 4, 0]) rotate([0, 0, 90]) supportPiller(height = h - (d / 2) - 0.3, length = 17, repeats = 67);
    translate([70, w - 4, 0]) rotate([0, 0, 90]) supportPiller(height = h - (d / 2) - 0.3, length = 3, repeats = 3);
}

module triangle(w, h = h * 0.8, d2 = 20) {
    polyhedron_hull([[0, 0, 0], [0, d2, 0], [w, 0, 0], [0, 0, h]]);
}