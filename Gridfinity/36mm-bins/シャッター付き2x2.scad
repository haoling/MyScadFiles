include <../36mm-bin-generator.scad>
include <../../common.scad>;
include <../parametric+roll-top+box+1.6.scad>
use <../../pc-desk-gridfinity-drawer/modules.scad>
include <../../pc-desk-gridfinity-drawer/constants.scad>;
use <../../libs/dotSCAD/src/polyhedron_hull.scad>;

cube_width = 71.6 + 0;
cube_depth = 71 + 0;
cube_height = 52.66 + 0;
door_thickness = 0.8 + 0; //[0:0.1:10]
show_logo_door = ! true;
wall_thickness = 1.36 + 0;
rail_thickness=0.8 + 0; //[0:0.1:10]
rail_radius=30 + 0; //[30:1:90]
rail_gap=2.3 + 0; //[0:0.1:10]
rail_height = 2 + 0; //[0:0.1:10]

stair = 2.2 + 0;

// MainAssemblyの高さ
MainAssemblyHeight = 51.2 + 0;
FloorAssemblyHeight = 7 + 0;

preview = true;
cutPanel = false;
showMainAssembly = false;
showLeftAssembly = true;
showRightAssembly = true;
showFloorAssembly = true;

cutX = 0; // [-72:0.1:72]
cutY = 0; // [-72:0.1:72]
cutZ = 0; // [-51.2:0.1:51.2]

difference()
{
    union()
    {
        if(showMainAssembly) MainAssembly();
        if(showLeftAssembly) LeftAssembly();
        if(showRightAssembly) RightAssembly();
        if(showFloorAssembly) FloorAssembly();
    }

    if (cutX > 0) color("blue") translate([cutX, -10, -10]) cube([100, 100, 100]);
    if (cutX < 0) color("blue") translate([72 - 100 + cutX, -10, -10]) cube([100, 100, 100]);
    if (cutY > 0) color("blue") translate([-10, cutY, -10]) cube([100, 100, 100]);
    if (cutY < 0) color("blue") translate([-10, 72 - 100 + cutY, -10]) cube([100, 100, 100]);
    if (cutZ > 0) color("blue") translate([-10, -10, cutZ]) cube([100, 100, 100]);
    if (cutZ < 0) color("blue") translate([-10, -10, (MainAssemblyHeight + FloorAssemblyHeight) - 100 + cutZ]) cube([100, 100, 100]);
}

// translate([2, 70.5, 54.1]) mirror([0, 1, 0])
*DoorAssembly();

module MainAssembly() {
    translate([0, 0, -7])
    {
        difference()
        {
            translate([36, 36, stair])
            bin_generator(gridx = 2, gridy = 2, gridz = 8, include_lip = false, style_tab = 5, scoop = 0);

            cube([150, 150, 7]);
        }
        if (cutPanel) color("aqua", 0.2) translate([-10, -10, 7]) cube([90, 90, 0.01]);
    }
}

module LeftAssembly() {
    pillerHeight = 65.8;

