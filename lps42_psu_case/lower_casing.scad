include <config.scad>
$fn=30;

module lower_casing() {

  cube([caseLength, caseWidth, wallThickness]);

  // screw standoffs
  for (pos = screwStandoffPositions) {
    translate(pos)
      screw_standoff();
  }

  translate([0, 0, wallThickness])
  walls(clearanceTop);
  
}

module screw_standoff() {

  difference() {

    cylinder(d=screwStandoffOuterDiameter, h=clearanceBottom, center=false);
    
    cylinder(d=holeDiameter, h=clearanceBottom, center = false);
    
  }
  
}

module walls(height) {

  cube([caseLength, wallThickness, height]);
  translate([0, (caseWidth - wallThickness), 0])
    cube([caseLength, wallThickness, height]);
  cube([wallThickness, caseWidth, height]);
  translate([(caseLength - wallThickness), 0, 0])
    cube([wallThickness, caseWidth, height]);
  
}