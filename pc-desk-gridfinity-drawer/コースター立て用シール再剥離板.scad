include <constants.scad>;
use <modules.scad>;
use <../common.scad>;
use <../libs/dotSCAD/src/arc.scad>;

coaster_size = 89.7;

base_t    = 0.6;   // ベースの厚さ [mm]
rib_h     = 0.4;   // リブの高さ [mm]
coaster_depth = base_t + rib_h; // コースターの総厚さ [mm]
rib_w     = 0.4;   // リブの幅 [mm]
rib_gap   = 1.6;   // リブの間隔（リブとリブの隙間） [mm]
frame_w   = 2.0;   // 枠の幅 [mm]

difference() {
    // 基礎面
    cube([coaster_size, coaster_size, coaster_depth]);

    // 中央をへこませる
    translate([frame_w, frame_w, base_t]) cube([coaster_size - 2 * frame_w, coaster_size - 2 * frame_w, coaster_depth]);
}

// 中央の凹んだ部分に、カットした球体を交互に並べる
spheare_radius = 2;
*for (c = [0 : 1 : coaster_size / spheare_radius], r = [0 : 1 : coaster_size / spheare_radius]) {
    x = (1.85 + spheare_radius) + (c * spheare_radius * 3) + (spheare_radius * 1.5 * (r % 2));
    y = (1.85 + spheare_radius) + (r * spheare_radius * 3);
    if (x < coaster_size - (1.85 + spheare_radius) && y < coaster_size - (1.85 + spheare_radius))
    translate([x, y, 0.5 - (spheare_radius * 0.5)])
    difference()
    {
        sphere(r = spheare_radius);
        translate([0, 0, 0 - (spheare_radius * 0.5)]) cube([spheare_radius * 2, spheare_radius * 2, spheare_radius * 2], center = true);
    }
}

color("orange") translate([frame_w - (rib_w / 2), frame_w - (rib_w / 2), base_t]) waffle(size = (size - (frame_w * 2)) + (rib_w));


// ============================================================
//  ウェッフルグリッド ステッカーボード
//  waffle_board.scad
// ============================================================

// === パラメータ（ここを変更してください） ===================

size      = 89.7;  // 正方形の一辺 [mm]

// ============================================================

// === 導出値（自動計算・変更不要） ===========================

frame_t   = base_t + rib_h;   // 枠の総厚さ
pitch     = rib_w + rib_gap;   // リブのピッチ（中心間距離）

// ============================================================

module waffle(
    rib_h = rib_h,
    size = size - (frame_w * 2) // 内側有効寸法（一辺）
) {
    // --- ③ ウェッフルグリッド（リブ） ---
    // X 方向リブ（Y 軸に沿って並ぶ縦線）
    for (i = [0 : pitch : size])
        translate([i, 0, 0])
            cube([rib_w, size, rib_h]);

    // Y 方向リブ（X 軸に沿って並ぶ横線）
    for (j = [0 : pitch : size])
        translate([0, j, 0])
            cube([size, rib_w, rib_h]);
}
