use <libs/dotSCAD/src/polyline2d.scad>;

module fillet(r = 0.3, r2 = 0.3) {
  // フィレットモジュール
  // 使用例: fillet(r=0.5) { ... }
  // 注意: フィレットはオフセットの前に適用されるため、オフセットと組み合わせて使用することが一般的です。
  offset(r=r) offset(r=-r2) children();
}

module supportPiller(
    space = 2,
    length = 5,
    height = 6.8,
    repeats = 5,
    width = 0.2,
)
{
    points = [
            for (i = [0 : (repeats * 2) - 1])
            i % 4 == 0 ? [space * floor(i / 2), 0]
            : i % 4 == 1 ? [space * floor(i / 2), length]
            : i % 4 == 2 ? [space * floor(i / 2), length]
            : [space * floor(i / 2), 0]
        ];
    *echo(points);
    linear_extrude(height = height) 
    polyline2d(
        points = points,
        width = width
    );
}

module rulerX(line_width = 0.2, width = 2, height = 0.2, length = 100, step = 1) {
    color("red")
    ruler(line_width = line_width, width = width, height = height, length = length, step = step);
}
module rulerY(line_width = 0.2, width = 2, height = 0.2, length = 100, step = 1) {
    color("green")
    rotate([0, 0, 90])
    ruler(line_width = line_width, width = width, height = height, length = length, step = step);
}
module rulerZ(line_width = 0.2, width = 2, height = 0.2, length = 100, step = 1) {
    color("blue")
    rotate([0, 270, 90])
    ruler(line_width = line_width, width = width, height = height, length = length, step = step);
}
module ruler(line_width = 0.2, width = 2, height = 0.2, length = 100, step = 1) {
    for (i = [0 : step : length]) {
        translate([i - line_width / 2, 0, 0])
        linear_extrude(height = height)
        square([line_width, width / (i * 10 % 10 != 0 ? 4 : 2)]);
    }
    for (i = [0 : 10 : length]) {
        translate([i - line_width / 2, 0, 0])
        linear_extrude(height = height)
        square([line_width, width]);
        linear_extrude(height = height)
        translate([i, -0.2, 0])
        text(str(i), size = 1, halign = "center", valign = "top");
    }
}