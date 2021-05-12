// VARIABLES

pcbLength = 127.0;
pcbWidth = 76.2;
holeCenterDistanceSide = 5.6;
wallThickness = 2;
standoffThickness = 2;
clearanceBottom = 5.4;
clearanceTop = 27.2;
holeDiameter = 3.8;


// VARIABLES (CALCULATED)

// case (general)
caseLength = pcbLength + wallThickness*2;
caseWidth = pcbWidth + wallThickness*2;

// screw standoffs
screwStandoffOuterDiameter = holeDiameter + standoffThickness*2;

screwStandoffPosition1 = [
  wallThickness + holeCenterDistanceSide,
  wallThickness + holeCenterDistanceSide,
  wallThickness
];
screwStandoffPosition2 = [
  caseLength - (wallThickness + holeCenterDistanceSide),
  wallThickness +holeCenterDistanceSide,
  wallThickness
];
screwStandoffPosition3 = [
  caseLength - (wallThickness + holeCenterDistanceSide),
  caseWidth - (wallThickness + holeCenterDistanceSide),
  wallThickness
];
screwStandoffPosition4 = [
  wallThickness + holeCenterDistanceSide,
  caseWidth - (wallThickness + holeCenterDistanceSide),
  wallThickness
];

screwStandoffPositions = [
  screwStandoffPosition1,
  screwStandoffPosition2,
  screwStandoffPosition3,
  screwStandoffPosition4,
];
