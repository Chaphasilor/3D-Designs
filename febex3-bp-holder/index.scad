// ------- CONFIG --------

$fn = 30;
mode = "engineer"; // [engineer, print]

// everything is designed in a cartesian coordinate system, where X goes to the right (width), Y goes to the back (depth), and Z goes to the top (height)
// depending on the orientation of parts, different terminology may be used

// "width" of the backplane (if the connector slots are vertical) (X)
bpWidth = 64; // [10:1:250]
// "height" of the backplane (if the connector slots are vertical) (Y)
bpDepth = 128.5; // [60:1:250]
// thickness of the backplane (Z)
bpHeight = 1.6; // [1:0.1:10]
// maximum edge padding of the backplane where no parts are placed
bpPadding = 3; // [0:0.1:20]

// thickness rim/padding around the backplane (X, Y)
bpFrameRimThickness = 10; // [1:0.1:10]
// screwhole diameter
bpFrameScrewDiameter = 3; // [1:0.1:10]

// outer width of the whole connector (if the connector slots are vertical)
connectorWidth = 9; // [1:0.1:15]
// outer height of the whole connector (if the connector slots are vertical)
connectorDepth = 56; // [10:0.1:100]
// distance between left edge of the backplane and the left edge of the left-most connector
connectorLeftOffset = 6.4; // [0:0.1:50]
// distance between bottom edge of the backplane and the bottom edge of the connectors
connectorBottomOffset = 0; // [0:0.1:50]
// distance between right edge of a connector and the left edge of the next connector
connectorGap = 11.15; // [0.5:0.1:20]

// the depth of the PCBs that are inserted into the connector slots / backplane (Y)
insertedPcbDepth = 100; // [10:250]
// the front offset for the PCBs that are inserted into the connector slots / backplane (Y)
insertedPcbOffsetFront = 15; // [0:0.1:100]
// thickness of the PCBs that are inserted into the connector slots = width of the connector slot inside the connector
insertedPcbThickness = 1.8; // [0:0.1:7.5]

// width of the guiding rails (X)
railWidth = 10; // [0:0.1:10]
// depth of the guiding rails (Y)
railDepth = 7; // [0:0.1:20]
// height of the guiding rails (Z)
railHeight = 50; // [0:1:100]
// how deep the slot should be recessed into the rail
railSlotDepth = 2; // [0:0.1:10]
// how thick the slot should be at its widest point
railSlotExpansionFactor = 1.5; // [1:0.1:2]
//TODO slot thickness, wedge


// add stilts?
stilts = true; // [true, false]
// stilt thickness in X and Y direction
stiltWidth = 5; // [1:1:50]
// stilt height (Z)
stiltHeight = 30; // [1:1:100]

// thickness of most walls
wallThickness = 5; // [2:0.1:10]

// ------- CHECKS --------

// if (wallThickness < bpHeight + 1) {
//   wallThickness = bpHeight + 1;
//   echo(str("wall thickness was too low, set to minimum value ", wallThickness));
// }

// ------ INCLUDES -------

include <BOSL2/std.scad>
include <BOSL2/walls.scad>
include <calculated.scad>
include <helpers.scad>

module layout_exploded() {

  up(20 - 1.6)
  right(backplaneFrameTopCutoutOffsetLeft - bpPadding)
  back(backplaneFrameTopCutoutOffsetLeft - bpPadding*0)
    dummyBackplane();

  up(20)
    topPart();  
  bottomPart();

}

module layout_print() {

}

if (mode == "engineer") {
  layout_exploded();
} else if (mode == "print") {
  layout_print();
}

module topPart() {

  // backplane frame
  up()
    backplaneFrameTop();
  // rails
  up(backplaneFrameTopThickness)
  right(railOffsetLeft)
    rails();

}

module bottomPart() {

  backplaneFrameBottom();
  
}

module backplaneFrameTop() {

  difference() {
    cuboid([backplaneFrameTopOuterWidth, backplaneFrameTopOuterDepth, backplaneFrameTopThickness], anchor=BOTTOM+FRONT+LEFT);

    // cut out sparse wall
    back(backplaneFrameTopCutoutOffsetFrontAdjusted/2)
      backplaneFrameTopSparseHolePuncher();
    //TODO calculate the correct position
    back(backplaneFrameTopOuterDepth - backplaneFrameTopCutoutOffsetFrontAdjusted)
      backplaneFrameTopSparseHolePuncher();

    right(backplaneFrameTopCutoutOffsetLeft)
    back(backplaneFrameTopCutoutOffsetFrontAdjusted)
      cuboid([backplaneFrameTopCutoutWidth, backplaneFrameTopCutoutDepthAdjusted, backplaneFrameTopThickness], anchor=BOTTOM+FRONT+LEFT);

    #backplaneFrameTopHolePuncher();
  }
  
}
module backplaneFrameBottom() {

