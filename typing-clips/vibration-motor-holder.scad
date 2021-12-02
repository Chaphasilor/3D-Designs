
module vibrationMotorHolder() {

  translate([0, -vibrationMotorHolderTotalDepth/2, vibrationMotorHolderTotalHeight/2])
    cylinder(d=vibrationMotorHolderTotalWidth,h=vibrationMotorHolderTotalHeight, center=true);
  
}


module vibrationMotorCableHolePuncher(punchHeight) {

  translate([0, -vibrationMotorHolderTotalDepth/2, vibrationMotorHolderTotalHeight/2])
  translate([0, 0, -(vibrationMotorHolderCutoutHeight/2 + punchHeight/2)]) {

      cylinder(d=vibrationMotorDiameter, h=vibrationMotorHolderCutoutHeight + punchHeight, center=true);

      translate([0, vibrationMotorHolderTotalDepth/2 - vibrationMotorDiameter/4, 0])
        cube([vibrationMotorCableWidth, vibrationMotorDiameter/2 * 1.5, vibrationMotorHolderCutoutHeight + punchHeight], center=true);

    }
  
}
