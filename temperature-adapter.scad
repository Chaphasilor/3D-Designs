include <Round-Anything/MinkowskiRound.scad>;

$fn = 30;

length = 20;
diameterOutside = 6.1;
diameterInside = 1.8;

module temperature_adapter() {
  
  // minkowskiRound(0.7, 1.5, true, [length, length, length]) {
    difference() {
      
      cylinder(d=diameterOutside, h=length, center=false);

      cylinder(d=diameterInside, h=length, center=false);

    }
  // }
  
}

temperature_adapter();