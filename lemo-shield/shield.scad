include <config.scad>;

module shield() {

  translate([0, -shieldLength, 0])
    cube([shieldThickness, shieldLength, shieldHeight]);

}