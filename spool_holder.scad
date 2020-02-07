$fn = 50;

wallThickness = 2;
holderLength = 160;
holderOuterDiameter = 52;
holderInnerDiameter = 5.5;
maxSpoolWidth = 77;
printLips = true;

union() {
  tube(holderOuterDiameter, holderLength, wallThickness);
  tube(holderInnerDiameter, holderLength, wallThickness, relevantRadius = "inner");
  spine(holderInnerDiameter/2, holderOuterDiameter/2, holderLength, wallThickness);
  if (printLips) {
    lip(holderOuterDiameter/2, 2, 1);
    translate([0, 0, 1*maxSpoolWidth+1*wallThickness])
      lip(holderOuterDiameter/2, 2, wallThickness);
    translate([0, 0, 2*maxSpoolWidth+2*wallThickness])
      lip(holderOuterDiameter/2, 2, wallThickness);
  }
}

module tube(diameter, length, thickness, relevantRadius = "outer") {
  if (relevantRadius == "inner") {
    difference() {
      cylinder(r=(diameter/2)+thickness, h=length, center=false);
      cylinder(r=diameter/2, h=length, center=false);
    }
  } else {
    difference() {
      cylinder(r=diameter/2, h=length, center=false);
      cylinder(r=(diameter/2)-thickness, h=length, center=false);
    }
  }
}

module spine(innerRadius, outerRadius, length, thickness) {
  linear_extrude(height = length, center = false, convexity = 10, twist = -360*3)
    translate([innerRadius+thickness, 0, 0])
      square([outerRadius-thickness-(innerRadius+thickness), thickness]);

}

module lip(radius, height, thickness) {
  // difference() {
  //   cylinder(r=radius+height, h=thickness, center=false);
  //   cylinder(r=radius, h=thickness, center=false);
  // }
  difference() {
    hull() {
      cylinder(r=radius, h=0.2, center=false);
      translate([0, 0, thickness-0.2])
        cylinder(r=radius, h=0.2, center=false);
      translate([0, 0, (thickness-0.2)/2])
        cylinder(r=radius+height, h=0.2, center=false);
    }
    cylinder(r=radius, h=500, center=false);
  }
}

