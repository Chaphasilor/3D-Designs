$fn = 25;

wallThickness = 2.5;
boardWidth = 250;
boardDepth = 70;
boardThickness = 2;

boardPlay = 0.25;

clearanceRight = 2;
clearanceLeft = 1;
clearanceTop = 20;
clearanceBottom = 10;

supportPillarOffsetLeft = 90;
supportPillarThicknessLeft = 2;
// supportPillarSupportWidthLeft = 13;
supportPillarSupportWidthLeft = 0;
supportPillarSupportOffsetTopLeft = 13;
supportPillarStabilizerWidth = 8;

backLipWidth = 20;

largeHoleDiameter = 5;
smallHoleDiameter = 3;
smallHoleMarginZ = 18.5;

// computed

caseWidth = boardWidth + 2*wallThickness - (clearanceLeft + clearanceRight) + clearanceRight/2;
caseDepth = boardDepth + wallThickness;
boardHeightTotal = (clearanceBottom + clearanceTop + boardThickness);
caseHeight = 4* boardHeightTotal + 2*wallThickness;

module csa_32ch_rack() {
  
  color("lightgray") {

    difference() {

      union() {

        difference() {
          cube([caseWidth, caseDepth, caseHeight]);

          translate([wallThickness, 0, wallThickness])
            #cube([caseWidth-2*wallThickness-clearanceRight/2, caseDepth-wallThickness, caseHeight-2*wallThickness]);
        }

        translate([-backLipWidth, caseDepth - wallThickness, 0])
          backLip();
        translate([caseWidth, caseDepth - wallThickness, 0])
          backLip();

        translate([supportPillarOffsetLeft + (wallThickness - clearanceLeft), 0, 0])
            supportPillar();

      }

      translate([wallThickness - clearanceLeft, 0, clearanceBottom + boardThickness + wallThickness])
        #board();
      translate([wallThickness - clearanceLeft, 0, clearanceBottom + boardThickness + wallThickness + boardHeightTotal])
        #board();
      translate([wallThickness - clearanceLeft, 0, clearanceBottom + boardThickness + wallThickness + 2*boardHeightTotal])
        #board();
      translate([wallThickness - clearanceLeft, 0, clearanceBottom + boardThickness + wallThickness + 3*boardHeightTotal])
        #board();

    }

  }
  
}

module supportPillar() {

  translate([-supportPillarThicknessLeft/2, 0, 0]) {

    cube([supportPillarThicknessLeft, caseDepth, caseHeight]);

    translate([-(supportPillarStabilizerWidth-supportPillarThicknessLeft)/2, 0, boardHeightTotal])
      cube([supportPillarStabilizerWidth, caseDepth, supportPillarThicknessLeft]);
    translate([-(supportPillarStabilizerWidth-supportPillarThicknessLeft)/2, 0, 2*boardHeightTotal])
      cube([supportPillarStabilizerWidth, caseDepth, supportPillarThicknessLeft]);
    translate([-(supportPillarStabilizerWidth-supportPillarThicknessLeft)/2, 0, 3*boardHeightTotal])
      cube([supportPillarStabilizerWidth, caseDepth, supportPillarThicknessLeft]);

  }
  
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
  
  translate([-boardPlay, 0, -boardPlay])
    difference() {
      color("red")
        cube([boardPlay+boardWidth+boardPlay, boardDepth, boardPlay+boardThickness+boardPlay]);

      color("blue") {
        translate([0, 0, boardPlay+boardThickness+boardPlay])
          cube([boardWidth, boardDepth, clearanceTop]);
        translate([0, 0, -boardThickness-clearanceBottom])
          cube([boardWidth, boardDepth, clearanceBottom]);
      }
    }
  
}

csa_32ch_rack();
