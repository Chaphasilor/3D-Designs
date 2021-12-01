// all configurable (and most calculated) variables are defined in this file


$fn = 16;

clampThickness = 0.4;
// clampRoundedness = 0.5;
clampRoundedness = 5;

clampPoints = [
  [-2, 8],
  [6, 8],
  [8, 0],
];
clampRadii = [
  [
    -1,
    fingerThicknessLeftRight *1/2 *2/3,
    clampRoundedness
  ],
  [
    0,
    fingerThicknessLeftRight/2,
    clampRoundedness
  ],
  [
    fingerThicknessTopBottom *2/3 *3/4,
    fingerThicknessLeftRight/2,
    clampRoundedness
  ],
  [
    fingerThicknessTopBottom *2/3 ,
    0,
    clampRoundedness
  ],
];
