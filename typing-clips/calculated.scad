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
clipNegtiveScale = 1 - (clipThickness/2)/clipMaxHeight;

sensorRadii = [
  [
    -sensorThickness-2.5,
    sensorWidth/2-2,
    clipRoundedness
  ],
  [
    -sensorThickness-2.5,
    sensorWidth/2,
    clipRoundedness
  ],
  [
    -sensorThickness/2-2.5,
    sensorWidth/2-0.00001,
    clipRoundedness
  ],
  [
    0-2.5,
    sensorWidth/2,
    clipRoundedness
  ],
  [
    0.00001-2.5,
    sensorWidth/2-2,
    clipRoundedness
  ],
  [
    0,
    fingerThicknessLeftRight/2,
    0
  ],
  [
    clipMaxHeight*0.6,
    fingerThicknessLeftRight*1/3,
    0
  ],
  [
    clipMaxHeight*0.8,
    0,
    clipRoundedness
  ],
];

// vibration motor
vibrationMotorHolderCutoutHeight = vibrationMotorThickness + vibrationMotorHolderFingerOffset;

vibrationMotorHolderTotalHeight = vibrationMotorHolderCutoutHeight + vibrationMotorHolderWallThickness;
vibrationMotorHolderTotalWidth = vibrationMotorDiameter + 2*vibrationMotorHolderWallThickness;
vibrationMotorHolderTotalDepth = vibrationMotorDiameter + 2*vibrationMotorHolderWallThickness;

// tactile domes

tactileDomeOuterContactThickness = (tactileDomeOuterContactDiameter - tactileDomeKeepOutDiameter)/2;
