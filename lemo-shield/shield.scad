include <config.scad>;
include <Round-Anything/polyround.scad>

module shield() {

  translate([0, -(shieldLength + shieldMargin), 0])
    cube([shieldThickness, shieldLength, shieldHeight]);


    difference() {

      // shieldMountingPlates
      for (holePosition = mountingHolePositions) {
        color("blue")
          translate([shieldThickness, 0, pcbThickness]) {

            translate([0, holePosition.y - shieldMountingPlateWidth/2, holePosition.z])
              cube([shieldMountingPlateLength, shieldMountingPlateWidth, shieldMountingPlateThickness]);

            translate([0, holePosition.y + shieldMountingPlateWidth/2, shieldMountingPlateThickness])
              rotate([90, 0, 0])
                linear_extrude(height = shieldMountingPlateWidth, center = false, convexity = 1, slices = 20, scale = 1.0, $fn = 16) {
                  polygon(points = polyRound(shieldMountingPlateRoundedRadii, 5));
                }

          }
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