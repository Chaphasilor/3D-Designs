include <roundedcube.scad>;

module vibrationMotorHolder() {

  translate([0, -vibrationMotorHolderTotalDepth/2, vibrationMotorHolderTotalHeight/2 - clipThickness/2]) {
      cylinder(d=vibrationMotorHolderTotalWidth,h=vibrationMotorHolderTotalHeight + clipThickness, center=true);

      magnetHolder();
  }

}


module vibrationMotorCableHolePuncher(punchHeight) {

  translate([0, -vibrationMotorHolderTotalDepth/2, -punchHeight]) {

      cylinder(d=vibrationMotorDiameter, h=(vibrationMotorHolderCutoutHeight + punchHeight), center=false);

      translate([-vibrationMotorCableWidth/2, 0 , 0])
        cube([vibrationMotorCableWidth, vibrationMotorDiameter/2 * 1.5, vibrationMotorHolderCutoutHeight + punchHeight], center=false);

    }
  
}

module magnetHolder() {

  magnetHolderWallThickness = clipFinWallThickness/2;
  magnetHolderWidth = clipFinInsetHeight + 2*magnetHolderWallThickness;
  magnetHolderDepth = magnetHolderWallThickness + clipFinInsetWidth;
  magnetHolderHeight = clipFinInsetDepth;

  translate([0, 0, vibrationMotorHolderTotalHeight - magnetHolderHeight/2])
  difference() {
    roundedcube([magnetHolderWidth, magnetHolderDepth, magnetHolderHeight],true, 0.3, "zmax");

    translate([0, magnetHolderWallThickness/2, 0])
      cube([clipFinInsetHeight, clipFinInsetWidth, clipFinInsetDepth], center=true);
  }

}
