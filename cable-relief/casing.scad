include <./config.scad>

module lower_casing() {

  lower_casing_bottom();


  difference() {
    union() {

      lower_casing_side();
      translate([0, casingWidth, casingWallHeight + casingThickness - squeezeMargin])
        rotate([180, 0, 0])
          lower_casing_side();

      translate([0, 0, casingThickness])
      cable_channel();

    }

    // sloped top side
    translate([0, 0, casingThickness + connectorHeight])
      rotate([0, -lidAngle, 0])
        translate([-5, 0, 0])
          cube([lidLength + 10, casingWidth, (casingWallHeight - connectorHeight)]);

    // screw lip
    translate([0, 2*casingRailWallThickness + holePaddingSide, 2*casingRailWallThickness + holePaddingBottom])
      rotate([0, 90, 0])
        cylinder(d=holeDiameter+screwLipWidth, h=2, center=false, $fn=20);
    // screw lip
    translate([0, casingWidth - (2*casingRailWallThickness + holePaddingSide), 2*casingRailWallThickness + holePaddingBottom])
      rotate([0, 90, 0])
        cylinder(d=holeDiameter+screwLipWidth, h=2, center=false, $fn=20);

    // cable
    translate([strippedCableLength - cableLength, casingClampOffset + cableDiameter/2 + casingThickness, cableDiameter/2 + casingRailWallThickness])
      rotate([0, 90, 0])
        cylinder(d=cableDiameter, h=cableLength, center=false);
      
  }
  
}

module lower_casing_bottom() {

  linear_extrude(height = casingThickness, center = false, convexity = 1, slices = 20, scale = 1.0, $fn = 16) {

    polygon(points = polyRound(casingRadii, 5));
    
  }
  
}

module lower_casing_side() {

  linear_extrude(height = casingWallHeight + casingThickness - squeezeMargin, center = false, convexity = 1, slices = 20, scale = 1.0, $fn = 16) {
    polygon(points = polyRound(beamChain(casingWallRadii, offset1=-casingThickness, offset2=0), 5));
  }
  
}

module cable_channel() {

  // compensate for the shell2d offset
  translate([0, 0, 0])
    linear_extrude(height=cableDiameter/2, center=false, convexity=1, slices=20, scale=1.0, $fn = 10) {

      difference() {

        shell2d(casingThickness) {

          polygon(polyRound(casingRadii, 5));

          translate([strippedCableLength - cableLength, 0, 0])
            square([cableLength, casingWidth]);
          
        }
        
        // get rid of the shell
        shell2d(casingThickness) {
          polygon(polyRound(casingRadii, 5));
        }

      }

    }
  
}