sideLengthCube = 15;
sideLengthCage = 50;
wallThicknessCage = 2;
pillarThicknessCage = 4.5;

module cage() {

  cageFrame();
  // cagePillar();

  translate([0, 0, wallThicknessCage]) {

    for (i=[0:4]) {

      for (j=[0:(sideLengthCage/pillarThicknessCage)-1]) {

        if (i == 0) {
          if (j%2 == 0) {
            translate([j*pillarThicknessCage, 0, 0])
              cagePillar();
          }
        } else if (i == 1) {
          if (j%2 == 0) {
            translate([wallThicknessCage, j*pillarThicknessCage, 0])
              rotate([0, 0, 90])
                cagePillar();
          }
        } else if (i == 2) {
          if (j%2 == 0) {
            translate([j*pillarThicknessCage, sideLengthCage - wallThicknessCage, 0])
              cagePillar();
          }
        } else {
          if (j%2 == 0) {
            translate([sideLengthCage, j*pillarThicknessCage, 0])
              rotate([0, 0, 90])
                cagePillar();
          }
        }
        
      }
      
    }

  }
  
  // translate([2*wallThicknessCage, 0, wallThicknessCage])
  //   cagePillar();
  translate([0, 0, sideLengthCage - 2*wallThicknessCage])
    cageFrame();
  
}

module cageFrame() {

  cube([sideLengthCage, sideLengthCage, wallThicknessCage]);
  // difference() {
  //   cube([sideLengthCage, sideLengthCage, wallThicknessCage]);
  //   translate([wallThicknessCage, wallThicknessCage, 0])
  //     cube([sideLengthCage - 2*wallThicknessCage, sideLengthCage - 2*wallThicknessCage, wallThicknessCage]);
  // }
  
}

module cagePillar() {

  cube([pillarThicknessCage, wallThicknessCage, sideLengthCage - 2*wallThicknessCage]);
  
}

module innerCube() {

  translate([sideLengthCage/2 - sideLengthCube/2, sideLengthCage/2 - sideLengthCube/2, sideLengthCage/2 - sideLengthCube/2])
    cube([sideLengthCube, sideLengthCube, sideLengthCube]);
  
}

cage();
innerCube();