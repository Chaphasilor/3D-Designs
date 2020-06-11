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

innerDiameterMount = diameterYellowThick + 0.5; // the mount ring diameter
widthMount = lengthYellowThick; // the width of the mount ring
lengthMountLip = 2; // how far the lip reaches into the gap
thicknessMountLip = 1.5; // how thick the lip should be (depends on size of gap)
angleMount = 180; // how far the mount should reach around the button

widthBridge = widthMount; // the width of the bridge connecting mount and protector
heightBridge = 8; // the height of the bridge connecting mount and protector
lengthBridge = diameterYellowThick * 2; // the length of the bridge connecting mount and protector
widthSuspends = widthBridge; // the width of the supports suspending the protector below the mount
lengthSuspends = diameterRedLip * 1.1; // the length of the supports suspending the protector below the mount

protectorPertrudeLength = 3;
lengthProtector = lengthTotal - lengthYellowThick + protectorPertrudeLength;
caveInProtector = 10;
sideWidthProtector = 5;

// ------------ Print Settings --------------

print = true;
printButton = false;
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

  mount();
    protector();
  
}

module mount() {

  color("#70B0FF") {
    rotate([0, 0, -(angleMount-180)/2]) rotate_extrude(angle=angleMount) // enable variable angle compared to cylinder difference
      translate([innerDiameterMount/2, 0, 0]) // move the shape to get the correct inner diameter
        difference() { // make the inside of the mount flat to improve stability
          union() {
            circle(d=widthMount);
            translate([-lengthMountLip, -(widthMount/2 - thicknessMountLip), 0])
              rotate([180, 0, 0])
                square([lengthMountLip, thicknessMountLip], center=false);
          }

          translate([-widthMount, -widthMount/2 + thicknessMountLip, 0]) // position the flat part on the inside
            square([widthMount, widthMount-thicknessMountLip], center=false);
          translate([-lengthMountLip, widthMount/2, 0]) // position the flat part on the inside
            rotate([180, 180])
              square([innerDiameterMount/2, widthMount], center=false);
        }
  }
  
}

module roundedCorner() {
  translate([-(lengthBridge/2 - heightBridge/2), innerDiameterMount/2+widthMount-heightBridge/2, 0,])
    difference() {
      cylinder(d=heightBridge*2, h=widthBridge*2, center=true);
      cylinder(d=heightBridge, h=widthBridge*2, center=true);
      translate([heightBridge, 0, 0])
        cube([heightBridge*2, heightBridge*2, heightBridge*2], center=true);
      translate([0, -heightBridge, 0])
        cube([heightBridge*2, heightBridge*2, heightBridge*2], center=true);
    }
};

function getCaveInCylinderHeight () = (lengthBridge/2 - sideWidthProtector);

module protector() {

  translate([0, 0, 0.5+thicknessMountLip]) {

    // bridge & suspends
    color("#1D1D1D") {
      union() {
        difference() {
          translate([-lengthBridge/2, innerDiameterMount/2, -heightBridge/2])
            cube([lengthBridge, heightBridge, widthBridge], center=false);

          // cylinder(d=(innerDiameterMount+widthMount+heightBridge)*1.25, h=widthBridge*2, center=true);
          translate([0, 1, 0])
            roundedCorner();

          translate([0, 1, 0])
            rotate([0, 0, -90])
              roundedCorner();
        }
          
        translate([lengthBridge/2, innerDiameterMount/2, -heightBridge/2])
          rotate([180, 180, 0])
            cube([widthSuspends, lengthSuspends, widthBridge], center=false);
        translate([-lengthBridge/2, innerDiameterMount/2, -heightBridge/2])
          rotate([180, 270, 0])
            cube([widthSuspends, lengthSuspends, widthBridge], center=false);

        translate([lengthBridge/2, innerDiameterMount/2-lengthSuspends, -heightBridge/2])
          rotate([270, 180, 0])
          cube([lengthBridge, widthBridge, heightBridge], center=false);
      }
    }

    color("#50D050") {

      difference() {

        hull() {

          translate([lengthBridge/2, innerDiameterMount/2-lengthSuspends, -heightBridge/2 + widthBridge])
            rotate([270, 180, 0])
              cube([widthBridge, lengthProtector, heightBridge], center=false);
              
          // translate([0, innerDiameterMount/2-lengthSuspends, -heightBridge/2 + widthBridge + lengthProtector - caveInProtector - 1])
          //   rotate([90, 0, 180])
          //     cylinder(d=1, h=widthBridge, center=false);
          
          translate([widthBridge-lengthBridge/2, innerDiameterMount/2-lengthSuspends, -heightBridge/2 + widthBridge])
            rotate([270, 180, 0])
              cube([widthBridge, lengthProtector, heightBridge], center=false);

        }

        // cave in
        translate([0, innerDiameterMount/2-lengthSuspends, -heightBridge/2 + widthBridge + lengthProtector + 0])
          rotate([90, 0, 180])
            cylinder(r=(lengthBridge/2 - sideWidthProtector), h=heightBridge, center=false);
          
      }

    }
    
  }
  
}

function calcHyp(a, b) = sqrt(pow(a, 2) + pow(b, 2));

if (print) {

  if (printButton) {
    translate([0, 0, lengthTotal]) // move the rotated button up so that it rests on the x-y-plane 
      rotate([180, 0, 0]) // rotate the button so the tickest part is at the bottom
        emergencyButton();
  } else {

    addon();
    
  }

} else {

  if (preview) {

    rotate([0, 90, 0])
      buttonWithWall();

  } else {

    emergencyButton();
    translate([0, 0, widthMount/2-thicknessMountLip]) addon();
    
  }
  
}
