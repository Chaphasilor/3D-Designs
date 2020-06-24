// -------------- Measurements -----------------
groundClearance = 3;
mountingHoleDiameter = 3.5;
sixteenPinConnectorWidth = 28;
sixteenPinConnectorHeight = 8.7;
powerConnectorWidthLarge = 16;
powerConnectorWidthSmall = 14;
powerConnectorHeight = 7.7;
lemoWidth = 7.2;
lemoHeight = 7;
lemoRow1Width = 92;
lemoRow2Width = 77;
lemoRow3Width = 29;
boardThickness = 1.7;
maxHeight = 17.4;
boardDepth = 100;
boardWidth = 200;

mountingHoleDistanceLeftRight = mountingHoleDiameter/2 + 5;
mountingHoleDistanceTopBottom = mountingHoleDistanceLeftRight;
lemoRow1DistanceLeft = 20;
lemoRow2DistanceBottom = 10;
lemoRow3DistanceRight = 45;
powerConnectorSmallDistanceRight = 25;
powerConnectorLargeDistanceBottom = 10;
sixteenPinConnectorDistanceRight = 50;

// ------------------ Case --------------------- 

caseDistanceBoard = 2;
caseDistanceConnectors = 3;
caseThickness = 3;
caseWidth = boardWidth + 2 * caseDistanceBoard + 2 * caseThickness;
caseDepth = boardDepth + 2 * caseDistanceBoard + 2 * caseThickness;
caseHeight = 40;
caseSpacersHeight = groundClearance * 1.5;
caseSpacersThickness = 1.5;

caseMountingHoleDistanceLeftRight = caseDistanceBoard + mountingHoleDistanceLeftRight;
caseMountingHoleDistanceTopBottom = caseDistanceBoard + mountingHoleDistanceTopBottom;
// countersunkBoltHoleDiameterMin = 2;
countersunkBoltHoleDiameterMin = mountingHoleDiameter;
countersunkBoltHoleDiameterMax = 5;
countersunkBoltHoleHeight = 2;

// ------------- Print Settings ----------------

preview = true;
$fn = 40;

// ---------------- Modules --------------------

// Board
module board() {

  translate([0, 0, 0]) {
    
    difference() {

      // actual board
      color("#20C080") {
        cube([boardWidth, boardDepth, boardThickness], center=false);
      }

      // mounting holes
      color("black") {

        // bottom left
        translate([mountingHoleDistanceLeftRight, mountingHoleDistanceTopBottom, 0])
          holePuncher(mountingHoleDiameter, boardThickness);
        // top left
        translate([mountingHoleDistanceLeftRight, boardDepth - mountingHoleDistanceTopBottom, 0])
          holePuncher(mountingHoleDiameter, boardThickness);
        // bottom right
        translate([boardWidth - mountingHoleDistanceLeftRight, mountingHoleDistanceTopBottom, 0])
          holePuncher(mountingHoleDiameter, boardThickness);
        // top right
        translate([boardWidth - mountingHoleDistanceLeftRight, boardDepth - mountingHoleDistanceTopBottom, 0])
          holePuncher(mountingHoleDiameter, boardThickness);

      }

    }

    // ground clearance
    color("lightblue") {
      translate([(boardWidth * 0.2)/2, (boardDepth * 0.2)/2, -groundClearance])
        cube([boardWidth * .80, boardDepth * .80, groundClearance], center=false);
    }

    // lemo rows
    color("gray") {

      // row 1 (bottom)
      translate([lemoRow1DistanceLeft, 0, 0])
        lemoRow(lemoRow1Width);

      // row 2 (left)
      translate([0, lemoRow2Width + lemoRow2DistanceBottom, 0])
        rotate([0, 0, -90])
          lemoRow(lemoRow2Width);

      // row 3 (top)
      translate([boardWidth - lemoRow3DistanceRight, boardDepth, 0])
        rotate([0, 0, 180])
          lemoRow(lemoRow3Width);
      
    }

    // 16-pin & power connectors
    color("#202020") {

      // power connector (small)
      translate([boardWidth - powerConnectorSmallDistanceRight, boardDepth, 0])
        rotate([0, 0, 180])
          powerConnector(powerConnectorWidthSmall);
      
      // power connector (large)
      translate([boardWidth, powerConnectorLargeDistanceBottom, 0])
        rotate([0, 0, 90])
          powerConnector(powerConnectorWidthLarge);

      // 16-pin connector
      translate([boardWidth - sixteenPinConnectorWidth - sixteenPinConnectorDistanceRight, 0, 0])
        sixteenPinConnector();
      
    }
       
  }

}

