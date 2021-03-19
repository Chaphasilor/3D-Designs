$fn=30;
include <EPL_00_250_NTN.scad>;
include <Kingbright_L_1503CB_1GD.scad>;

module pcb() {

  difference() {
    
    translate([0, -pcbWidth, 0])
      cube([pcbLength, pcbWidth, pcbThickness]);

  }

  translate([0, 0, pcbThickness]) {

    for (lemoPosition = lemoPositions) {
      translate(lemoPosition)
        color("yellow")
          rotate([0, 0, 180])
            scale(1.1) EPL_00_250_NTN();
    }

    translate(ledPosition)
    color("green")
      scale(1.1) Kingbright_L_1503CB_1GD();

  }
  
}

module hole_puncher_lemo() {
  
  for (holePosition = EPL_00_250_NTN_pinPositions) {
    translate(holePosition)
      cylinder(d=EPL_00_250_NTN_pinDiameter, h=pcbThickness*1.5, center=false);
  }

}
