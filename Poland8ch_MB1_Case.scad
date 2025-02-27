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
mountingHoleDistanceLeftRight = mountingHoleDiameter/2 + 3.2;
mountingHoleDistanceTopBottom = mountingHoleDistanceLeftRight;
lemoRow1DistanceLeft = 16.5;
lemoRow2DistanceBottom = 11.5;
lemoRow3DistanceRight = 40.5;
powerConnectorSmallDistanceRight = 22;
powerConnectorLargeDistanceBottom = 10;
sixteenPinConnectorDistanceRight = 57.5;
switchCenterDistanceTop = 40;
switchCenterDistanceLeft = 115;

// ------------------ Case --------------------- 

caseDistanceBoard = 2;
caseDistanceConnectors = 3;
caseThickness = 3;
caseWidth = boardWidth + 2 * caseDistanceBoard + 2 * caseThickness;
caseDepth = boardDepth + 2 * caseDistanceBoard + 2 * caseThickness;
caseSpacersHeight = groundClearance * 1.5;
caseSpacersThickness = 1.5;
caseBottomHeight = max([lemoHeight, powerConnectorHeight, sixteenPinConnectorHeight]) + caseThickness + caseSpacersHeight + caseDistanceConnectors;
caseTopHeight = caseBottomHeight;

connectorSupportSpacerDistanceLeft = 113 + caseThickness + caseDistanceBoard;
piggySupportSpacerDistanceLeft = 50 + caseThickness + caseDistanceBoard;
nanoSupportSpacerDistanceLeft = 147 + caseThickness + caseDistanceBoard;

caseMountingHoleDistanceLeftRight = caseThickness + caseDistanceBoard + mountingHoleDistanceLeftRight;
caseMountingHoleDistanceTopBottom = caseThickness + caseDistanceBoard + mountingHoleDistanceTopBottom;
countersunkBoltHoleDiameterMin = 2.7;
countersunkBoltHoleDiameterMax = 5.4;
countersunkBoltHoleHeight = 1.6;

rimThickness = 2;
rimCornerLength = 10;
rimHeight = caseTopHeight - caseThickness + 3;

switchHoleWidth = 15;
switchHoleHeight = switchHoleWidth;

// ------------- Print Settings ----------------

print = false;
bottom = false; 
previewBoard = false;
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

module lemoRow(width, distance=false) {
  if (distance) {
    translate([-caseDistanceConnectors, -25, -caseDistanceConnectors])
      cube([width + 2 * caseDistanceConnectors, 50, caseBottomHeight - caseSpacersHeight]);
  } else {
    translate([0, -12, 0])
      cube([width, 20, lemoHeight]);
  }
}

module powerConnector(width, distance=false) {
  if (distance) {
    translate([-caseDistanceConnectors, -25, -caseDistanceConnectors])
      cube([width + 2 * caseDistanceConnectors, 50, caseBottomHeight - caseSpacersHeight]);
  } else {
    cube([width, 15, powerConnectorHeight]);
  }
}

module sixteenPinConnector(distance=false) {
  if (distance) {
    translate([-caseDistanceConnectors, -25, -caseDistanceConnectors])
      cube([sixteenPinConnectorWidth + 2 * caseDistanceConnectors, 50, caseBottomHeight - caseSpacersHeight]);
  } else {
    translate([0, -9, 0])
      cube([sixteenPinConnectorWidth, 17, sixteenPinConnectorHeight]);
  }
}

// Case - Bottom

module caseBottom() {

  translate([caseThickness, caseThickness, 0]) {

    difference() {
      // bottom pane 
      cube([caseWidth - 2 * caseThickness, caseDepth - 2 * caseThickness, caseThickness]);

      // countersunken bolt holes
      translate([caseMountingHoleDistanceLeftRight - caseThickness, caseMountingHoleDistanceTopBottom - caseThickness, 0])
        countersunkBoltHole();
      translate([caseMountingHoleDistanceLeftRight - caseThickness, caseDepth - caseThickness - caseMountingHoleDistanceTopBottom, 0])
        countersunkBoltHole();
      translate([caseWidth - caseThickness - caseMountingHoleDistanceLeftRight, caseMountingHoleDistanceTopBottom - caseThickness, 0])
        countersunkBoltHole();
      translate([caseWidth - caseThickness - caseMountingHoleDistanceLeftRight, caseDepth - caseThickness - caseMountingHoleDistanceTopBottom, 0])
        countersunkBoltHole();

    }

  }
    
