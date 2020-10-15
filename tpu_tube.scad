$fn=100;

module tube(length, innerDiameter, wallThickness) {

  difference() {

    cylinder(d=innerDiameter + 2*wallThickness, h=length, center=false);
    cylinder(d=innerDiameter, h=length, center=false);
    
  }

}

tube(50, 4, .5);