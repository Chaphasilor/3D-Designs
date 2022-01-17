module sensorHolder() {
// !
  translate([0, -(fingerNailLength - clipThickness), clipMaxHeight])
  translate([-fingerThicknessLeftRight/4, 0, 0])
  rotate([-120, 0, 0])
  rotate([0, 270, 180])
    translate([+(clipMaxHeight+clipThickness), 0, 0]) {
      linear_extrude(fingerThicknessLeftRight/2) {
        translate([-(clipMaxHeight+clipThickness), 0, 0])
        polygon(polyRound(
          beamChain(
            sensorRadii,
            0,
            -sensorHolderThickness
          )
        ));
      }
    }

}
