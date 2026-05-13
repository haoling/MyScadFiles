include <../36mm-bin-generator.scad>

space = 38;
translate([space * 0, 0, 0]) bin_generator(gridx = 1, gridy = 4, gridz = 3);
translate([space * 1, 0, 0]) bin_generator(gridx = 1, gridy = 4, gridz = 3);
*translate([space * 2, 0, 0]) bin_generator(gridx = 1, gridy = 4, gridz = 3);
*translate([space * 3, 0, 0]) bin_generator(gridx = 1, gridy = 4, gridz = 3);