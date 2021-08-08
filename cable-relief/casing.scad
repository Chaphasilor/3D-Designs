include <./config.scad>
include <./lid.scad>

module lower_casing() {

  lower_casing_bottom();

  difference() {
    union() {

      translate([0, 0, casingBottomThickness])
        lower_casing_side();
      translate([0, casingWidth, casingWallHeight + max(casingRailWallThickness, casingBottomThickness)])
        rotate([180, 0, 0])
          lower_casing_side();

      translate([0, 0, casingBottomThickness]) {
        front_screw_anchor("right");
        front_screw_anchor("left");
      }

      translate([0, 0, casingBottomThickness])
        cable_channel();

      translate([strippedCableLength - teethOffsetBottom, casingClampOffset + casingWallThickness, casingBottomThickness])
        rotate([180, 0, 0])
          teeth();

      translate([strippedCableLength, casingClampOffset - lidScrewHolePadding*1.5, 0])
        rotate([0, 0, 180])
          lid_screw_ear();

      translate([strippedCableLength - lidScrewEarWidth, casingWidth - casingClampOffset + lidScrewHolePadding*1.5, 0])
        // rotate([0, 0, 180])
          lid_screw_ear();

    }

    // sloped top side
    translate([0, 0, max(casingRailWallThickness, casingBottomThickness) + connectorHeight])
      rotate([0, -lidAngle, 0])
        translate([-5, 0, 0])
          cube([lidLength + 10, casingWidth, (casingWallHeight - connectorHeight + squeezeMargin*5)]);

    // screw lip
    translate([0, 2*casingRailWallThickness + holePaddingSide, abs(casingBottomThickness - casingRailWallThickness) + (holeDiameter+screwLipWidth)/2 + holePaddingBottom])
      rotate([0, 90, 0])
        cylinder(d=holeDiameter+screwLipWidth, h=strippedCableLength, center=false, $fn=20);
    // screw lip
    translate([0, casingWidth - (2*casingRailWallThickness + holePaddingSide), abs(casingBottomThickness - casingRailWallThickness) + (holeDiameter+screwLipWidth)/2 + holePaddingBottom])
      rotate([0, 90, 0])
        cylinder(d=holeDiameter+screwLipWidth, h=strippedCableLength, center=false, $fn=20);

  }
  
}

module lower_casing_bottom() {

  linear_extrude(height = casingBottomThickness, center = false, convexity = 1, slices = 20, scale = 1.0, $fn = 16) {

    polygon(points = polyRound(casingRadii, 5));
    
  }
  
}

module lower_casing_side() {

  linear_extrude(height = casingWallHeight, center = false, convexity = 1, slices = 20, scale = 1.0, $fn = 16) {
    polygon(points = polyRound(beamChain(casingWallRadii, offset1=-casingWallThickness, offset2=0), 5));
  }
  
}

module cable_channel() {

  difference() {

    // compensate for the shell2d offset
    translate([0, 0, 0])
      linear_extrude(height=cableDiameter, center=false, convexity=1, slices=20, scale=1.0, $fn = 10) {

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

    // cable
    translate([strippedCableLength - cableLength, casingClampOffset + cableDiameter/2 + casingWallThickness, cableDiameter/2])
      union() {
        rotate([0, 90, 0])
          cylinder(d=cableDiameter, h=cableLength, center=false);
        translate([0, -cableDiameter/2, 0])
          cube([cableLength, cableDiameter, cableDiameter/2]);
      }
    
  }

  
}

module front_screw_anchor(position) {

  translate([0, 0, 0])
    linear_extrude(height=cableDiameter, center=false, convexity=1, slices=20, scale=1.0, $fn = 30) {

      difference() {

        shell2d(casingBottomThickness) {

          polygon(polyRound(casingRadii, 5));

          if (position == "right") {
            translate([strippedCableLength*0.2, casingClampOffset*0.35 + casingWallThickness, 0])
              circle(r=frontScrewAnchorRadius);
          } else {
            translate([strippedCableLength*0.2, casingWidth - (casingClampOffset*0.35 + casingWallThickness), 0])
              circle(r=frontScrewAnchorRadius);
          }
          
        }
        
        // get rid of the shell
        shell2d(casingBottomThickness) {
          polygon(polyRound(casingRadii, 5));
        }

      }

    }

}

module lid_screw_ear() {

  difference() {

    // cube([lidScrewEarWidth, lidScrewEarWidth + lidScrewHoleOffset, casingWallHeight]);

    rotate([90, 0, 90]) 
    difference() {
      
      linear_extrude(height = lidScrewEarWidth, center = false, convexity = 1, slices = 20, scale = 1.0, $fn = 16) {
        polygon(points = polyRound(lidScrewEarRadii, 5));
      }

      //TODO not working, throws error on render?!
      // translate([0, 0, lidScrewHoleDiameter*1.5/4])
      // #linear_extrude(height = lidScrewHoleDiameter*1.5, center = false, convexity = 1, slices = 20, scale = 1.0, $fn = 16) {
      //   polygon(points = polyRound(beamChain(lidScrewEarInnerRadii, offset1=-1, offset2=5), 5));
      // }

    }


    // rotate([-lidScrewEarAngle, 0, 0])
    //   cube([lidScrewEarWidth, lidScrewEarWidth, sqrt(pow(lidScrewEarWidth, 2) + pow(casingWallHeight, 2))]);

    

    translate([lidScrewEarWidth/2, lidScrewEarWidth/2 + lidScrewHoleOffset, casingWallHeight - lidScrewHoleDepth - lidScrewEarThickness + lidScrewEarNutInset])
      // $fn=6 for hexagonal nuts
      cylinder(d=lidScrewHoleNutDiameter, h=lidScrewHoleDepth, center=false, $fn=6);
    
  }
  
}