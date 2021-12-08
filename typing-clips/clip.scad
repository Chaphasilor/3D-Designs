
module clip() {

  rotate([0, 270, 90])
    translate([+(clipMaxHeight+clipThickness), 0, 0]) {
      linear_extrude(fingerNailLength, scale=[0.75, 0.75]) {
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
      linear_extrude(fingerNailLength, scale=[0.75, 0.75]) {
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
