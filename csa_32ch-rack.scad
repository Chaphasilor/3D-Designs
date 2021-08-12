wallThickness = 3;
boardWidth = 250;
boardDepth = 70;
boardThickness = 2;

clearanceRight = 3;
clearanceLeft = 1;
clearanceTop = 20;
clearanceBottom = 10;

supportPillarOffsetLeft = 88;
supportPillarThicknessLeft = 3;
// supportPillarSupportWidthLeft = 13;
supportPillarSupportWidthLeft = 0;
supportPillarSupportOffsetTopLeft = 13;

backLipWidth = 20;

largeHoleDiameter = 5;
smallHoleDiameter = 3;
smallHoleMarginZ = 18.5;

// computed

caseWidth = boardWidth + 2.5*wallThickness - (clearanceLeft + clearanceRight);
caseDepth = boardDepth + wallThickness;
boardHeightTotal = (clearanceBottom + clearanceTop + boardThickness);
caseHeight = 4* boardHeightTotal + 2*wallThickness;

module csa_32ch_rack() {
  
  color("lightgray") {

    difference() {

      union() {

        cube([caseWidth, caseDepth, caseHeight]);

        translate([-backLipWidth, caseDepth - wallThickness, 0])
          backLip();
        translate([caseWidth, caseDepth - wallThickness, 0])
          backLip();
        
        
      }

      translate([wallThickness, 0, wallThickness])
        cube([caseWidth-2.5*wallThickness, caseDepth-wallThickness, caseHeight-2*wallThickness]);

      translate([wallThickness - clearanceLeft, 0, clearanceBottom + boardThickness + wallThickness])
        board();
      translate([wallThickness - clearanceLeft, 0, clearanceBottom + boardThickness + wallThickness + boardHeightTotal])
        board();
      translate([wallThickness - clearanceLeft, 0, clearanceBottom + boardThickness + wallThickness + 2*boardHeightTotal])
        board();
      translate([wallThickness - clearanceLeft, 0, clearanceBottom + boardThickness + wallThickness + 3*boardHeightTotal])
        board();

    }
    
    translate([supportPillarOffsetLeft, 0, 0])
      supportPillar();
    
  }
  
}

module supportPillar() {

  cube([supportPillarThicknessLeft, caseDepth, caseHeight]);

  // translate([0, 0, 0])
  //   cube([supportPillarSupportWidthLeft, caseDepth, supportPillarThicknessLeft])
  
}

module backLip() {

  difference() {

    cube([backLipWidth, wallThickness, caseHeight]);

    #translate([backLipWidth/2, wallThickness/2, smallHoleMarginZ + wallThickness])
      rotate([90, 0, 0])
        cylinder(d=smallHoleDiameter, h=2*wallThickness, center=true);
    #translate([backLipWidth/2, wallThickness/2, caseHeight - smallHoleMarginZ])
      rotate([90, 0, 0])
        cylinder(d=smallHoleDiameter, h=2*wallThickness, center=true);
    #translate([backLipWidth/2, wallThickness/2, (caseHeight-wallThickness)/2 + wallThickness])
      rotate([90, 0, 0])
        cylinder(d=largeHoleDiameter, h=2*wallThickness, center=true);
    
  }
  
}

module board() {
  
  difference() {
    color("red")
      cube([boardWidth, boardDepth, boardThickness]);

    color("blue") {
      translate([0, 0, boardThickness])
        cube([boardWidth, boardDepth, clearanceTop]);
      translate([0, 0, -boardThickness-clearanceBottom])
        cube([boardWidth, boardDepth, clearanceBottom]);
    }
  }
  
}

csa_32ch_rack();
