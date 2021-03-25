include <EPL_00_250_NTN.scad>;
// VARIABLES

// pcb
pcbLength = 160.0; // x
pcbWidth = 100; // y
pcbThickness = 1.6;

// shield
shieldMargin = 5;
shieldLength = pcbWidth - 2 * shieldMargin;
shieldHeight = 15;
shieldThickness = 1.5;

shieldMountingHoleDiameter = 2.5;
shieldMountingPlateWidth = 0.7 * (25.5 - 13.5 - EPL_00_250_NTN_baseSideLength);
shieldMountingPlateLength = 6.67 + shieldMountingHoleDiameter + 3;
shieldMountingPlateThickness = 3;

// positions

mountingHolePositions = [
  [
    6.67,
    -19.5,
    0,
  ],
  [
    6.67,
    -67.5,
    0,
  ],
];

lemoPositions = [
  [
    6.67,
    -13.5,
    0
  ],
  [
    6.67,
    -25.5,
    0
  ],
  [
    6.67,
    -37.5,
    0
  ],
  [
    6.67,
    -49.5,
    0
  ],
  [
    6.67,
    -61.5,
    0
  ],
  [
    6.67,
    -73.5,
    0
  ],
];

ledPosition = [
  6.10,
  -85.5,
  0
];

// hole punchers

// VARIABLES (CALCULATED)

// pcb
