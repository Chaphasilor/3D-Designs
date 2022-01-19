
module clip(roundedJoin=false) {

  module clipPart() {
    rotate([0, 270, 90])
      translate([+(clipMaxHeight+clipThickness), 0, 0]) {
        linear_extrude(fingerNailLength, scale=[clipScaleX, clipScaleY]) {
          translate([-(clipMaxHeight+clipThickness), 0, 0])
          polygon(polyRound(
            beamChain(
              mirrorPoints(
                clipRadii,
                0, 
                [0,1]
              ),
              0,
              -clipThickness
            )
          ));
        }
      }
  }

  module finPart() {
    rotate([0, fingerRotation, 0])
      translate([-clipFinOffset, 0, 0])
        clipFins();
  }

  if (roundedJoin) {
    unionRoundMask(r=2) {
      clipPart();
      difference() {
        finPart();

        rotate([0, fingerRotation, 0])
          translate([-clipFinOffset, 0, 0])
            clipFinHolePuncher();
      }
    }
  } else {
    clipPart();
    difference() {
      finPart();

      rotate([0, fingerRotation, 0])
        translate([-clipFinOffset, 0, 0])
          clipFinHolePuncher();
    }
  }

}

module clipFins() {

  // clipFinWallThickness
  // clipFinInsetWidth
  // clipFinInsetHeight
  // clipFinInsetDepth
  
  clipFinLength = clipFinInsetWidth + clipFinWallThickness;
  clipFinHeight = clipFinInsetHeight + 2*clipFinWallThickness;
  clipFinDepth = clipFinWallThickness + clipFinInsetDepth;
  clipFinDistance = fingerThicknessLeftRight + clipFinDistanceOffset;
  
  module fin() {

    translate([clipFinDistance/2, 0, 0])
      cube([clipFinDepth, clipFinLength, clipFinHeight]);

  }
  
  fin();
  mirror([1, 0, 0]) fin();
  
}

module clipFinHolePuncher() {

  clipFinLength = clipFinInsetWidth + clipFinWallThickness;
  clipFinHeight = clipFinInsetHeight + 2*clipFinWallThickness;
  clipFinDepth = clipFinWallThickness + clipFinInsetDepth;

  module puncher() {
    translate([fingerThicknessLeftRight/2, 0, 0])
      translate([clipFinWallThickness, -2, clipFinWallThickness])
        cube([clipFinInsetDepth, clipFinInsetWidth + 2, clipFinInsetHeight]);
  }

  puncher();
  mirror([1, 0, 0]) puncher();

}

module clipInnerHolePuncher() {

  rotate([0, 270, 90]) {

    // front part (scaled to fit)
    translate([+(clipMaxHeight+clipThickness), 0, 0])
      linear_extrude(fingerNailLength, scale=[clipScaleX, clipScaleY]) {
        translate([-(clipMaxHeight+clipThickness), 0, 0])
        polygon(polyRound(
          beamChain(
            mirrorPoints(
              clipRadii,
              0, 
              [0,1]
            ),
            clipThickness*2,
            0
          )
        ));
      }

    // extended back part (not scaled)
    translate([+(clipMaxHeight+clipThickness), 0, -fingerNailLength])
      linear_extrude(fingerNailLength, scale=[1, 1]) {
        translate([-(clipMaxHeight+clipThickness), 0, 0])
        polygon(polyRound(
          beamChain(
            mirrorPoints(
              clipRadii,
              0, 
              [0,1]
            ),
            clipThickness*2,
            0
          )
        ));
      }
  }
  
}

module clipOuterHolePuncher() {

  translate([0, -(fingerNailLength + clipMaxHeight), -clipMaxHeight*0.6])
    rotate([0, 0, 10])
    rotate([0, 90, 0])
    cylinder(r=clipMaxHeight*2, h=fingerThicknessLeftRight + sensorWidth + sensorHolderThickness + clipThickness*2, center=true);
  
}

module clipChannelHolePuncher() {
#
  rotate([0, fingerRotation, 0])
  translate([0, -fingerNailLength/2, -fingerThicknessLeftRight/2])
    rotate([90, 0, 0])
    cylinder(d=fingerThicknessLeftRight, h=fingerNailLength, center=true);
  
}
