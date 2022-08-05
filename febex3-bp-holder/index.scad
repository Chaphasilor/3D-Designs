// ------- CONFIG --------

$fn = 30;
mode = "engineer"; // [engineer, print]
parts = "all"; // [all, bottom, top]

// everything is designed in a cartesian coordinate system, where X goes to the right (width), Y goes to the back (depth), and Z goes to the top (height)
// depending on the orientation of parts, different terminology may be used

// "width" of the backplane (if the connector slots are vertical) (X)
bpWidth = 64; // [10:1:250]
// "height" of the backplane (if the connector slots are vertical) (Y)
bpDepth = 128.5; // [60:1:250]
// thickness of the backplane (Z)
bpHeight = 1.6; // [1:0.1:10]
// maximum edge padding of the backplane where no parts are placed
bpPadding = 2; // [0:0.1:20]
// minimum space required below the backplane for connectors, etc.
bpClearanceBottom = 10; // [0:0.1:50]

// thickness rim/padding around the backplane (X, Y)
bpFrameRimThickness = 5; // [1:0.1:10]
// screwhole diameter
bpFrameScrewDiameter = 4; // [1:0.1:10]
bpFrameScrewPadding = 5; // [1:0.1:10]

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
railDepth = 5; // [0:0.1:20]
railDepthExpansionFactor = 0.3; // [0:0.1:3]
// height of the guiding rails (Z)
railHeight = 85; // [0:1:100]
// how deep the slot should be recessed into the rail
railSlotDepth = 2; // [0:0.1:10]
// how thick the slot should be at its widest point
railSlotExpansionFactor = 1.5; // [1:0.1:2]


// add stilts?
stilts = true; // [true, false]
// stilt thickness in X and Y direction
stiltWidth = 7.5; // [1:1:50]
stiltWidthExpansionFactor = 0.5; // [0.1:0.1:3]
stiltTiltAngle = 3; // [0:0.1:30]
// stilt height (Z)
stiltHeight = 50; // [1:1:100]

// thickness of most walls
wallThickness = 2; // [2:0.1:10]

bpBottomCutouts = [
  [[0, 11, 0], [17, 27.5, -8]],
];

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

  upDistance = 40;
  module dummyBackplaneAligned() {
    right(backplaneFrameTopCutoutOffsetLeft - bpPadding)
    back(backplaneFrameTopCutoutOffsetLeft - bpPadding*0)
      dummyBackplane();
  }

  if (parts == "all" || parts == "top") {    

    if (parts == "all") {
      up(upDistance - 1.6)
        dummyBackplaneAligned();
      up(upDistance)
        topPart();
    } else {
      down(1.6)
        dummyBackplaneAligned();
      topPart();
    }
  }

  if (parts == "all" || parts == "bottom") {
    bottomPart();
  }

}

module layout_print() {

  if (parts == "top") {
    topPart();
  } else if (parts == "bottom") {
    bottomPart();
  } else if (parts == "all") {
    topPart();
    right(backplaneFrameTopOuterWidth + 10)
      bottomPart();
  }

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
  up(backplaneFrameTopThickness) {
    right(railOffsetLeft)
      rails();

    if (stilts) {
      stilts();
    }
  }

}

module bottomPart() {

  backplaneFrameBottom();
  
}

module backplaneFrameTop() {

  difference() {
    // cuboid([backplaneFrameTopOuterWidth, backplaneFrameTopOuterDepth, backplaneFrameTopThickness], anchor=BOTTOM+FRONT+LEFT);
    zrot(90)
      sparse_wall(h=backplaneFrameTopOuterDepth, l=backplaneFrameTopOuterWidth, thick=backplaneFrameTopThickness, strut=5, maxang=75, orient=RIGHT, anchor=RIGHT+BACK+BOTTOM);


    right(backplaneFrameTopCutoutOffsetLeft)
    back(backplaneFrameTopCutoutOffsetFrontAdjusted)
      cuboid([backplaneFrameTopCutoutWidth, backplaneFrameTopCutoutDepthAdjusted, backplaneFrameTopThickness], anchor=BOTTOM+FRONT+LEFT);

    #backplaneFrameHolePuncher(height=backplaneFrameTopThickness);
  }

  // add solid region below rails
  back(backplaneFrameTopCutoutOffsetFrontAdjusted/2)
    backplaneFrameTopSolidRegion();
  back(backplaneFrameTopCutoutOffsetBack)
    backplaneFrameTopSolidRegion();
  
}
module backplaneFrameBottom() {

