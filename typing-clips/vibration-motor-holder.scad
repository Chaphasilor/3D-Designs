
module vibrationMotorHolder() {

  translate([0, -vibrationMotorHolderTotalDepth/2, vibrationMotorHolderTotalHeight/2])
    cylinder(d=vibrationMotorHolderTotalWidth,h=vibrationMotorHolderTotalHeight, center=true);
  
}


module vibrationMotorCableHolePuncher(punchHeight) {

  translate([0, -vibrationMotorHolderTotalDepth/2, -punchHeight]) {

      cylinder(d=vibrationMotorDiameter, h=(vibrationMotorHolderCutoutHeight + punchHeight), center=false);

      translate([-vibrationMotorCableWidth/2, 0 , 0])
        cube([vibrationMotorCableWidth, vibrationMotorDiameter/2 * 1.5, vibrationMotorHolderCutoutHeight + punchHeight], center=false);

    }
  
}
