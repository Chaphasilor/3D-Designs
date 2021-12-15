module sensorHolder() {

  rotate([0, 270, 90])
    translate([+(clipMaxHeight+clipThickness), 0, 0]) {
      linear_extrude(fingerNailLength, scale=[clipScaleX, 1]) {
        translate([-(clipMaxHeight+clipThickness), 0, 0])
        polygon(polyRound(
          beamChain(
            mirrorPoints(
              sensorRadii,
              0, 
              [0,1]
            ),
            0,
            -sensorHolderThickness
          )
        ));
      }
    }
  
}
