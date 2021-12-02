
module clip() {

  rotate([0, 270, 90])
    polyRoundExtrude(
      beamChain(
        mirrorPoints(
          clipRadii,
          0, 
          [0,1]
        ),
        0,
        -clipThickness
      ),
      fingerNailLength,
      0.25,
      0
    );

  // polygon(polyRound(
  //   beamChain(
  //     mirrorPoints(
  //       clipRadii,
  //       0, 
  //       [0,1]
  //     ),
  //     clipThickness,
  //     0
  //   )
  // ));

}
