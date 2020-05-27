// ------------- Measurements Button -------------

diameterYellowThin = 27;
diameterYellowThick = 28.5;
diameterRedThin = 30;
diameterRedLip = 40;
gapWall = 1;
wallSize = 250;
wallThickness = 10;
lengthTotal = 40;
lengthYellow = 21;
lengthYellowThick = 7;
lengthYellowThin = lengthYellow - lengthYellowThick;
lengthRed = lengthTotal - lengthYellow;
lengthRedLip = 8.5;
lengthRedThin = lengthRed - lengthRedLip;

// ----------- Measurements Addon --------------

innerDiameterMount = diameterYellowThick + 0.5;
lengthMount = lengthYellowThick;
thicknessMount = 5;
angleMount = 180;

// ------------ Print Settings --------------

print = false;
printButton = true;
printAddon = false;
preview = false;

$fn = 100;

// ------------ Modules ---------------

module emergencyButton() {
  
  // yellow part
  color("yellow") {
    cylinder(r=diameterYellowThin/2, h=lengthYellow, center=false); // yellow thin part
    cylinder(r=diameterYellowThick/2, h=lengthYellowThick, center=false); // yellow thick part
  }
  // red (button) part
  translate([0, 0, lengthYellow]) color("red") {
    cylinder(r=diameterRedThin/2, h=lengthRed, center=false); // red thin part
    translate([0, 0, lengthRedThin]) cylinder(r=diameterRedLip/2, h=lengthRedLip, center=false); // red lip part
  }
  
};

module wall() {

  translate([-wallSize/2, -wallSize/2, 0]) // move the top left corner to center the wall
    cube(size=[wallSize, wallSize, wallThickness], center=false);

}

module buttonWithWall() {

  wall();
  translate([0, 0, wallThickness+gapWall]) // move button from the wall
    emergencyButton();
  
}

module addon() {

  color("#3D3D3D") {

    mount();
    
  }
  
}

module mount() {

  // difference() {

  //   cylinder(r=innerDiameterMount/2 + thicknessMount, h=lengthMount, center=false);
  //   cylinder(r=innerDiameterMount/2, h=lengthMount, center=false);

  // }

  rotate_extrude(angle=180) // enable variable angle compared to cylinder difference
    translate([innerDiameterMount/2, 0, 0]) // move the shape to get the correct inner diameter
      difference() { // make the inside of the mount flat to improve stability
        circle(d=thicknessMount);

        translate([-thicknessMount, -thicknessMount/2, 0]) // position the flat part on the inside
          square(size=thicknessMount, center=false);
      }
  
}

if (print) {

  if (printButton) {
    translate([0, 0, lengthTotal]) // move the rotated button up so that it rests on the x-y-plane 
      rotate([180, 0, 0]) // rotate the button so the tickest part is at the bottom
        emergencyButton();
  }

} else {

  if (preview) {

    rotate([0, 90, 0])
      buttonWithWall();

  } else {

    // emergencyButton();
    addon();
    
  }
  
}
