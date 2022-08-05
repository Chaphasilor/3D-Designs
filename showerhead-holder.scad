$fn = 60;

plateWidth = 50;
plateHeight = 90;
plateThickness = 1.6;
pinDiameter = 9.5;
pinLength = 15;
pinMargin = 8.5;

include <Round-Anything/polyround.scad>;
use <Round-Anything/unionRoundMask.scad>;
include <BOSL2/std.scad>
include <BOSL2/walls.scad>

module main() {
  
  difference() {
    cuboid([plateWidth, plateHeight, plateThickness], anchor=BOTTOM);

    up(plateThickness/2)
      cuboid([plateWidth, plateHeight, plateThickness/2], anchor=BOTTOM);
  }
  zrot(90)
    sparse_wall(h=plateHeight, l=plateWidth, thick=plateThickness, strut=2.5, maxang= 60, anchor=CENTER+CENTER+RIGHT, orient=RIGHT);

  module pinAttached() {

    module pin(length) {
      up(pinMargin)
      up(plateThickness)
        cyl(d1=pinDiameter, d2=pinDiameter*0.9, h=length, chamfer2=2, anchor=BOTTOM+BACK, orient=BACK);
    }
    
    module connector() {
        
      radiiPoints=[
        // [3,-10,4],
        [0,-16,0],
        [0,5,0.1],
        [4.5,-5,7],
        [pinMargin,0,0.2],
        [pinMargin+pinDiameter,0,0.2],
        [10,-10,10]
      ];
      // !
      up(plateThickness)
      right(pinDiameter/2)
      yrot(-90)
      linear_extrude(pinDiameter)
        polygon(polyRound(radiiPoints,30));
    }
    
    pin(pinLength+3);
    hull() {
      front_half(y=pinLength/2-5)
        pin(pinLength);
      back_half(y=-1)
      top_half(z=6)
        connector();
    }
    connector();
    
    bottom_half(z=plateThickness)
    down(plateThickness)
    back(6)
    scale([2.5, 1.5, 1])
    bounding_box()
      connector();

  }

  fwd(plateWidth/2)
    pinAttached();
  
}
main();
