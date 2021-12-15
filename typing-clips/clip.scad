
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
