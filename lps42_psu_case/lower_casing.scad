include <config.scad>
$fn=30;

module lower_casing() {

  difference() {
    cuboid([caseLength, caseWidth, clearanceTop + wallThickness], rounding=5, except=[BOTTOM], trimcorners=false, anchor=BOTTOM+LEFT+FRONT);

    up(wallThickness) back(wallThickness) right(wallThickness)
      cuboid([caseLength - 2*wallThickness, caseWidth - 2*wallThickness, clearanceTop + wallThickness], anchor=BOTTOM+LEFT+FRONT);
  }
  // cube([caseLength, caseWidth, wallThickness]);

  // screw standoffs
  for (pos = screwStandoffPositions) {
    translate(pos)
      screw_standoff();
  }

  // translate([0, 0, wallThickness])
  // walls(clearanceTop);

  fwd(50) orient(LEFT)
  IEC_socket();
  
}

module screw_standoff() {

  difference() {

    cylinder(d=screwStandoffOuterDiameter, h=clearanceBottom, center=false);
    
    cylinder(d=holeDiameter, h=clearanceBottom, center = false);
    
  }
  
}

module IEC_socket() {
  // iec(IEC_fused_inlet2);
  iec_assembly(["custom IEC","IEC fused inlet old", M3_cs_cap_screw, 0, 27, 14, 31, 3, 28,   31,   2, 2.5, 33,   33, 4, 2.5, 34, 18, fused_spades, false ]);
}
