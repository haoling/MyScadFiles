include <constants.scad>;
use <modules.scad>;
use <plate 130mm x 108mm.scad>;
use <rail 130mm.scad>;

space = 2;
translate([0, 0, 0]) roof_connector(center_male = true);
translate([w + space, 0, 0]) roof_connector(center_male = true);
translate([(w + space) * 2, 0, 0]) roof_connector(center_male = false);
translate([(w + space) * 3, 25, 0]) ceiling_connector();
