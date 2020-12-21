include <./config.scad>

module lid() {

  linear_extrude(height = lidThickness, center = false, convexity = 1, slices = 20, scale = 1.0, $fn = 16) {

    polygon(points = polyRound(casingRadii, 5));
    
  }

  translate([strippedCableLength - lidScrewEarWidth, casingWidth - casingClampOffset, 0])
    cube([lidScrewEarWidth, lidScrewEarWidth + lidScrewHoleOffset, lidThickness]);

  translate([strippedCableLength, casingClampOffset, 0])
    rotate([0, 0, 180])
      cube([lidScrewEarWidth, lidScrewEarWidth + lidScrewHoleOffset, lidThickness]);
    
}

module hole_puncher() {


  translate([strippedCableLength - lidScrewEarWidth/2, casingWidth - casingClampOffset + lidScrewEarWidth/2 + lidScrewHoleOffset, -lidScrewHoleDepth])
    cylinder(d=lidScrewHoleDiameter, h=lidScrewHoleDepth+2.5, center=false, $fn=20);
  
  translate([strippedCableLength - lidScrewEarWidth/2, casingClampOffset - lidScrewEarWidth/2 - lidScrewHoleOffset, -lidScrewHoleDepth])
    cylinder(d=lidScrewHoleDiameter, h=lidScrewHoleDepth+2.5, center=false, $fn=20);

  // screw holes
  translate([strippedCableLength - cableLength + lidScrewHoleDiameter/2 + lidScrewHolePadding, casingClampOffset + casingWallThickness + cableDiameter/2, -lidScrewHoleDepth]) {
    translate([0, cableDiameter/2 + lidScrewHoleDiameter/2 + lidScrewHolePadding, 0])
      cylinder(d=lidScrewHoleDiameter, h=lidScrewHoleDepth+2.5, center=false, $fn=20);
    translate([0, -cableDiameter/2 - lidScrewHoleDiameter/2 - lidScrewHolePadding, 0])
      cylinder(d=lidScrewHoleDiameter, h=lidScrewHoleDepth+2.5, center=false, $fn=20);
  }
      
  
}