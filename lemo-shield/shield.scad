include <config.scad>;
include <Round-Anything/polyround.scad>

module shield() {

  translate([0, -(shieldLength + shieldMargin), 0])
    cube([shieldThickness, shieldLength, shieldHeight]);

    #polygon(polyRound([
      [0, 0, 0],
      [10,0, 1],
      [0, 10,0]
    ],10));

    difference() {

      // shieldMountingPlates
      for (holePosition = mountingHolePositions) {
        translate([shieldThickness, holePosition.y - shieldMountingPlateWidth/2, holePosition.z + pcbThickness])
            color("blue")
              cube([shieldMountingPlateLength, shieldMountingPlateWidth, shieldMountingPlateThickness]);
      }

      hole_puncher();

    }


}

module hole_puncher() {

  for (holePosition = mountingHolePositions) {
    translate([holePosition.x + shieldThickness, holePosition.y, holePosition.z + pcbThickness])
        color("blue")
          cylinder(d=shieldMountingHoleDiameter, h=shieldMountingPlateThickness*2);
  }
  
}