    translate(preview ? (showFloorAssembly ? [0, 0, 7] : [0, 0, 0]) : [51.2, -0.01, -0.01]) rotate(preview ? [0, 0, 0] : [0, -90, 0])
    {
        // MainAssemblyを反対側の壁の手前で割る
        difference()
        {
            translate([-0.25, -0.25, 0]) // 原点合わせ
            MainAssembly();
            translate([67, -10, -10]) cube([100, 100, 100]);
        }
        if (cutPanel) color("aqua", 0.2) translate([67, -10, -10]) cube([0.01, 90, 70]);

        // シャッターレール
        translate([0, 0, -2.3 + stair]) RailAssemblyRight();

        // シャッターレール内側の壁
        difference()
        {
            intersection() for (x = [2:1:34])
            translate([wall_thickness + (rail_height * x), 0, -2.3 + stair])
            // 薄いバージョン
            translate([-1, 0 - (rail_thickness / 2), 0 - (rail_thickness / 2)]) rotate([0,-90,0]) RailInner(rail_thickness = rail_thickness / 2);
            // 薄くないバージョン
            // rotate([-1,-90,0]) RailInner();

            color("red") translate([0, 0, 47.3]) cube([72, 40, rail_thickness * 3]);
            color("red") translate([52, 40, 0]) cube([20, 40, 2.22]);
        }

        // ホコリ防止のフタ
        translate([1.2, 47.5, 48.2 + stair])
        cube([69, 23, rail_thickness]);

        // 手前側のコネクタ
        translate([1, 1.2, MainAssemblyHeight - pD - 10]) // 移動
        translate([0, w / 2, 0]) // 原点合わせ
        rotate([0, 0, -90]) linear_extrude(height = pD) connector_female_2d(height = pillerHeight);
        difference()
        {
            polyhedron_hull(points = [
                [1.2, 1.2, MainAssemblyHeight - rail_thickness - rail_gap],
                [ 68.04, 1.2, MainAssemblyHeight - rail_thickness - rail_gap],
                [ 68.04, 1.2, MainAssemblyHeight - 10],
                [ 68.04, 1.2 + w, MainAssemblyHeight - 10],
                [1.2, 1.2 + w, MainAssemblyHeight - 10],
                [1.2, 1.2, MainAssemblyHeight - 10],
            ]);
            // Right側のコネクタ部のすきま
            color("red") translate([60, 1.2, MainAssemblyHeight - 10]) cube([10, w, 0.4]);
        }
        translate([1.2, 1.2, MainAssemblyHeight - 10])
        cube([rail_height, w, 10 - rail_thickness - rail_gap]);

        // ホコリ防止のフタのところのコネクタ
        translate([1, 58, MainAssemblyHeight - rail_thickness - w]) // 移動
        translate([0, 0, w / 2]) // 原点合わせ
        rotate([0, -90, -90]) linear_extrude(height = pD) connector_female_2d(height = pillerHeight);

        // 床側のコネクタ
        translate([1, 36 - (pD / 2), 2]) // 移動
        translate([0, 0, w / 2]) // 原点合わせ
        rotate([0, -90, -90]) linear_extrude(height = pD) connector_female_2d(height = pillerHeight);

        // 床との接続
        for (x = [18, 51]) for (y = [24, 48]) translate([x, y, 1.2])
        translate([pD / 2, 0, 0]) // 原点合わせ
        rotate([-90, 0, 90]) linear_extrude(height = pD) connector_female_2d(height = 6);
        if (! preview) {
            difference()
            {
                for (x = [18, 51]) for (y = [24, 48]) translate([x, y, 0])
                translate([-27.6, -2.5, -0.8]) rotate([0, 90, 0]) supportPiller(space = 2, length = 5, height = 22.4, repeats = 3, width = 0.2);

                translate([-20, 0, -20]) cube([20, 72, 20]);
            }
        }
    }
}

module RightAssembly() {
    translate(preview ? (showFloorAssembly ? [0, 0, 7] : [0, 0, 0]) : [0, 0, 71.5]) rotate(preview ? [0, 0, 0] : [0, 90, 0])
    {
        difference()
        {
            translate([-0.25, -0.25, 0]) // 原点合わせ
            MainAssembly();
            translate([-10, -10, 0]) cube([10 + 67, 100, 100]);
        }
        if (cutPanel) color("aqua", 0.2) translate([67, -10, -10]) cube([0.01, 90, 70]);

        // シャッターレール
        translate([0, 0, -2.3 + stair]) RailAssemblyLeft();

        // 手前側のコネクタ
        translate([64, 1.2, MainAssemblyHeight - pD - 10]) // 移動
        difference()
        {
            cube([6.4, w, pD]);
            translate([5, 0, pD / 2]) rotate([-90, 0, 90]) pillar_male();
        }
        translate([72 - 0.5 - rail_height - 1.26, 1.2, MainAssemblyHeight - 10])
        cube([rail_height, w, 10 - rail_thickness - rail_gap]);

        // ホコリ防止のフタのところのコネクタ
        translate([64, 58, MainAssemblyHeight - rail_thickness - w]) // 移動
        translate([0, 0, w]) rotate([-90, 0, 0]) // 回転と原点合わせ
        difference()
        {
            cube([6.4, w, pD]);
            translate([5, 0, pD / 2]) rotate([-90, 0, 90]) pillar_male();
        }

        // 床側のコネクタ
        translate([64, 36 - (pD / 2), 2]) // 移動
        translate([0, 0, w]) rotate([-90, 0, 0]) // 回転と原点合わせ
        difference()
        {
            cube([6.4, w, pD]);
            translate([5, 0, pD / 2]) rotate([-90, 0, 90]) pillar_male();
        }
    }
}

module FloorAssembly() {
    difference()
    {
        translate([36 - 0.26, 36 - 0.25, 0])
        bin_generator(
            gridx = 2,
            gridy = 2,
            gridz = 1,
            scoop = 0,
            include_lip = false,
            divx = 0,
            divy = 0
        );

        // LeftAssemblyとの接続
        for (x = [18, 51]) for (y = [24, 48]) translate([x, y, 0])
        translate([0, 0 - ((w + 1) / 2), 0]) // 原点合わせ
        rotate([0, 0, 90]) pillar_male(w = w + 1);
    }
}

*translate([0, 71, 36]) rulerX(step = 0.1, line_width = 0.05);
*translate([20, 0.3, 55.2]) rulerY();
*translate([68, 0, 0]) rulerZ(step = 0.1, line_width = 0.05);