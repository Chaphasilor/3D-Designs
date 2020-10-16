// wall-table-part
distanceUpperTable = 19;
distanceLowerTable = 17.5;
thicknessUpperTable = 29;
thicknessLowerTable = 20;
overshootHeight = 15;
overshootDepth = 7;
topPartLength = 80;
topPartHeight = 8;
thickness = 5;
holeDiameter = 3;
hole1Offset = 10;
hole2Offset = 30;

boardAngle = 45;
triangleThickness = 5;
triangleBorderThickness = 8;
triangleSideLengthBoard = 140;
triangleSideLengthBack = cos(boardAngle)*triangleSideLengthBoard;
triangleSideLengthBottom = sin(boardAngle)*triangleSideLengthBoard;


module wallTablePart() {

  // top part
  difference() {
    translate([0, 0, 0])
      cube(size=[topPartLength, thickness, topPartHeight], center=false);
    // screw holes
    translate([topPartLength - hole1Offset, thickness, holeDiameter/2 + (topPartHeight-holeDiameter)/2])
      rotate([90, 0, 0])
        #cylinder(d=holeDiameter, h=thickness, center=false, $fn=25);
    translate([topPartLength - hole2Offset, thickness, holeDiameter/2 + (topPartHeight-holeDiameter)/2])
      rotate([90, 0, 0])
        #cylinder(d=holeDiameter, h=thickness, center=false, $fn=25);
  }
  // upper table part
  translate([0, 0, -thicknessUpperTable])
    cube(size=[distanceUpperTable, thickness, thicknessUpperTable], center=false);
  // overshoot
  translate([0, 0, topPartHeight])
    cube(size=[overshootDepth, thickness, overshootHeight], center=false);
  // lower table part
  translate([0, 0, -(thicknessLowerTable + thicknessUpperTable)])
    cube(size=[distanceLowerTable, thickness, thicknessLowerTable], center=false);
  
}

module triangle(bottomSide, alpha) {

  difference() {
    cube([bottomSide, triangleThickness, sin(alpha)*bottomSide/cos(alpha)]);

    translate([-(sin(alpha)*(bottomSide/cos(alpha)/2)*sqrt(2)), 0, cos(alpha)*(bottomSide/sin(alpha)/2)*sqrt(2)])
      rotate([0, 90-alpha, 0])
        cube([(bottomSide/cos(alpha)/2)*sqrt(2), triangleThickness, bottomSide/cos(alpha)]);
  }

}

module triangleStand() {

  difference() {
    // outer triangle
    triangle(triangleSideLengthBottom, boardAngle);
    // inner triangle
    translate([triangleBorderThickness*2, 0, triangleBorderThickness])
      triangle(triangleSideLengthBottom-triangleBorderThickness*3, boardAngle);
    // screw holes
    translate([triangleSideLengthBottom - hole1Offset, thickness, holeDiameter/2 + (topPartHeight-holeDiameter)/2])
      rotate([90, 0, 0])
        #cylinder(d=holeDiameter, h=thickness, center=false, $fn=25);
    translate([triangleSideLengthBottom - hole2Offset, thickness, holeDiameter/2 + (topPartHeight-holeDiameter)/2])
      rotate([90, 0, 0])
        #cylinder(d=holeDiameter, h=thickness, center=false, $fn=25);
  }

}


// wallTablePart();

triangleStand();