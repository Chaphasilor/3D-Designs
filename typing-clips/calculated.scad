// all calculated values are defined in this file

// clip

clipMaxHeight = fingerThicknessTopBottom *2/3;

clipRadii = [
  [
    -2,
    fingerThicknessLeftRight *1/2 *3/4,
    clipRoundedness
  ],
  [
    0,
    fingerThicknessLeftRight/2,
    clipRoundedness
  ],
  [
    clipMaxHeight*3/4,
    fingerThicknessLeftRight/2,
    clipRoundedness
  ],
  [
    clipMaxHeight-0000.1,
    fingerThicknessLeftRight* 1/3,
    clipRoundedness
  ],
  [
    clipMaxHeight,
    0,
    clipRoundedness
  ],
];

// vibration motor
vibrationMotorHolderCutoutHeight = vibrationMotorThickness + vibrationMotorHolderFingerOffset;

vibrationMotorHolderTotalHeight = vibrationMotorHolderCutoutHeight + vibrationMotorHolderWallThickness;
vibrationMotorHolderTotalWidth = vibrationMotorDiameter + 2*vibrationMotorHolderWallThickness;
vibrationMotorHolderTotalDepth = vibrationMotorDiameter + 2*vibrationMotorHolderWallThickness;