module holePuncher(diameter, height) {
  cylinder(d=diameter, h=height, center=false, $fn=20);
}

module lemoRow(width) {
  translate([0, -12, 0])
    cube([width, 20, lemoHeight]);
}

module powerConnector(width) {
  cube([width, 15, powerConnectorHeight]);
}

module sixteenPinConnector() {
  translate([0, -9, 0])
    cube([sixteenPinConnectorWidth, 17, sixteenPinConnectorHeight]);
}

// Case - Bottom

module caseBottom() {

  translate([caseThickness, caseThickness, 0]) {

    difference() {
      // bottom pane 
      cube([caseWidth - 2 * caseThickness, caseDepth - 2 * caseThickness, caseThickness]);

      // countersunken bolt holes
      translate([caseMountingHoleDistanceLeftRight, caseMountingHoleDistanceTopBottom, 0])
        countersunkBoltHole();
      translate([caseMountingHoleDistanceLeftRight, boardDepth - caseMountingHoleDistanceTopBottom, 0])
        countersunkBoltHole();
      translate([boardWidth - caseMountingHoleDistanceLeftRight, caseMountingHoleDistanceTopBottom, 0])
        countersunkBoltHole();
      translate([boardWidth - caseMountingHoleDistanceLeftRight, boardDepth - caseMountingHoleDistanceTopBottom, 0])
        countersunkBoltHole();

    }
    
    // spacers
    color("#A02020") {

      translate([caseMountingHoleDistanceLeftRight, caseMountingHoleDistanceTopBottom, caseThickness])
        spacer(mountingHoleDiameter, caseSpacersThickness, caseSpacersHeight);
      translate([caseMountingHoleDistanceLeftRight, boardDepth - caseMountingHoleDistanceTopBottom, caseThickness])
        spacer(mountingHoleDiameter, caseSpacersThickness, caseSpacersHeight);
      translate([boardWidth - caseMountingHoleDistanceLeftRight, caseMountingHoleDistanceTopBottom, caseThickness])
        spacer(mountingHoleDiameter, caseSpacersThickness, caseSpacersHeight);
      translate([boardWidth - caseMountingHoleDistanceLeftRight, boardDepth - caseMountingHoleDistanceTopBottom, caseThickness])
        spacer(mountingHoleDiameter, caseSpacersThickness, caseSpacersHeight);
        
    }

  }
  

  // sides
  color("yellow") {

    // front
    cube([caseWidth, caseThickness, caseHeight], center=false);
    //back
    translate([0, caseDepth - caseThickness, 0])
      cube([caseWidth, caseThickness, caseHeight], center=false);
    // left  
    cube([caseThickness, caseDepth, caseHeight], center=false);
    // right
    translate([caseWidth - caseThickness, 0, 0])
      cube([caseThickness, caseDepth, caseHeight], center=false);
      
  }
  
}

module spacer(innerDiameter, thickness, height) {

  difference() {
    cylinder(r=(innerDiameter/2 + thickness), h=height, center = false);
    cylinder(d=innerDiameter, h=height, center = false);
  }
  
}

module countersunkBoltHole() {
  union() {
    cylinder(d1=countersunkBoltHoleDiameterMax, d2=countersunkBoltHoleDiameterMin, h=countersunkBoltHoleHeight, center = false);
    cylinder(d=countersunkBoltHoleDiameterMin, h=caseThickness, center = false);

  }
}



if (preview) {

  caseBottom();
  translate([caseDistanceBoard + caseThickness, caseDistanceBoard + caseThickness, caseThickness + caseSpacersHeight])
    board();
  
} else {
  board();
}