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

    #translate([0, 0, casingWallHeight + squeezeMargin])
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

print = true;
top = true;

if (print) {

  if (top) {

    translate([0, 0, lidThickness])
      rotate([180, 0, 0])
        top();
    
  } else {

    bottom();
    
  }
  
      
} else {

  translate([0, 0, 19])
    color("green")
      top();
  
  color("yellow")
    bottom();
      
}


// connector();

// translate([0, casingWidth/2, 0])
//   cube([100, .1, 20]);