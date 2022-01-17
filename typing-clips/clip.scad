
module clip() {

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
  clipFins();

}

module clipFins() {

  // clipFinWallThickness
  // clipFinInsetWidth
  // clipFinInsetHeight
  // clipFinInsetDepth
  
  clipFinLength = clipFinInsetWidth + clipFinWallThickness;
  clipFinHeight = clipFinInsetHeight + 2*clipFinWallThickness;
  clipFinDepth = clipFinWallThickness + clipFinInsetDepth;
  
  module fin() {

    translate([fingerThicknessLeftRight/2, 0, 0])
      difference() {
        cube([clipFinDepth, clipFinLength, clipFinHeight]);

        translate([clipFinWallThickness, 0, clipFinWallThickness])
          cube([clipFinInsetDepth, clipFinInsetWidth, clipFinInsetHeight]);
      }

  }
  
  fin();
  mirror([1, 0, 0]) fin();
  
}

module clipInnerHolePuncher() {

  rotate([0, 270, 90])
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
  
}

module clipOuterHolePuncher() {

  translate([0, -(fingerNailLength + clipMaxHeight), 0])
    rotate([0, 90, 0])
    cylinder(r=clipMaxHeight*1.5, h=fingerThicknessLeftRight + sensorWidth + sensorHolderThickness + clipThickness*2, center=true);
  
}
