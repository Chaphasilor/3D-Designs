// https://www.digikey.com/en/products/detail//EPL.00.250.NTN/2786110

// Variables

EPL_00_250_NTN_baseSideLength = 7;
EPL_00_250_NTN_baseHeight = 7;
EPL_00_250_NTN_fullLength = 17.5;
EPL_00_250_NTN_roundPartLength = EPL_00_250_NTN_fullLength - EPL_00_250_NTN_baseSideLength;
EPL_00_250_NTN_roundPartDiameter = 6.8;
EPL_00_250_NTN_roundPartMargin = (EPL_00_250_NTN_baseSideLength - EPL_00_250_NTN_roundPartDiameter) / 2;
EPL_00_250_NTN_outerPinCenterDistance = 5.08; // the distance between two pins on one axis, from center to center
EPL_00_250_NTN_outerPinMargin = (EPL_00_250_NTN_baseSideLength - EPL_00_250_NTN_outerPinCenterDistance) / 2;
EPL_00_250_NTN_innerPinMargin = EPL_00_250_NTN_baseSideLength / 2;
EPL_00_250_NTN_pinDiameter = 0.7;
EPL_00_250_NTN_pinLength = 3;

// Variables (calculated)

EPL_00_250_NTN_pinPositions = [
  [
    EPL_00_250_NTN_outerPinMargin,
    EPL_00_250_NTN_outerPinMargin,
    0
  ],
  [
    EPL_00_250_NTN_baseSideLength - EPL_00_250_NTN_outerPinMargin,
    EPL_00_250_NTN_outerPinMargin,
    0
  ],
  [
    EPL_00_250_NTN_outerPinMargin,
    EPL_00_250_NTN_baseSideLength - EPL_00_250_NTN_outerPinMargin,
    0
  ],
  [
    EPL_00_250_NTN_baseSideLength - EPL_00_250_NTN_outerPinMargin,
    EPL_00_250_NTN_baseSideLength - EPL_00_250_NTN_outerPinMargin,
    0
  ],
  [
    EPL_00_250_NTN_innerPinMargin,
    EPL_00_250_NTN_innerPinMargin,
    0
  ],
];

module EPL_00_250_NTN() {

  translate([-EPL_00_250_NTN_baseSideLength/2, -EPL_00_250_NTN_baseSideLength/2, -EPL_00_250_NTN_pinLength]) {

    union() {
      for (pos = EPL_00_250_NTN_pinPositions) {
        translate(pos)
          cylinder(d=EPL_00_250_NTN_pinDiameter, h=EPL_00_250_NTN_pinLength, center=false);
      }
    }

    translate([0, 0, EPL_00_250_NTN_pinLength]) {

      cube([EPL_00_250_NTN_baseSideLength, EPL_00_250_NTN_baseSideLength, EPL_00_250_NTN_baseHeight]);

      translate([EPL_00_250_NTN_baseSideLength, EPL_00_250_NTN_baseSideLength / 2, EPL_00_250_NTN_baseSideLength / 2])
        rotate([0, 90, 0])
          cylinder(d=EPL_00_250_NTN_roundPartDiameter, h=EPL_00_250_NTN_roundPartLength, center=false);
      
    }

  }
  
}

// rotate([0, 0, 180])
//   EPL_00_250_NTN();