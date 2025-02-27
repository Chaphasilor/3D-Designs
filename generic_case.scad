// -------------- Measurements -----------------
groundClearance = 3;
boardThickness = 1.7;
maxHeight = 17.4;
boardDepth = 100;
boardWidth = 200;
// mountingHoleDistanceLeftRight = mountingHoleDiameter/2 + 3.2;
// mountingHoleDistanceTopBottom = mountingHoleDistanceLeftRight;

// ------------------ Case --------------------- 

caseDistanceBoard = 2;
caseDistanceConnectors = 3;
caseThickness = 2;
caseWidth = 100;
caseDepth = 60;

rimThickness = 2;
rimCornerLength = 7;
rimOffset = 3;

caseSpacersHeight = groundClearance * 1.5;
caseSpacersThickness = 1.5;
caseBottomHeight = caseThickness + rimOffset + 60;
caseTopHeight = caseBottomHeight;

rimHeight = caseTopHeight - caseThickness + rimOffset;

countersunkBoltHoleDistance = rimCornerLength/2;
countersunkBoltHoleDiameterMin = 2.7;
countersunkBoltHoleDiameterMax = 5.4;
countersunkBoltHoleHeight = 1.6;

// ------------- Print Settings ----------------

print = false;
bottom = true; 
$fn = 40;

// ---------------- Modules --------------------

module holePuncher(diameter, height) {
  cylinder(d=diameter, h=height, center=false, $fn=20);
}

// Case - Bottom

module caseBottom() {

  translate([caseThickness, caseThickness, 0]) {

    // bottom pane 
    cube([caseWidth - 2 * caseThickness, caseDepth - 2 * caseThickness, caseThickness]);

  }

  // sides
  color("yellow") {

    // front
    cube([caseWidth, caseThickness, caseBottomHeight], center=false);
    //back
    translate([0, caseDepth - caseThickness, 0])
      cube([caseWidth, caseThickness, caseBottomHeight], center=false);
    // left  
    cube([caseThickness, caseDepth, caseBottomHeight], center=false);
    // right
    translate([caseWidth - caseThickness, 0, 0])
      cube([caseThickness, caseDepth, caseBottomHeight], center=false);
        
  }

  // corners

  color("red") {

    translate([0, 0, caseThickness]) {
      
      translate([caseThickness, caseThickness, 0])
        corner();
      translate([caseThickness, caseDepth - caseThickness, 0])
        rotate([0, 0, 270])
          corner();
      translate([caseWidth - caseThickness, caseDepth - caseThickness, 0])
        rotate([0, 0, 180])
          corner();
      translate([caseWidth - caseThickness, caseThickness, 0])
        rotate([0, 0, 90])
          corner();
      
    }
    
  }
  
}

module spacer(innerDiameter, thickness, height) {

  difference() {
    cylinder(r=(innerDiameter/2 + thickness), h=height, center = false);
    cylinder(d=innerDiameter, h=height, center = false);
  }
  
}

module countersunkBoltHole() {

  translate([-countersunkBoltHoleDiameterMin/2, -countersunkBoltHoleDiameterMin/2, 0])
  union() {
    cylinder(d1=countersunkBoltHoleDiameterMax, d2=countersunkBoltHoleDiameterMin, h=countersunkBoltHoleHeight, center = false);
    cylinder(d=countersunkBoltHoleDiameterMin, h=caseThickness, center = false);

  }
}

module caseLid() {

  difference() {

    translate([caseThickness, caseThickness, 0])
      cube([caseWidth - 2*caseThickness, caseDepth - 2*caseThickness, caseThickness]);
    
    #translate([2*caseThickness + countersunkBoltHoleDistance, 2*caseThickness + countersunkBoltHoleDistance, 0])
      countersunkBoltHole();
    #translate([2*caseThickness + countersunkBoltHoleDistance, caseDepth - (caseThickness + countersunkBoltHoleDistance), 0])
      countersunkBoltHole();
    #translate([caseWidth - (caseThickness + countersunkBoltHoleDistance), caseDepth - (caseThickness + countersunkBoltHoleDistance), 0])
      countersunkBoltHole();
    #translate([caseWidth - (caseThickness + countersunkBoltHoleDistance), 2*caseThickness + countersunkBoltHoleDistance, 0])
      countersunkBoltHole();

  }

  // sides
  color("yellow") {
      
    // front
    cube([caseWidth, caseThickness, caseThickness + rimOffset], center=false);
    //back
    translate([0, caseDepth - caseThickness, 0])
      cube([caseWidth, caseThickness, caseThickness + rimOffset], center=false);
    // left  
    cube([caseThickness, caseDepth, caseThickness + rimOffset], center=false);
    // right
    translate([caseWidth - caseThickness, 0, 0])
      cube([caseThickness, caseDepth, caseThickness + rimOffset], center=false);
        
  }
  
}

module cornerRim() {

  cube([rimCornerLength, rimThickness, rimHeight]);
  cube([rimThickness, rimCornerLength, rimHeight]);
  
} 

module corner() {

  cube([rimCornerLength, rimCornerLength, rimHeight]);
  
} 


if (print) {

  if (bottom) {
    caseBottom();
  } else {
    caseLid();
  }

} else {

  caseBottom();
  translate([0, caseDepth, caseBottomHeight + 12])
    rotate([180, 0, 0])
    caseLid();
    
}