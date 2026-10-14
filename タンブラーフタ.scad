use <common.scad>

$fa = 0.1;
$fs = 0.1;

cutX = 0; // [-88:0.1:88]
cutY = 0; // [-88:0.1:88]
cutZ = 0; // [0:0.1:22]


// translate([0, 0, -0.2]) rulerX();
// translate([-42, 0, 0]) rulerZ();
// translate([46, 0, 0]) rulerZ();

difference()
{
    translate([44, 44, 0])
    difference()
    {
        union() {
            rotate_extrude() translate([35, 0, 0])
            {
                fillet()
                difference()
                {
                    // ベース
                    square([9, 21]);

                    // いちばん外側を削る
                    color("red") translate([4.5, 5.5]) square([4.5, 21]);

                    // パッキンの入るところ
                    color("red") translate([4.5 - 1.8, 11.4]) square([1.8, 5.7]);

                    // 上部の斜め部分
                    color("red") translate([7, 14]) rotate([0, 0, 30]) square([10, 10]);

                    // 下部の斜め部分
                    color("red") translate([-9.5, -6.5]) rotate([0, 0, 14]) square([15, 30]);
                }

                // サポート
                {
                    color("aqua") translate([4.5 - 1.2, 11.6]) square([0.2, 5.1]);
                    color("aqua") translate([4.5 - 0.4, 11.6]) square([0.2, 5.1]);
                }
            }

            // 板部分
            difference()
            {
                cylinder(h = 21, r = 38);
                color("red") translate([0, 0, 24]) rotate([0, 4, 0]) cube([100, 100, 21], center = true);
                color("red") translate([0, 0, 1]) rotate([0, 4, 0]) cube([100, 100, 21], center = true);
                translate([31, 0, 0]) cylinder(h = 21, r = 1);
            }
        }

        // 飲み口部分
        translate([-39.3, 0, -5])
        rotate([0, 22, 0])
        linear_extrude(height = 30) fillet(r = 3, r2 = 1)
        intersection()
        {
            square([10, 28], center = true);
            translate([33, 0]) circle(r = 35);
        }
    }

    cutPlate();
}


module cutPlate(plateColor = "blue") {
    if (cutX > 0) color(plateColor) translate([cutX, -10, -10]) cube([100, 100, 100]);
    if (cutX < 0) color(plateColor) translate([50 - 100 + cutX, -10, -10]) cube([100, 100, 100]);
    if (cutY > 0) color(plateColor) translate([-10, cutY, -10]) cube([100, 100, 100]);
    if (cutY < 0) color(plateColor) translate([-10, 50 - 100 + cutY, -10]) cube([100, 100, 100]);
    if (cutZ > 0) color(plateColor) translate([-10, -10, cutZ]) cube([100, 100, 100]);
    if (cutZ < 0) color(plateColor) translate([-10, -10, (MainAssemblyHeight + FloorAssemblyHeight) - 100 + cutZ]) cube([100, 100, 100]);
}
