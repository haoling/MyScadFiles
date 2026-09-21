use <common.scad>

translate([71, 0, 17.5])
rotate([90, 0, 180])
import("switch+2+joycon+grip.stl");

union() {
    // joy-conスロット左
    translate([55.6, 9, 3.4])
    color("aqua")
    rotate([0, 0, 90])
    supportPiller(height = 8.4, repeats = 49);

    // joy-conスロット右
    translate([96.5, 9, 3.4])
    color("aqua")
    rotate([0, 0, 90])
    supportPiller(height = 8.4, repeats = 49);

    color("aqua")
    difference() {
        intersection() {
            union() {
                // 左側
                translate([49, 4, 0])
                color("aqua")
                rotate([0, 0, 90])
                supportPiller(length = 49, repeats = 43, height = 15);
                translate([0, 4, 0])
                supportPiller(space = 10, length = 84, repeats = 5, height = 15);

                // 右側
                translate([146.6, 4, 0])
                color("aqua")
                rotate([0, 0, 90])
                supportPiller(length = 49, repeats = 43, height = 15);
                translate([106.6, 4, 0])
                supportPiller(space = 10, length = 84, repeats = 5, height = 15);
            }

            linear_extrude(height = 100)
            projection() {
                translate([71, 0, 17.5])
                rotate([90, 0, 180])
                import("switch+2+joycon+grip.stl");
            }
        }

        for (x = [-0.4:0.2:0.4])
        for (y = [-0.4:0.2:0.4])
        for (z = [-0.4:0.2:0])
        translate([x, y, z])
        translate([71, 0, 17.5])
        rotate([90, 0, 180])
        import("switch+2+joycon+grip.stl");
    }
}

// color("aqua") rulerX();
// color("aqua") rulerY();
// translate([70, 20, 0])
// color("aqua") rulerZ();