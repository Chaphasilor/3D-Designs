include <./connector.scad>;
include <./relief.scad>;
include <./casing.scad>;

union() {

  lower_relief();
  translate([casingDepth, 0, 0])
    lower_casing();
    
}
// connector();

// translate([0, casingWidth/2, 0])
//   cube([100, .1, 20]);