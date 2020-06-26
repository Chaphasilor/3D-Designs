sideLengthCube = 15;
sideLengthCage = 50;
wallThicknessCube = 2;
wallThicknessCage = 2;

module cage() {

  cageFrame();
  // cagePillar();

  translate([0, 0, wallThicknessCage]) {

    for (i=[0:4]) {

      for (j=[0:(sideLengthCage/wallThicknessCage)-1]) {

        if (i == 0) {
          if (j%2 == 0) {
            translate([j*wallThicknessCage, 0, 0])
              cagePillar();
          }
        } else if (i == 1) {
          if (j%2 == 0) {
            translate([0, j*wallThicknessCage, 0])
              cagePillar();
          }
        } else if (i == 2) {
          if (j%2 == 0) {
            translate([j*wallThicknessCage, sideLengthCage - wallThicknessCage, 0])
              cagePillar();
          }
        } else {
          if (j%2 == 0) {
            translate([sideLengthCage - wallThicknessCage, j*wallThicknessCage, 0])
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

  difference() {
    cube([sideLengthCage, sideLengthCage, wallThicknessCage]);
    translate([wallThicknessCage, wallThicknessCage, 0])
      cube([sideLengthCage - 2*wallThicknessCage, sideLengthCage - 2*wallThicknessCage, wallThicknessCage]);
  }
  
}

module cagePillar() {

  cube([wallThicknessCage, wallThicknessCage, sideLengthCage - 2*wallThicknessCage]);
  
}

cage();