  // spacers
  color("#A02020") {

    translate([caseMountingHoleDistanceLeftRight, caseMountingHoleDistanceTopBottom, caseThickness])
      spacer(mountingHoleDiameter, caseSpacersThickness, caseSpacersHeight);
    translate([caseMountingHoleDistanceLeftRight, caseDepth - caseMountingHoleDistanceTopBottom, caseThickness])
      spacer(mountingHoleDiameter, caseSpacersThickness, caseSpacersHeight);
    translate([caseWidth - caseMountingHoleDistanceLeftRight, caseMountingHoleDistanceTopBottom, caseThickness])
      spacer(mountingHoleDiameter, caseSpacersThickness, caseSpacersHeight);
    translate([caseWidth - caseMountingHoleDistanceLeftRight, caseDepth - caseMountingHoleDistanceTopBottom, caseThickness])
      spacer(mountingHoleDiameter, caseSpacersThickness, caseSpacersHeight);
    // support spacers (no screw hole)
    translate([connectorSupportSpacerDistanceLeft, caseDepth - caseMountingHoleDistanceTopBottom, caseThickness])
      spacer(mountingHoleDiameter, caseSpacersThickness, caseSpacersHeight);
    translate([connectorSupportSpacerDistanceLeft, caseMountingHoleDistanceTopBottom, caseThickness])
      spacer(mountingHoleDiameter, caseSpacersThickness, caseSpacersHeight);
    translate([piggySupportSpacerDistanceLeft, caseDepth/2, caseThickness])
      spacer(mountingHoleDiameter, caseSpacersThickness, caseSpacersHeight);
    translate([nanoSupportSpacerDistanceLeft, caseDepth*2/3, caseThickness])
      spacer(mountingHoleDiameter, caseSpacersThickness, caseSpacersHeight);
      
  }

