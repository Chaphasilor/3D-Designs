include <./config.scad>

module lower_casing() {

  lower_casing_bottom();


  difference() {
    union() {
      lower_casing_sides();
      translate([0, casingWidth, casingWallHeight])
        rotate([180, 0, 0])
          lower_casing_sides();
    }

    translate([0, 0, casingThickness + connectorHeight])
    rotate([0, -lidAngle, 0])
    translate([-5, 0, 0])
      cube([lidLength + 10, casingWidth, (casingWallHeight - (casingThickness + connectorHeight))]);
  }
  
}

module lower_casing_bottom() {

  linear_extrude(height = casingThickness, center = false, convexity = 1, slices = 20, scale = 1.0, $fn = 16) {

    polygon(points = polyRound(casingRadii, 5));
    
  }
  
}

module lower_casing_sides() {

  // linear_extrude(height = casingWallHeight, center = false, convexity = 1, slices = 20, scale = 1.0, $fn = 16) {

  //   polygon(points = polyRound(casingWallRadii, 5));
    
  // }

  linear_extrude(height = casingWallHeight, center = false, convexity = 1, slices = 20, scale = 1.0, $fn = 16) {

    polygon(points = polyRound(beamChain(casingWallRadii, offset1=-casingThickness, offset2=0), 5));
    
  }
  
}