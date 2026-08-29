use <./common.scad>;

$fa = 0.1;
$fs = 0.1;

linear_extrude(height = 1.5)
difference()
{
    fillet(r = 1, r2 = 1)
    square([90, 52]);

    translate([35, 37])
    color("red")
    square([40, 35]);

    translate([55, 37])
    color("red")
    circle(40 / 2);
}

// 板部分の上側
union() {
    linear_extrude(height = 1.5)
    translate([0, 47])
    fillet(r = 0.5, r2 = 0.5)
    square([1.75, 20]);

    linear_extrude(height = 0.4)
    translate([1.25, 52])
    square([32.5, 15]);

    linear_extrude(height = 1.5)
    translate([33.25, 47])
    fillet(r = 0.5, r2 = 0.5)
    square([1.75, 20]);

    // バネ側
    linear_extrude(height = 1.5)
    translate([75, 47])
    fillet(r = 1, r2 = 1)
    square([15, 20]);
}

// すきまプレビュー
*color("aqua")
translate([2, 0])
square([1, 20]);

translate([88, 27, 0])
linear_extrude(height = 12)
{
    // 板サイド
    translate([0, 10])
    fillet(r = 0.5, r2 = 0.5)
    square([2, 30]);

    // 天井
    translate([0, 37.5])
    difference()
    {
        fillet(r = 0.25, r2 = 0.25)
        square([5, 2.5]);

        translate([3, 0])
        circle(1.05);
    }

    // バネ
    translate([2.6, 0])
    rotate([0, 0, -2.2])
    fillet(r = 0.4, r2 = 0.4)
    square([1, 40]);
}

// 板とバネの接合強化
translate([86.5, 66, 1.5])
rotate([90, 0, 0])
linear_extrude(height = 28)
difference()
{
    square([1.5, 1.5]);
    translate([0.05, 1.45])
    circle(1.5);
}