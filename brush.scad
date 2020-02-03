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
printBottom = true;
$fn = 75;

debug = false; // toggles stacked view/debugging
debugBottom = false;
debugHinges = false; // toggles only showing hinges
debugFemaleHinge = false;
debugMaleHinge = false;
offsetParts = true;

// render() {

// bottom part
if (!debug || (debug && (debugBottom || debugHinges))) {
  if ((!debug || !debugBottom) || (debug && !debugHinges)) {
    if (print) {
      if (printBottom) {
        translate([0, 0, length]) rotate([0, 90, 0]) bottomPart();
      }
    } else {
      bottomPart();
    }
  } else {
    bottomPart();
  }
}

// top part
if (!debug || (debug && (!debugBottom || debugHinges))) {
  if ((!debug || debugBottom) || (debug && !debugHinges)) {
    if (print) {
      if (!printBottom) {
        translate([-length*1, upperHeight*2, upperHeight+lowerHeight]) rotate([180, 0, 0]) topPart();
      }
    } else {
      if (!debug && offsetParts) {
        translate([0, 0, 1]) topPart();
      } else {
        topPart();
      }
    }
  } else {
    topPart();
  }
  
}

// ----- MODULES ------

module bottomPart() {
  if (debug && (debugHinges || debugFemaleHinge)) {
    translate([0, 0, -7]) femaleHinge();
  } else {
    union() {
      bottomMain();
      translate([-wallThickness, 0, 0]) femaleHinge();
    }
  }
}

module topPart() {
  if (debug && (debugHinges || debugMaleHinge)) {
    maleHinge();
  } else {
    union() {
      translate([-femaleHingeInnerRadius, 0, hingeHeight]) rotate([0, 90, 0]) maleHinge();
      topMain();
    }
  }
}

module femaleHinge() {
  if (!debug || debugFemaleHinge) {
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

    difference() {
      union() {
        // right handle 
        translate([0, hingeOffset-handleThickness, 0]) hull() {
          rotate([270, 0, 0]) cylinder(r=maleHingeRadius*0.8, h=handleThickness, center=false);
          translate([-handleLength, 0, handleThickness*0.5]) cube([handleThickness, handleThickness, handleThickness*0.5], center=false);
        }
        
        // left handle
        translate([0, hingeOffset+hingeLength, 0]) hull() {
          rotate([270, 0, 0]) cylinder(r=maleHingeRadius*0.8, h=handleThickness, center=false);
          translate([-handleLength, 0, handleThickness*0.5]) cube([handleThickness, handleThickness, handleThickness*0.5], center=false);
        }

        // connector
        translate([-2*handleLength, hingeOffset-handleThickness, -handleThickness]) cube([2*handleLength-(femaleHingeOuterRadius+1), hingeLength+2*handleThickness, 2*handleThickness+0.5]);
      }

      translate([0, 0, -(maleHingeRadius*0.8+5)]) rotate([0, -acos((maleHingeRadius*0.8 + (maleHingeRadius*0.8-handleThickness*0.4))/handleLength), 0]) cube([5, hingeLength+hingeOffset*2, 100]);
    }
    // support bar
    // translate([-(femaleHingeOuterRadius+1), (hingeLength/2)+hingeOffset, 0]) cube([handleThickness, hingeLength, handleThickness], center=true);
    
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
  if (!debug || !debugFemaleHinge) {
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

