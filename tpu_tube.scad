
module tube(length, innerDiameter, wallThickness) {

  difference() {

    cylinder(d=innerDiameter + 2*wallThickness, h=length, center=true);
    cylinder(d=innerDiameter, h=length, center=true);
    
  }

}