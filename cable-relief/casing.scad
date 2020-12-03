include <./config.scad>

module lower_casing() {

  lower_cassing_bottom();

  lower_cassing_sides();
  translate([0, casingWidth, casingWallHeight])
  rotate([180, 0, 0])
  lower_cassing_sides();
  
}

module lower_cassing_bottom() {

  linear_extrude(height = casingThickness, center = false, convexity = 1, slices = 20, scale = 1.0, $fn = 16) {

    polygon(points = polyRound(casingRadii, 5));
    
  }
  
}

module lower_cassing_sides() {

  // linear_extrude(height = casingWallHeight, center = false, convexity = 1, slices = 20, scale = 1.0, $fn = 16) {

  //   polygon(points = polyRound(casingWallRadii, 5));
    
  // }
  linear_extrude(height = casingWallHeight, center = false, convexity = 1, slices = 20, scale = 1.0, $fn = 16) {

    polygon(points = polyRound(beamChain(casingWallRadii, offset1=-casingThickness, offset2=0), 5));
    
  }
  
}