include <./config.scad>

module lower_casing() {

  lower_casing_bottom();

  difference() {
    union() {

      lower_casing_side();
      translate([0, casingWidth, casingWallHeight + max(casingRailWallThickness, casingBottomThickness) - squeezeMargin])
        rotate([180, 0, 0])
          lower_casing_side();

      translate([0, 0, casingBottomThickness])
      cable_channel();

    }

    // sloped top side
    translate([0, 0, max(casingRailWallThickness, casingBottomThickness) + connectorHeight])
      rotate([0, -lidAngle, 0])
        translate([-5, 0, 0])
          cube([lidLength + 10, casingWidth, (casingWallHeight - connectorHeight)]);

    // screw lip
    translate([0, 2*casingRailWallThickness + holePaddingSide, abs(casingBottomThickness - casingRailWallThickness) + (holeDiameter+screwLipWidth)/2 + holePaddingBottom])
      rotate([0, 90, 0])
        cylinder(d=holeDiameter+screwLipWidth, h=strippedCableLength, center=false, $fn=20);
    // screw lip
    translate([0, casingWidth - (2*casingRailWallThickness + holePaddingSide), abs(casingBottomThickness - casingRailWallThickness) + (holeDiameter+screwLipWidth)/2 + holePaddingBottom])
      rotate([0, 90, 0])
        cylinder(d=holeDiameter+screwLipWidth, h=strippedCableLength, center=false, $fn=20);

    // cable
    #translate([strippedCableLength - cableLength, casingClampOffset + cableDiameter/2 + casingBottomThickness, cableDiameter/2 + casingBottomThickness])
      rotate([0, 90, 0])
        cylinder(d=cableDiameter, h=cableLength, center=false);
      
  }
  
}

module lower_casing_bottom() {

  linear_extrude(height = casingBottomThickness, center = false, convexity = 1, slices = 20, scale = 1.0, $fn = 16) {

    polygon(points = polyRound(casingRadii, 5));
    
  }
  
}

module lower_casing_side() {

  linear_extrude(height = casingWallHeight + max(casingRailWallThickness, casingBottomThickness) - squeezeMargin, center = false, convexity = 1, slices = 20, scale = 1.0, $fn = 16) {
    polygon(points = polyRound(beamChain(casingWallRadii, offset1=-casingWallThickness, offset2=0), 5));
  }
  
}

module cable_channel() {

  // compensate for the shell2d offset
  translate([0, 0, 0])
    linear_extrude(height=cableDiameter/2, center=false, convexity=1, slices=20, scale=1.0, $fn = 10) {

      difference() {

        shell2d(casingBottomThickness) {

          polygon(polyRound(casingRadii, 5));

          translate([strippedCableLength - cableLength, 0, 0])
            square([cableLength, casingWidth]);
          
        }
        
        // get rid of the shell
        shell2d(casingBottomThickness) {
          polygon(polyRound(casingRadii, 5));
        }

      }

    }
  
}