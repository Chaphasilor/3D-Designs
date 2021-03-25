include <config.scad>;
include <pcb.scad>;
include <shield.scad>;

// difference() {
  shield();

  translate([shieldThickness, 0, 0])
    pcb();
// }

//TODO move OpenSCAD custom library path and delete Chaph dir again