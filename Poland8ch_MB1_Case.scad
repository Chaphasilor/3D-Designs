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

// ------------- Print Settings ----------------



// ---------------- Modules --------------------

module board() {

  translate([0, 0, groundClearance]) {
    
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
    translate([(boardWidth * 0.2)/2, (boardDepth * 0.2)/2, -groundClearance])
      cube([boardWidth * .80, boardDepth * .80, groundClearance], center=false);

    // lemo rows
    color("lightgray") {

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

board();