  // sides
  color("yellow") {

    difference() {

      union() {
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

      translate([caseDistanceBoard + caseThickness, caseDistanceBoard + caseThickness, caseThickness + caseSpacersHeight])
        connectorSlots();
        
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
  union() {
    cylinder(d1=countersunkBoltHoleDiameterMax, d2=countersunkBoltHoleDiameterMin, h=countersunkBoltHoleHeight, center = false);
    cylinder(d=countersunkBoltHoleDiameterMin, h=caseThickness, center = false);

  }
}

module connectorSlots() {

  // lemo rows
  color("gray") {

    // row 1 (bottom)
    translate([lemoRow1DistanceLeft, 0, 0])
      lemoRow(lemoRow1Width, distance=true);

    // row 2 (left)
    translate([0, lemoRow2Width + lemoRow2DistanceBottom, 0])
      rotate([0, 0, -90])
        lemoRow(lemoRow2Width, distance=true);

    // row 3 (top)
    translate([boardWidth - lemoRow3DistanceRight, boardDepth, 0])
      rotate([0, 0, 180])
        lemoRow(lemoRow3Width, distance=true);
    
  }

  // 16-pin & power connectors
  color("#202020") {

    // power connector (small)
    translate([boardWidth - powerConnectorSmallDistanceRight, boardDepth, 0])
      rotate([0, 0, 180])
        powerConnector(powerConnectorWidthSmall, distance=true);
    
    // power connector (large)
    translate([boardWidth, powerConnectorLargeDistanceBottom, 0])
      rotate([0, 0, 90])
        powerConnector(powerConnectorWidthLarge, distance=true);

    // 16-pin connector
    translate([boardWidth - sixteenPinConnectorWidth - sixteenPinConnectorDistanceRight, 0, 0])
      sixteenPinConnector(distance=true);
    
  }
  
}

// Case - Top
module caseTop() {

  translate([caseThickness, caseThickness, 0]) {

    difference() {
      // top pane 
      cube([caseWidth - 2 * caseThickness, caseDepth - 2 * caseThickness, caseThickness]);

      // countersunken bolt holes
      translate([caseMountingHoleDistanceLeftRight - caseThickness, caseMountingHoleDistanceTopBottom - caseThickness, 0])
        countersunkBoltHole();
      translate([caseMountingHoleDistanceLeftRight - caseThickness, caseDepth - caseThickness - caseMountingHoleDistanceTopBottom, 0])
        countersunkBoltHole();
      translate([caseWidth - caseThickness - caseMountingHoleDistanceLeftRight, caseMountingHoleDistanceTopBottom - caseThickness, 0])
        countersunkBoltHole();
      translate([caseWidth - caseThickness - caseMountingHoleDistanceLeftRight, caseDepth - caseThickness - caseMountingHoleDistanceTopBottom, 0])
        countersunkBoltHole();

      // switch hole
      #translate([switchCenterDistanceLeft - switchHoleWidth/2, switchCenterDistanceTop - switchHoleHeight/2, 0])
        cube([switchHoleWidth, switchHoleHeight, caseThickness]);

    }

  }
    
  // spacers
  color("#A02020") {

    translate([caseMountingHoleDistanceLeftRight, caseMountingHoleDistanceTopBottom, caseThickness])
      spacer(mountingHoleDiameter, caseSpacersThickness, caseSpacersHeight);
    translate([caseMountingHoleDistanceLeftRight, caseDepth - caseMountingHoleDistanceTopBottom, caseThickness])
      spacer(mountingHoleDiameter, caseSpacersThickness, caseSpacersHeight);
    translate([caseWidth - caseMountingHoleDistanceLeftRight, caseMountingHoleDistanceTopBottom, caseThickness])
      spacer(mountingHoleDiameter, caseSpacersThickness, caseSpacersHeight);
    translate([caseWidth - caseMountingHoleDistanceLeftRight, caseDepth - caseMountingHoleDistanceTopBottom, caseThickness])
      spacer(mountingHoleDiameter, caseSpacersThickness, caseSpacersHeight);
      
  }

  // sides
  color("yellow") {

    // front
    cube([caseWidth, caseThickness, caseTopHeight], center=false);
    //back
    translate([0, caseDepth - caseThickness, 0])
      cube([caseWidth, caseThickness, caseTopHeight], center=false);
    // left  
    cube([caseThickness, caseDepth, caseTopHeight], center=false);
    // right
    translate([caseWidth - caseThickness, 0, 0])
      cube([caseThickness, caseDepth, caseTopHeight], center=false);
      
  }

  // rim
  color("green") {

    translate([caseThickness, caseThickness, caseThickness]) {
      cornerRim();
    }

    translate([caseThickness, caseDepth - caseThickness, caseThickness]) {
      rotate([0, 0, 270])
        cornerRim();
    }

    translate([caseWidth - caseThickness, caseThickness, caseThickness]) {
      rotate([0, 0, 90])
        cornerRim();
    }

    translate([caseWidth - caseThickness, caseDepth - caseThickness, caseThickness]) {
      rotate([0, 0, 180])
        cornerRim();
    }
    
  }

}

module cornerRim() {

  cube([rimCornerLength, rimThickness, rimHeight]);
  cube([rimThickness, rimCornerLength, rimHeight]);
  
} 


if (print) {

  if (bottom) {
    caseBottom();
  } else {
    caseTop();
  }

} else {

  if (bottom) {

    if (previewBoard) {
      caseBottom();
      translate([caseDistanceBoard + caseThickness, caseDistanceBoard + caseThickness, caseThickness + caseSpacersHeight])
        board();
    } else {
      caseBottom();
    }
    
  } else {
    translate([0, caseDepth, caseTopHeight])
      rotate([180, 0,0 ])
        caseTop();
  }

}