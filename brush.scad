// ----- CONFIG -----
wallThickness = 2;
length = 52 + wallThickness; // length in x direction
upperHeight = 23 + wallThickness;
lowerHeight = 12.5 + wallThickness;
topPartOffset = 10;
heightDifference = upperHeight - lowerHeight;
backInnerLength = 31; // without the sides
backOuterLength = backInnerLength + 2*wallThickness;
hingeOffset = 5;
hingeLength = backOuterLength - (2 * hingeOffset);
femaleHingeInnerRadius = 2;
femaleHingeOuterRadius = 4;
hingeHeight = 7;
maleHingeRadius = femaleHingeInnerRadius * 0.9;
handleLength = 20;
handleThickness = 1.5;

print = true;
$fn = 25;

debug = false; // toggles stacked view/debugging
debugHinges = false; // toggles only showing hinges
debugBottom = false;
debugBottomHinge = false;
debugTopHinge = false;

// render() {

// bottom part
if (!debug || debugBottom || debugHinges) {
  if ((!debug || !debugBottom) && !debugHinges) {
    if (print) {
      translate([0, 0, length]) rotate([0, 90, 0]) bottomPart();
    } else {
      bottomPart();
    }
  } else {
    bottomPart();
  }
}

// top part
if (!debug || !debugBottom || debugHinges) {
  if ((!debug || debugBottom) && !debugHinges) {
    if (print) {
      translate([-length*1.5, upperHeight*2, 0]) rotate([90, 0, 0]) topPart();
    } else {
      translate([0, 0, 1])
        topPart();
    }
  } else {
    topPart();
  }
  
}

// ----- MODULES ------

module bottomPart() {
  if (debugHinges || debugBottomHinge) {
    translate([0, 0, -7]) femaleHinge();
  } else {
    union() {
      bottomMain();
      translate([-wallThickness, 0, 0]) femaleHinge();
    }
  }
}

module topPart() {
  if (debug && (debugHinges || debugTopHinge)) {
    maleHinge();
  } else {
    union() {
      translate([-femaleHingeInnerRadius, 0, hingeHeight]) rotate([0, 90, 0]) maleHinge();
      topMain();
    }
  }
}

module femaleHinge() {
  if (!debug || debugBottomHinge) {
      translate([-2, 0, 0]);
  }
  difference() {
    translate([0, hingeOffset, hingeHeight]) rotate([270, 0, 0]) cylinder(r=femaleHingeOuterRadius, h=hingeLength, center=false);
    union() {
      translate([0, hingeOffset, hingeHeight]) rotate([270, 0, 0]) cylinder(r=femaleHingeInnerRadius, h=hingeLength, center=false);
      translate([-1.5, hingeOffset+(hingeLength/2), hingeHeight]) hull() {
        cube([1, hingeLength, 3], center=true);
        translate([-3, 0, 0]) cube([1, hingeLength, 3], center=true);
      }
    }
  }
}

module maleHinge() {
  union() {
    // main part
    translate([0, hingeOffset, 0]) rotate([270, 0, 0]) cylinder(r=maleHingeRadius, h=hingeLength, center=false);

    // right handle 
    translate([0, hingeOffset-handleThickness, 0]) hull() {
      rotate([270, 0, 0]) cylinder(r=maleHingeRadius*0.8, h=2, center=false);
      translate([-handleLength, 0, 0]) cube(handleThickness, center=false);
    }
    
    // left handle
    translate([0, hingeOffset+hingeLength, 0]) hull() {
      rotate([270, 0, 0]) cylinder(r=maleHingeRadius*0.8, h=2, center=false);
      translate([-handleLength, 0, 0]) cube(handleThickness, center=false);
    }

    // support bar
    translate([-(femaleHingeOuterRadius+1), (hingeLength/2)+hingeOffset, 0]) cube([handleThickness, hingeLength, handleThickness], center=true);

    // connector
    translate([-handleLength, hingeOffset, 0]) cube([10, hingeLength, handleThickness+1]);
    
  }
}

module topMain() {

  // translate([-9, (backInnerLength/2), 0]) cube([3, backInnerLength-2, 1], center = true);

  difference() {
    translate([0, 0, lowerHeight]) cube([length, backOuterLength, heightDifference+wallThickness+topPartOffset], center=false);
    difference() {
      cube([length+wallThickness, backOuterLength, 100]);
      translate([0, 0, lowerHeight]) rotate([0, -atan(heightDifference/length), 0]) cube([100, backOuterLength, 50]);
    }
    translate([wallThickness, wallThickness, lowerHeight]) cube([length-wallThickness, backInnerLength, heightDifference+topPartOffset], center=false);
  }
  
}

module bottomMain() {
  if (!debug || !debugBottomHinge) {
    if (!debug || !debugBottom) {
      translate([0, 0, 0]);
    }

    difference() {
      cube([length, backOuterLength, upperHeight]);
      translate([2, 2, 2]) cube([length, backInnerLength, upperHeight]);
      translate([0, 0, lowerHeight]) rotate([0, -atan(heightDifference/length), 0]) cube([100, backOuterLength, 20]);
    }
  }
}

// }

