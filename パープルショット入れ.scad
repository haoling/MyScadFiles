use <common.scad>

// 箱内径 70mm x 62mm
// パープルショット外傾 37mm 底面からクビまでの高さ 73mm

$fa = 0.1;
$fs = 0.1;

H = 83;
WS = 0.4; // WhiteSpace
d = 0.6; // 厚み
X = 70 - WS;
Y = 62 - WS;
r = 18.75;


// 0.6mm厚の床
translate ([X / 2, Y / 2, 0])
difference()
{
    cube([X, Y, d], center = true);
    // cube([X - 3, Y - 3, d], center = true);
}

// 内径37.6mm、厚さ0.6mmの円筒
translate([X - r, r, 0])
difference()
{
    cylinder(h = H, r = r);
    cylinder(h = H, r = r - d);

    color("red")
    translate([-r - 3, 0 - r, H - 13])
    cube([20, r - 4, 20]);
}

// 仕切り板
translate([0, (r * 2) - d, 0])
cube([X, d, H]);

// SYNCO G2 MEGAを引っ掛けるところ
translate([X - (r * 2) - 6, r - (23 / 2), 58 - 24])
{
    Xs = 15; // 引っ掛けの奥行き
    Ys = 19 + 4; // 幅
    Zs = 24; // 深さ
    Zh = 7;  // 穴の深さ

    difference()
    {
        linear_extrude(height = Zs) fillet() square([Xs, Ys]);
        translate([r + 6, (Ys / 2), 0]) cylinder(h = H, r = r);
        translate([2, 2, Zs - Zh]) cube([Xs, Ys - 4, Zs]);
        color("red") translate([-10, 0, -25]) rotate([0, -30, 0])
        cube([Xs * 2, Ys, 50]);
    }
}