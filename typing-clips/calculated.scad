// all calculated values are defined in this file

// clip

clipMaxHeight = fingerThicknessTopBottom *2/3;

clipRadii = [
  [
    -4.99,
    fingerThicknessLeftRight * 0.001,
    0
  ],
  [
    -5,
    fingerThicknessLeftRight * 0.1,
    clipRoundedness
  ],
  [
    -4,
    fingerThicknessLeftRight * 0.27,
    clipRoundedness
  ],
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
    clipMaxHeight*9/10,
    fingerThicknessLeftRight* 1/3,
    clipRoundedness
  ],
  [
    clipMaxHeight,
    0,
    clipRoundedness
  ],
];
clipNegativeScale = 1 - (clipThickness/2)/clipMaxHeight;

sensorRadii = [
  [
    -sensorThickness-2.5,
    -2 + sensorHolderZOffset,
    clipRoundedness
  ],
  [
    -sensorThickness-2.5,
    0 + sensorHolderZOffset,
    clipRoundedness
  ],
  [
    -sensorThickness/2-2.5,
    -0.00001 + sensorHolderZOffset,
    clipRoundedness
  ],
  [
    0-2.5,
    0 + sensorHolderZOffset,
    clipRoundedness
  ],
  [
    0.00001-2.5,
    -2 + sensorHolderZOffset,
    clipRoundedness
  ],
  [
    0,
    0,
    0
  ],
];

// vibration motor
vibrationMotorHolderCutoutHeight = vibrationMotorThickness + vibrationMotorHolderFingerOffset;

vibrationMotorHolderTotalHeight = vibrationMotorHolderCutoutHeight + vibrationMotorHolderWallThickness;
vibrationMotorHolderTotalWidth = vibrationMotorDiameter + 2*vibrationMotorHolderWallThickness;
vibrationMotorHolderTotalDepth = vibrationMotorDiameter + 2*vibrationMotorHolderWallThickness;

// tactile domes

tactileDomeOuterContactThickness = (tactileDomeOuterContactDiameter - tactileDomeKeepOutDiameter)/2;
