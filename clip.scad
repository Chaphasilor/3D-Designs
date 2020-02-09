$fn = 50;

union() {

  // base
  rotate([90, 0, -90])
    linear_extrude(height=2)
      circle(r=6);

  // loop hole
  rotate([90, 0, -90])
    translate([0, 0, 2*1+2])
      rotate([0, 90, 0])
        rotate_extrude(angle=360)
          translate([3, 0, 0])
            circle(r=1);
      
  // spine
  translate([0, -0.5, -3.5])
    hull() {
      translate([10, 0, 1])
        cube([2, 1, 5], center=false);
      cube([10, 1, 7], center=false);
    }

  // nose
  translate([12, -1, -2.5])
    cube([1.5, 2, 5], center=false);

  // sides
  translate([13, -1, -2.5])
    side();
  rotate([180, 0, 0])
    translate([13, -1, -2.5])
      side();

}

module side() {
  hull() {
      cylinder(r=0.5, h=5, center=false);
      translate([-5, -2.5, 0])
        cylinder(r=0.75, h=5, center=false);
      translate([-7, -3, 0])
        cylinder(r=0.75, h=5, center=false);
      translate([-10, -3, 0])
        cylinder(r=1, h=5, center=false);
    }
}