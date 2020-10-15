distanceUpperTable = 19;
distanceLowerTable = 17.5;
thicknessUpperTable = 29;
thicknessLowerTable = 20;
topPartLength = 60;
topPartHeight = 3;
thickness = 5;

module wall_t() {

  // top part
  translate([0, 0, 0])
    cube(size=[topPartLength, thickness, topPartHeight], center=false);
  // upper table part
  translate([0, 0, -thicknessUpperTable])
    cube(size=[distanceUpperTable, thickness, thicknessUpperTable], center=false);
  // lower table part
  translate([0, 0, -(thicknessLowerTable + thicknessUpperTable)])
    cube(size=[distanceLowerTable, thickness, thicknessLowerTable], center=false);
  
}


wall_t();