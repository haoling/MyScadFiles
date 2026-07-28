include <constants.scad>;
use <../common.scad>;
use <modules.scad>;
use <plate 130mm x 108mm.scad>;

difference()
{
  union()
  {
    plate130x108(
      connector_left = false, rail_right = true, rail_left = true, connector_female_right = false, connector_female_left = false, snap_clip = false,
    );

    color([0.6, 0.4, 0.4])
    translate([(130 - w - ((130 - w - 93) / 2)) / 2, (93 / 2) + 12, 0])
    difference()
    {
      linear_extrude(height = 15) square([93, 93], center = true);

      color("aqua")
      translate([0, 0 - ((93 - 5) / 2), 5])
      linear_extrude(height = 10)
      square([10, 10], center = true);

      color("aqua")
      translate([0, (93 - 5) / 2, 5])
      linear_extrude(height = 10)
      square([10, 10], center = true);
    }
  }

  color("red")
  translate([(130 - w - ((130 - w - 93) / 2)) / 2, (93 / 2) + 12, 0])
  linear_extrude(height = 14)
  square([91, 91], center = true);

}

color("aqua") translate([12, 15, 0]) supportPiller(space = 2, length = 87, height = 13.8, repeats = 44, width = 0.2);