// VARIABLES
$fn=20;

width = 350;
totalHeight = 30;
frontThickness = 3;
bottomLipThickness = 1.5;
bottomLipDepth = 10;
topLipThickness = 1.5;
topLipDepth = 10;
sideProtrusion = 14.5;
holeCenterDistanceBottom = 12;
holeCenterDistanceSide = 7;
holeDiameter = 5;
pinCenterDistanceBottom = 19;
pinCenterDistanceSide = 7;
pinDiameter = 2.5;
pinDepth = 8;
gripLength = 30;
gripHeight = 20;

// VARIABLES (CALCULATED)

mainHeight = totalHeight - topLipThickness; // bottom lip is added below, top lip is added behind
bottomLipWidth = width - sideProtrusion*2;
topLipWidth = bottomLipWidth;

// case (general)

module dust_cover() {
  
  translate([0, bottomLipThickness, 0]){
    difference() {
      front_cover();
      
      hole_puncher();
    }

    // #grips();

    translate([0, mainHeight - topLipThickness, frontThickness])
      translate([sideProtrusion, 0, 0])
        top_lip();

    translate([0, 0, frontThickness])
      pins();
  }

  translate([sideProtrusion, 0, 0])
    bottom_lip();
  
}

module front_cover() {

  cube([width, mainHeight, frontThickness]);

}

module hole_puncher() {
  
  translate([holeCenterDistanceSide, holeCenterDistanceBottom, 0])
    #cylinder(d=holeDiameter, h=frontThickness*2, center=false);

  translate([width - holeCenterDistanceSide, holeCenterDistanceBottom, 0])
    #cylinder(d=holeDiameter, h=frontThickness*2, center=false);
  
}

module bottom_lip() {
  
  cube([bottomLipWidth, bottomLipThickness, bottomLipDepth + frontThickness]);

}

module top_lip() {
  
  cube([topLipWidth, topLipThickness, topLipDepth]);

}

module pins() {
  
  translate([pinCenterDistanceSide, pinCenterDistanceBottom, 0])
    cylinder(d=pinDiameter, h=pinDepth, center=false);
  
  translate([width - pinCenterDistanceSide, pinCenterDistanceBottom, 0])
    cylinder(d=pinDiameter, h=pinDepth, center=false);
  
}

module grips() {
  
  translate([0, 0, frontThickness]) {
    rotate([0, 45, 0])
      cube([gripLength, gripHeight, gripThickness]);
    rotate([0, -45, 0])
      cube([gripLength, gripHeight, gripThickness]);
  }
  
}


print = false;

if (print) {

  rotate([0, 0, 45])
    dust_cover();

} else {

  dust_cover();
  
}
  