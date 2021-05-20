include <wedge.scad>;

width = 5 + 128 + 5; // modified measurements
depth = 74;
thickness = 2;
wallThickness = 2;

sideBlockWidth = 3.75; // decreased block width without changing total width
sideBlockDepth = depth;
sideBlockThickness = 5.75;

wallHeight = sideBlockThickness;

overhangWidth = 8;
overhangDepth = depth;
overhangThickness = sideBlockThickness;
overhangAngle = 56;
overhangAngledSideWidth = sqrt(overhangThickness^2 + overhangWidth^2);

holeDiameter = 50;

edgeAngle = -30;

module pcb_cover() {

  difference() {
    union() {
      // main cover
      cube([width, depth, thickness]);

      // walls
      color("blue") {
      translate([0, -wallThickness, 0])
        cube([width, wallThickness, thickness + wallHeight]);
      translate([0, depth, 0])
        cube([width, wallThickness, thickness + wallHeight]);
      }
    }
    
    // hole puncher
    translate([width/2, depth/2, thickness])
      cylinder(d=holeDiameter, h=thickness*2, center=true);
  }

  // side blocks
  color("green")
  translate([0, 0, thickness]) {
    translate([0, 0, 0])
      difference() {
        cube([sideBlockWidth, sideBlockDepth, sideBlockThickness]);
        // translate([sideBlockWidth, 0, wallHeight-1])
        //   rotate([0, edgeAngle, 0])
        //     #cube([sideBlockWidth, sideBlockDepth, sideBlockThickness]);
      }
    translate([width - sideBlockWidth, 0, 0])
      cube([sideBlockWidth, sideBlockDepth, sideBlockThickness]);
  }

  // overhang
  // color("yellow")
  // translate([width - sideBlockWidth, overhangDepth, 2])
  //   rotate([90, 270, 0])
  //     wedge(overhangAngle, overhangThickness, overhangAngledSideWidth, overhangDepth);
  
}

pcb_cover();
