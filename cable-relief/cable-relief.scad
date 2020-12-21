include <./connector.scad>;
include <./relief.scad>;
include <./casing.scad>;
include <./lid.scad>;

module bottom() {

  difference() {

    union() {

      lower_relief();
      translate([casingDepth, 0, 0])
        lower_casing();
        
    }

    translate([casingDepth, 0, casingWallHeight - squeezeMargin])
      rotate([0, -lidAngle, 0])
        hole_puncher();
    
  }
  
}

module top() {

  difference() {
  
    lid();

    translate([0, 0, lidThickness])
      #hole_puncher();
        
  }

}

color("yellow")
  bottom();

translate([casingDepth, 0, 25])
  color("green")
    top();



// connector();

// translate([0, casingWidth/2, 0])
//   cube([100, .1, 20]);