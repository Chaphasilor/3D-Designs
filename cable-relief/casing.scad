include <./config.scad>

module lower_casing() {

  translate([casingDepth, 0, 0])
  linear_extrude(height = casingThickness, center = false, convexity = 1, slices = 20, scale = 1.0, $fn = 16) {

    polygon(points = polyRound(casingRadii, 5));
    
  }
  
}