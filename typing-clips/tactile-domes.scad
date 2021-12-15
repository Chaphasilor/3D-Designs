module tactileDomeTraces(outerContactDiameter, outerContactThickness, innerContactDiameter, traceDistance, layerHeight, layerOffset = 3) {

  traceThickness = 1;

  translate([0, 0, (layerOffset-1) * layerHeight])
    linear_extrude(layerHeight)
      difference() {
        circle(d=outerContactDiameter);

        circle(d=outerContactDiameter-outerContactThickness*2);
      }

  linear_extrude(layerOffset * layerHeight)
    circle(d=innerContactDiameter);

  // trace for inner contact
  translate([0, 0, 0])
  color("orange")
  union() {

    square1Length = outerContactDiameter/2 + traceDistance + innerContactDiameter/2;

    linear_extrude(layerHeight) {

      translate([-(square1Length/2 - innerContactDiameter/2), 0, 0])
        square(size=[square1Length, traceThickness], center=true);
      translate([traceThickness/2 - square1Length + innerContactDiameter/2, 3/2 - traceThickness/2, 0])
        square(size=[traceThickness, 3*traceThickness], center=true);
    }
    linear_extrude(layerOffset * layerHeight)
      translate([traceThickness/2 - square1Length + innerContactDiameter/2, 3*traceThickness - traceThickness, 0])
        square(size=[traceThickness, traceThickness], center=true);

  }

  // trace for outer contact
  // translate([0, 0, 5])
  color("yellow")
  union() {

    square1Length = traceDistance/2 + outerContactThickness;
    square2Length = traceDistance/2;

    translate([-(outerContactDiameter/2 - outerContactThickness), 0, (layerOffset-1) * layerHeight]) {

      linear_extrude(layerHeight) {

        translate([-(square1Length/2 - traceThickness/2), 0, 0])
          square(size=[square1Length - traceThickness, traceThickness], center=true);
        translate([-(square1Length - traceThickness/2), -traceThickness, 0])
          square(size=[traceThickness, 3*traceThickness], center=true);
        translate([-(square2Length/2 + square1Length), -2, 0])
          square(size=[square2Length, traceThickness], center=true);
      }

    }

  }
  
}

module tactileDomeHolder(wallThickness, wallHeight, outerContactDiameter, outerContactThickness, innerContactDiameter, traceDistance, layerHeight, layerOffset = 3) {

  newTraceDistance = traceDistance + wallThickness;

  difference() {
    union() {
      
      translate([-newTraceDistance/2 - wallThickness/2, 0, (layerOffset * layerHeight)/2])
        cube(size=[outerContactDiameter + newTraceDistance + wallThickness, outerContactDiameter, layerOffset * layerHeight], center=true);

      translate([0, 0, (layerOffset * layerHeight + wallHeight)/2])
      difference() {
        cube(size=[outerContactDiameter + 2*wallThickness, outerContactDiameter + 2*wallThickness, (layerOffset * layerHeight) + wallHeight], center=true);

        cube(size=[outerContactDiameter, outerContactDiameter, (layerOffset * layerHeight) + wallHeight], center=true);
      }

    }

    #tactileDomeTraces(outerContactDiameter, outerContactThickness, innerContactDiameter, newTraceDistance, layerHeight, layerOffset);
  }
  
}
