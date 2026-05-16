include <../36mm-bin-generator.scad>

difference()
{
    union()
    {
        difference()
        {
            bin_generator(
                gridx = 3,
                gridy = 3,
                gridz = 4,
                scoop = 0,
                include_lip = false,
                divx = 3,
                divy = 1
            );
            translate([0 - (36 * 0.5) + 7, 0 - (36 * 1.5), 0]) cube([36 * 3, 36 * 3, 7 * 4]);
        }
        difference()
        {
            bin_generator(
                gridx = 3,
                gridy = 3,
                gridz = 4,
                scoop = 0,
                include_lip = false,
                divx = 1,
                divy = 3
            );
            translate([0 - (36 * 1.5), 0 - (36 * 0.5) + 7, 0]) cube([36 * 3, 36 * 3, 7 * 4]);
        }
        intersection()
        {
            bin_generator(
                gridx = 3,
                gridy = 3,
                gridz = 4,
                scoop = 0,
                include_lip = false,
                divx = 3,
                divy = 3
            );
            translate([0 - (36 * 0.5), 0 - (36 * 0.5), 0]) cylinder(h = 7 * 4, r = 7);
        }
        intersection()
        {
            bin_generator(
                gridx = 3,
                gridy = 3,
                gridz = 4,
                scoop = 0,
                include_lip = false,
                divx = 0,
                divy = 0
            );
            translate([0 - (36 * 0.5) + 0.5, 0 - (36 * 0.5) + 0.5, 0]) cube([36 * 3, 36 * 3, 7 * 4]);
        }
    }
    translate([(36 * 0.5) - 5, (36 * 0.5) - 5, 7]) cylinder(h = 21, r1 = 74 / 2, r2 = 75 / 2);
}

// 綿棒ケース建築限界
*translate([(36 * 0.5) - 5, (36 * 0.5) - 5, 7]) cylinder(h = 83, r = 80 / 2);
