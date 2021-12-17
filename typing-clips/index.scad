include <Round-Anything/polyround.scad>;

// ------- CONFIG --------

$fn = 30;
mode = "engineer"; // [engineer, print]

// clip

// measured at the beginning of the finger nail
fingerThicknessLeftRight = 14.5; // [5:0.1:25]
fingerThicknessTopBottom = 10; // [5:0.1:25]
fingerNailLength = 13; // [7:0.5:25]

clipThickness = 1; // [0.1:0.1:5]
clipRoundedness = 5; // [0:25]
clipScaleX = 0.75; // [0:0.05:1]
clipScaleY = 0.75; // [0:0.05:1]

// vibration motor

vibrationMotorDiameter = 10.5; // [2:0.1:25]
vibrationMotorThickness = 2.5; // [1:0.1:7]
vibrationMotorCableWidth = 3; // [0.5:0.1:7]

vibrationMotorHolderWallThickness = 0.6; // [0.1:0.1:5]
vibrationMotorHolderFingerOffset = -0.7; // [-2.5:0.1:0]

// tactile domes

tactileDomesPart = "holder"; // [holder, traces]

tactileDomeHolderWallThickness = 1; // [0:0.1:10]
tactileDomeHolderWallHeight = 2; // [0:0.1:10]
tactileDomeHolderWallInsetX = 0; // [0:0.1:10]
tactileDomeHolderWallInsetY = 2.2; // [0:0.1:10]

tactileDomeInnerContactDiameter = 5.08; // [0:0.01:20]
tactileDomeKeepOutDiameter = 11.43; // [0:0.01:20]
tactileDomeOuterContactDiameter = 12.4; // [0:0.01:20]

tactileDomeTraceDistance = 5; // [0:0.5:20]
tactileDomeLayerHeight = 0.4; // [0.01:0.01:2]
tactileDomeLayerOffset = 3; // [3:15]
tactileDomeBottomLayers = 2; // [0:15]

// -----------------------

include <calculated.scad>;
include <clip.scad>;
include <vibration-motor-holder.scad>;
include <tactile-domes.scad>;

module pointGuide(points) {

  for(point = points) {
    color("orange")
      translate([point.x, point.y, 0])
        cylinder(r=0.5, h=10, center=true);
  }
  #polygon(points);

}

echo("vibrationMotorHolderTotalWidth: ", vibrationMotorHolderTotalWidth);

module engineer() {

  if (tactileDomesPart == "holder") {
    tactileDomeHolder(tactileDomeHolderWallThickness, tactileDomeHolderWallHeight, tactileDomeHolderWallInsetX, tactileDomeHolderWallInsetY, tactileDomeOuterContactDiameter, tactileDomeOuterContactThickness, tactileDomeInnerContactDiameter, tactileDomeTraceDistance, tactileDomeLayerHeight, tactileDomeBottomLayers, tactileDomeLayerOffset);
  } else {
    tactileDomeTraces(tactileDomeOuterContactDiameter, tactileDomeOuterContactThickness, tactileDomeInnerContactDiameter, tactileDomeTraceDistance + tactileDomeHolderWallThickness, tactileDomeLayerHeight, tactileDomeBottomLayers, tactileDomeLayerOffset);
  }

  // difference() {
  //   union() {
  //     color("olive")
  //       clip();
  //     color("orange")
  //       translate([0, 0, clipMaxHeight])
  //         vibrationMotorHolder();
  //   }

  //   #clipInnerHolePuncher();
  //   clipOuterHolePuncher();
  //   #translate([0, 0, clipMaxHeight])
  //     vibrationMotorCableHolePuncher(clipMaxHeight/2);
  // }

}

module print() {

  rotate([270, 0, 0])
    difference() {
      union() {
        color("olive")
          clip();
        color("orange")
          translate([0, 0, clipMaxHeight])
            vibrationMotorHolder();
      }
      
      clipInnerHolePuncher();
      clipOuterHolePuncher();
      translate([0, 0, clipMaxHeight])
        vibrationMotorCableHolePuncher(clipMaxHeight/2);
    }

}

if (mode == "print") {
  print();
} else {
  engineer();
}
