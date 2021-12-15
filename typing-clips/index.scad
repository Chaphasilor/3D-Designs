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

// sensor

sensorWidth = 18.4; // [10:0.1:30]
sensorThickness = 0.75; // [0:0.05:5]
sensorHolderThickness = 1; // [0:0.1:5]

// vibration motor

vibrationMotorDiameter = 10.5; // [2:0.1:25]
vibrationMotorThickness = 2.5; // [1:0.1:7]
vibrationMotorCableWidth = 3; // [0.5:0.1:7]

vibrationMotorHolderWallThickness = 0.6; // [0.1:0.1:5]
vibrationMotorHolderFingerOffset = -0.7; // [-2.5:0.1:0]

// -----------------------

include <calculated.scad>;
include <clip.scad>;
include <sensor-holder.scad>;
include <vibration-motor-holder.scad>;

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

  difference() {
    union() {
      color("olive")
        clip();
      color("orange")
        translate([0, 0, clipMaxHeight])
          vibrationMotorHolder();
      sensorHolder();
    }

    #clipInnerHolePuncher();
    #translate([0, 0, clipMaxHeight])
      vibrationMotorCableHolePuncher(clipMaxHeight/2);
  }

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
        sensorHolder();
      }
      
      clipInnerHolePuncher();
      translate([0, 0, clipMaxHeight])
        vibrationMotorCableHolePuncher(clipMaxHeight/2);
    }

}

if (mode == "print") {
  print();
} else {
  engineer();
}
