include <./connector.scad>;
include <./relief.scad>;
include <./casing.scad>;

union() {

  lower_relief();
  translate([casingDepth, 0, 0])
    lower_casing();
    
}
// connector();