  difference() {
    cuboid([backplaneFrameBottomOuterWidth, backplaneFrameBottomOuterDepth, backplaneFrameBottomThickness], anchor=BOTTOM+FRONT+LEFT);

    up(wallThickness)
    right(bpFrameRimThickness) back(bpFrameRimThickness)
      cuboid([backplaneFrameBottomInnerWidth, backplaneFrameBottomInnerDepth, bpHeight], anchor=BOTTOM+FRONT+LEFT);

    right(2*bpFrameRimThickness) back(2*bpFrameRimThickness)
      cuboid([backplaneFrameBottomCutoutWidth, backplaneFrameBottomCutoutDepth, backplaneFrameBottomThickness], anchor=BOTTOM+FRONT+LEFT);

    #backplaneFrameBottomHolePuncher();
  }
  
}
module backplaneFrameBottomHolePuncher() {
  module screw() {cylinder(d=bpFrameScrewDiameter, h=backplaneFrameBottomThickness);}
  right(bpFrameRimThickness/2) back(bpFrameRimThickness/2)
    screw();
  right(backplaneFrameBottomOuterWidth - bpFrameRimThickness/2) back(bpFrameRimThickness/2)
    screw();
  right(bpFrameRimThickness/2) back(backplaneFrameBottomOuterDepth - bpFrameRimThickness/2)
    screw();
  right(backplaneFrameBottomOuterWidth - bpFrameRimThickness/2) back(backplaneFrameBottomOuterDepth - bpFrameRimThickness/2)
    screw();
}
module backplaneFrameTopSparseHolePuncher() {
  right(backplaneFrameTopCutoutOffsetLeft)
    difference() {
      cuboid([backplaneFrameTopCutoutWidth, backplaneFrameTopCutoutOffsetFrontAdjusted/2, backplaneFrameTopThickness], anchor=BOTTOM+FRONT+LEFT);
      zrot(90)
        sparse_wall(h=backplaneFrameTopCutoutOffsetFrontAdjusted/2, l=backplaneFrameTopCutoutWidth, thick=backplaneFrameTopThickness, strut=1.5, orient=RIGHT, anchor=RIGHT+BACK+BOTTOM);
    }
}
module backplaneFrameTopHolePuncher() {
  module screw() {cylinder(d=bpFrameScrewDiameter, h=backplaneFrameTopThickness);}
  right(bpFrameRimThickness/2) back(bpFrameRimThickness/2)
    screw();
  right(backplaneFrameBottomOuterWidth - bpFrameRimThickness/2) back(bpFrameRimThickness/2)
    screw();
  right(bpFrameRimThickness/2) back(backplaneFrameBottomOuterDepth - bpFrameRimThickness/2)
    screw();
  right(backplaneFrameBottomOuterWidth - bpFrameRimThickness/2) back(backplaneFrameBottomOuterDepth - bpFrameRimThickness/2)
    screw();
}

module rails() {

  back(railTotalOffsetFront)
  color("yellow") {
    
    railSide("top");
    railSide("bottom");

  }
  
}
module railSide(position) {

  echo(str("Variable = ", position));

  module railsUnpositioned() {
    back(railEdgeOffsetFront)
      for (i=[0:railCount]) {
        right(i* connectorDistance - railRelativeOffset)
          difference() {
            cuboid([railWidth, railDepth, railHeight], anchor=BOTTOM+FRONT+LEFT);
            
            right(railSlotOffsetLeft) back(railSlotOffsetFront)
            prismoid(size1=[railSlotOutsideThickness, railHeight], size2=[railSlotInsideThickness, railHeight], h=railSlotDepth, shift=[0, 0], anchor=BOTTOM+FRONT+RIGHT, orient=FRONT);
          }
      }
  }

  if (position == "top") {
    railsUnpositioned();
  } else if (position == "bottom") {
    back(insertedPcbDepth)
    yflip(y=railsYFlipLocation)
      railsUnpositioned();
  }

}