  difference() {
    union() {
      difference() {
        // cuboid([backplaneFrameBottomOuterWidth, backplaneFrameBottomOuterDepth, backplaneFrameBottomThickness], anchor=BOTTOM+FRONT+LEFT);
        union() {
          zrot(90)
            sparse_wall(h=backplaneFrameBottomOuterDepth, l=backplaneFrameBottomOuterWidth, thick=backplaneFrameBottomThickness, strut=4, maxang=75, orient=RIGHT, anchor=RIGHT+BACK+BOTTOM);
          right(bpFrameRimThicknessAdjusted) back(bpFrameRimThicknessAdjusted)
            cuboid([backplaneFrameBottomCutoutWidth + 2*bpPadding, backplaneFrameBottomCutoutDepth + 2*bpPadding, backplaneFrameBottomThickness], anchor=BOTTOM+FRONT+LEFT);
        }

        up(backplaneFrameBottomInnerOffsetBottom)
        right(bpFrameRimThicknessAdjusted) back(bpFrameRimThicknessAdjusted)
          cuboid([backplaneFrameBottomInnerWidth, backplaneFrameBottomInnerDepth, bpHeight], anchor=BOTTOM+FRONT+LEFT);

        right(bpFrameRimThicknessAdjusted + bpPadding) back(bpFrameRimThicknessAdjusted + bpPadding)
          cuboid([backplaneFrameBottomCutoutWidth, backplaneFrameBottomCutoutDepth, backplaneFrameBottomThickness], anchor=BOTTOM+FRONT+LEFT);

      }
      backplaneFrameHoles(height=backplaneFrameBottomThickness);
    }

    up(backplaneFrameBottomInnerOffsetBottom)
    right(bpFrameRimThicknessAdjusted)
    back(bpFrameRimThicknessAdjusted)
    #for (cutout=bpBottomCutouts) {
      cuboid(p1=cutout[0], p2=cutout[1], anchor=TOP+FRONT+LEFT);
    }
  }
    
}

module backplaneFrameHolePuncher(height) {

  module screw() {cylinder(d=bpFrameScrewDiameter, h=height);}

  for (offset=screwOffsets) {
    right(offset[0]) back(offset[1])
      screw();
  }
  
}
module backplaneFrameHoles(height) {

  screwFillerSize = bpFrameScrewDiameter + 2*bpFrameScrewPadding;
  for (offset=screwOffsets) {

    difference() {
      right(offset[0]) back(offset[1])
        cylinder(d=screwFillerSize, h=height, anchor=BOTTOM+CENTER);

      backplaneFrameHolePuncher(height);
    }

  }
  
}
module backplaneFrameTopSolidRegion() {
  right(backplaneFrameTopCutoutOffsetLeft)
    cuboid([backplaneFrameTopCutoutWidth, backplaneFrameTopCutoutOffsetFrontAdjusted/2, backplaneFrameTopThickness], anchor=BOTTOM+FRONT+LEFT);
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

  module frameOuter() {
    prismoid(size1=[railWidth, railDepthBottom], size2=[railWidth, railDepth], h=railHeight, shift=railShift, anchor=BOTTOM+FRONT+LEFT);
  }
  module frameInner() {
    up(railFrameInnerOffset)
    back(railFrameInnerOffset)
    prismoid(size1=[railWidth, railDepthBottom-railFrameInnerDifferenceBottom], size2=[railWidth, railDepth-railFrameInnerDifferenceTop], h=railHeight-railFrameInnerDifferenceHeight, shift=railShift, anchor=BOTTOM+FRONT+LEFT);
  }
  module railWedge() {
    union() {
      difference() {
        frameOuter();
        frameInner();
      }
      difference() {
        frameOuter();
        difference() {
          frameOuter();
          sparse_wall(h=railHeight, l=railDepthBottom, thick=railWidth, strut=3, orient=UP, anchor=BOTTOM+FRONT+LEFT);
        }
      }

    }
  }

  module railsUnpositioned() {
    back(railEdgeOffsetFront) 
    difference() {
      union() {
        back(railDepthBottom - railDepth)
        left(railWallOffsetLeft)
        zrot(90)
          sparse_wall(h=railHeight, l=railWallWidth, thick=railDepth, strut=3, orient=UP, anchor=BOTTOM+BACK+LEFT);
        
        for (i=[0:railCount]) {
          right(i* connectorDistance - railRelativeOffset)
            railWedge();
        }

      }

      for (i=[0:railCount]) {
        right(i* connectorDistance - railRelativeOffset)
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

module stilts() {

    prismoid(size1=[stiltWidth,stiltWidth], size2=[stiltWidthTop,stiltWidthTop], h=stiltHeight, shift=stiltShiftTop, anchor=BOTTOM+FRONT+LEFT);

  xflip(x=stiltsXFlipLocation)
    prismoid(size1=[stiltWidth,stiltWidth], size2=[stiltWidthTop,stiltWidthTop], h=stiltHeight, shift=stiltShiftTop, anchor=BOTTOM+FRONT+LEFT);

  xflip(x=stiltsXFlipLocation)
  yflip(y=stiltsYFlipLocation)
    prismoid(size1=[stiltWidth,stiltWidth], size2=[stiltWidthTop,stiltWidthTop], h=stiltHeight, shift=stiltShiftTop, anchor=BOTTOM+FRONT+LEFT);

  yflip(y=stiltsYFlipLocation)
    prismoid(size1=[stiltWidth,stiltWidth], size2=[stiltWidthTop,stiltWidthTop], h=stiltHeight, shift=stiltShiftTop, anchor=BOTTOM+FRONT+LEFT);
  
}
