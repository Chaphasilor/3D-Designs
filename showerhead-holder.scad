$fn = 60;

plateWidth = 50;
plateHeight = 90;
plateThickness = 1.6;
pinDiameter = 9.5;
pinLength = 15;
pinMargin = 8.5;
pinAngle = 10;

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
        [pinMargin-1,-1.75,0.2],
        [pinMargin+pinDiameter-2,-3.25,0.2],
        [10,-10,10]
      ];
      // !
      up(plateThickness)
      right(pinDiameter/2)
      yrot(-90)
      linear_extrude(pinDiameter)
        polygon(polyRound(radiiPoints,30));
    }
    
    xrot(pinAngle, cp=[0,pinDiameter/2,pinMargin+plateThickness])
      pin(pinLength+3);
    hull() {
      xrot(pinAngle, cp=[0,pinDiameter/2,pinMargin+plateThickness])
        front_half(y=pinLength/2-5)
          pin(pinLength);
      front_half(y=-(pinLength/2-3))
      back_half(y=-6)
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
