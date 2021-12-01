include <Round-Anything/polyround.scad>;

// MEASUREMENTS

// measured at the beginning of the finger nail
fingerThicknessLeftRight = 9; // [5:25]
fingerThicknessTopBottom = 6.5; // [5:25]

include <config.scad>;

module pointGuide(points) {

  for(point = points) {
    color("orange")
      translate([point.x, point.y, 0])
        cylinder(r=0.5, h=10, center=true);
  }
  #polygon(points);

}

module clamp() {

  polygon(polyRound(
    beamChain(
      mirrorPoints(
        clampRadii,
        0, 
        [0,1]
      ),
      clampThickness,
      -clampThickness
    )
  ));

}

clamp();
