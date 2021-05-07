include <wedge.scad>;

width = 5 + 129 + 5;
depth = 74;
thickness = 2;
wallThickness = 2;
wallHeight = 3;

sideBlockWidth = 5;
sideBlockDepth = depth;
sideBlockThickness = 5.15;

overhangWidth = 5.8;
overhangDepth = depth;
overhangThickness = sideBlockThickness;
// overhangAngle = 56;
overhangAngle = 50;
overhangAngledSideWidth = sqrt(overhangThickness^2 + overhangWidth^2);

holeDiameter = 50;

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
      cube([sideBlockWidth, sideBlockDepth, sideBlockThickness]);
    translate([width - sideBlockWidth, 0, 0])
      cube([sideBlockWidth, sideBlockDepth, sideBlockThickness]);
  }

  // overhang
  color("yellow")
  translate([width - sideBlockWidth, overhangDepth, 2])
    rotate([90, 270, 0])
      wedge(overhangAngle, overhangThickness, overhangAngledSideWidth, overhangDepth);
  
}

pcb_cover();
