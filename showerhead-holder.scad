$fn = 60;

plateWidth = 50;
plateHeight = 90;
plateThickness = 3.2;
pinDiameter = 10;
pinBottomStopDiameter = 14;
pinLength = 20;
pinMargin = 8.5;
pinAngle = -3;

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
      up(plateThickness) {
        cyl(d1=pinDiameter, d2=pinDiameter*0.95, h=length, chamfer2=2, anchor=BOTTOM+BACK, orient=BACK);
        // bottom stop
        down((pinBottomStopDiameter-pinDiameter)/2)
        cyl(d=pinBottomStopDiameter, h=2, chamfer2=0.5, anchor=BOTTOM+BACK, orient=BACK);
      }
    }
    
    module connector() {
        
      radiiPoints=[
        // [3,-10,4],
        [0,-16,0],
        [0,5,0.1],
        [4.5,-5,7],
        [pinMargin,-1.75,0.2],
        [pinMargin+pinDiameter-1,-1.75,0.2],
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
        front_half(y=1)
          pin(pinLength);
  
      back_half(y=-3)
      top_half(z=pinMargin+plateThickness)
        connector();
    }
    connector();
    
    bottom_half(z=plateThickness)
    down(plateThickness)
    xscale(2.5, cp=[0, 0, 0])
    yscale(2.5, cp=[0, -pinLength/2, 0])
    zscale(1, cp=[0, 0, 0])
    bounding_box()
      connector();

  }

  // fwd(plateWidth/2)
    pinAttached();
  
}
main();
