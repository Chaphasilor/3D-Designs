// wall-table-part
distanceUpperTable = 19;
distanceLowerTable = 17.5;
thicknessUpperTable = 29;
thicknessLowerTable = 20;
overshootHeight = 15;
overshootDepth = 7;
topPartLength = 100;
topPartHeight = 8;
thickness = 3;
holeDiameter = 3;
hole1Offset = 10;
hole2Offset = 30;

boardAngle = 35;
triangleThickness = 3;
triangleSideLengthBoard = 140;
triangleSideLengthBack = cos(boardAngle)*triangleSideLengthBoard;
triangleSideLengthBottom = sin(boardAngle)*triangleSideLengthBoard;
triangleBorderThickness = 12;
innerTriangleScale = (triangleSideLengthBoard-2*triangleBorderThickness)/triangleSideLengthBoard;
innerTriangleOffsetBottom = triangleBorderThickness;
innerTriangleOffsetLeft = triangleBorderThickness/cos(boardAngle);

echo(str("innerTriangleScale: ", innerTriangleScale));
echo(str("triangleSideLengthBack: ", triangleSideLengthBack));
echo(str("triangleSideLengthBottom: ", triangleSideLengthBottom));


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

module triangle(bottomSide, hyp, alpha) {

  difference() {
    cube([bottomSide, triangleThickness, hyp*cos(alpha)]);

    translate([-bottomSide, 0, (bottomSide/cos(alpha))*sin(alpha)])
      rotate([0, alpha, 0])
        cube([bottomSide/cos(alpha), triangleThickness, hyp]);
  }

}

module triangleStand() {

  difference() {
    // outer triangle
    triangle(triangleSideLengthBottom, triangleSideLengthBoard, boardAngle);
    // inner triangle
    translate([innerTriangleOffsetLeft, 0, innerTriangleOffsetBottom])
      scale([(triangleSideLengthBottom-2*triangleBorderThickness)/triangleSideLengthBottom, 1, (triangleSideLengthBottom-2*triangleBorderThickness)/triangleSideLengthBottom]) 
        #triangle(triangleSideLengthBottom, triangleSideLengthBoard, boardAngle);
    // screw holes
    translate([triangleSideLengthBottom - hole1Offset, thickness, holeDiameter/2 + (topPartHeight-holeDiameter)/2])
      rotate([90, 0, 0])
        #cylinder(d=holeDiameter, h=thickness, center=false, $fn=25);
    translate([triangleSideLengthBottom - hole2Offset, thickness, holeDiameter/2 + (topPartHeight-holeDiameter)/2])
      rotate([90, 0, 0])
        #cylinder(d=holeDiameter, h=thickness, center=false, $fn=25);
  }

}


wallTablePart();

// triangleStand();