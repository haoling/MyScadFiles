use <./common.scad>;

$fa = 0.1;
$fs = 0.1;

translate([0, 0, 67])
rotate([-90, 0, 0])
deckcase_separator();

color("aqua")
{
    translate([57, 0.8, 0])
    supportPiller(height = 14.8, length = 5, repeats = 15);

    *translate([0, -5.4, 0])
    supportPiller(height = 14.8, length = 5, repeats = 20);

    *difference()
    {
        translate([37.5, 0, 0])
        supportPiller(space = 5, height = 60, length = 2, repeats = 8);

        for (x = [-0.8, 0.8, 0.8])
        for (y = [-0.8, 0.8, 0.8])
        for (z = [0.0, 0.4, 0.4])
        translate([x, y, z])
        translate([0, 0, 67])
        rotate([-90, 0, 0])
        deckcase_separator();
    }
}

module deckcase_separator()
{
    // バネ側の下側
    linear_extrude(height = 1.5)
    translate([53, 0, 0])
    fillet(r = 1, r2 = 1)
    square([36.5, 52]);

    // バネ反対側
    linear_extrude(height = 1.5)
    difference()
    {
        fillet(r = 0.5, r2 = 0.5)
        square([55, 67]);

        /*
        r = 20;
        h = 15;
        color("red")
        translate([10 + r, h + r])
        circle(r = r);

        color("red")
        translate([10, h + r])
        square([r * 2, 67 - h - r]);
        */

        color("red")
        polygon([
            [45, 67],
            [29.815, 16.55],
            [25.185, 16.55],
            [10, 67],
        ]);
        color("red")
        translate([27.5, 17.5])
        circle(r = 2.5);
    }

    // 板部分の上側
    union() {

        // 薄い部分
        linear_extrude(height = 0.4)
        translate([54.75, 52])
        square([32.5, 15]);

        // バネ側
        linear_extrude(height = 1.5)
        translate([86.5, 47])
        fillet(r = 1, r2 = 1)
        square([3, 20]);
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
}