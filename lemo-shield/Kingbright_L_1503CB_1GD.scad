// https://www.arrow.com/en/products/l-1503cb1gd/kingbright

// Variables

Kingbright_L_1503CB_1GD_baseLength = 9.2;
Kingbright_L_1503CB_1GD_baseWidth = 6;
Kingbright_L_1503CB_1GD_baseHeight = 6;
Kingbright_L_1503CB_1GD_ledLength = 4;
Kingbright_L_1503CB_1GD_ledWidth = 5;
Kingbright_L_1503CB_1GD_ledHeight = 5;
Kingbright_L_1503CB_1GD_ledMargin = (Kingbright_L_1503CB_1GD_baseHeight - Kingbright_L_1503CB_1GD_ledHeight) / 2;
Kingbright_L_1503CB_1GD_pinCenterDistance = 2.54; // the distance between two pins on one axis, from center to center
Kingbright_L_1503CB_1GD_pinMarginSide = (Kingbright_L_1503CB_1GD_baseWidth - Kingbright_L_1503CB_1GD_pinCenterDistance) / 2;
Kingbright_L_1503CB_1GD_pinMarginFront = 5.75;
Kingbright_L_1503CB_1GD_pinDiameter = 0.5;
Kingbright_L_1503CB_1GD_pinLength = 3.5;

// Variables (calculated)

Kingbright_L_1503CB_1GD_pinPositions = [
  [
    Kingbright_L_1503CB_1GD_pinMarginFront,
    Kingbright_L_1503CB_1GD_pinMarginSide,
    0
  ],
  [
    Kingbright_L_1503CB_1GD_pinMarginFront,
    Kingbright_L_1503CB_1GD_baseWidth - Kingbright_L_1503CB_1GD_pinMarginSide,
    0
  ],
];

module Kingbright_L_1503CB_1GD() {

  translate([-Kingbright_L_1503CB_1GD_pinMarginFront, -Kingbright_L_1503CB_1GD_baseWidth/2, -Kingbright_L_1503CB_1GD_pinLength]) {

    union() {
      for (pos = Kingbright_L_1503CB_1GD_pinPositions) {
        translate(pos)
          cylinder(d=Kingbright_L_1503CB_1GD_pinDiameter, h=Kingbright_L_1503CB_1GD_pinLength, center=false);
      }
    }

    translate([0, 0, Kingbright_L_1503CB_1GD_pinLength]) {

      cube([Kingbright_L_1503CB_1GD_baseLength, Kingbright_L_1503CB_1GD_baseWidth, Kingbright_L_1503CB_1GD_baseHeight]);

      translate([-Kingbright_L_1503CB_1GD_ledLength, Kingbright_L_1503CB_1GD_ledWidth / 2, Kingbright_L_1503CB_1GD_ledHeight / 2])
        rotate([0, 90, 0])
          cylinder(d=Kingbright_L_1503CB_1GD_ledWidth, h=Kingbright_L_1503CB_1GD_ledLength, center=false);
      
    }

  }
  
}

// rotate([0, 0, 180])
  // Kingbright_L_1503CB_1GD();