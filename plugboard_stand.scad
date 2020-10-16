// wall-table-part
distanceUpperTable = 19;
distanceLowerTable = 17.5;
thicknessUpperTable = 29;
thicknessLowerTable = 20;
overshootHeight = 15;
overshootDepth = 7;
topPartLength = 60;
topPartHeight = 8;
thickness = 5;
holeDiameter = 3;
hole1Offset = 10;
hole2Offset = 20;

module wallTablePart() {

  // top part
  difference() {
    translate([0, 0, 0])
      cube(size=[topPartLength, thickness, topPartHeight], center=false);
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


wallTablePart();