type = "left"; // [left, right]
mountWidth = 7 + 9;
mountDepth = 6;
mountHeight = 135;
sideWallDepth = 20;
sideWallThickness = 3;
basePlateWidth = mountWidth;
basePlateDepth = 40;
basePlateThickness = 20;

holeDiameter = 8;
holePositionX = 7;
holePositionsY = [37.5, 50, 82, 94, 125.5];

module poland_rack_mount() {

  cube([basePlateWidth, basePlateDepth, basePlateThickness]);

  difference() {
    translate([0, 0, basePlateThickness]) {

      cube([mountWidth, mountDepth, mountHeight]);

      translate([mountWidth, mountDepth, 0])
      rotate([0, -90, 0])
        linear_extrude(sideWallThickness)
          polygon([
            [0, 0],
            [0, sideWallDepth],
            [mountHeight, 0]
          ]);

    }

    #hole_puncher();
  }

}

module hole_puncher() {

  translate([holePositionX, 0, 0]) {

    for (holePosY=holePositionsY) {
      translate([0, mountDepth/2, holePosY])
      rotate([90, 0, 0])
        #cylinder(d=holeDiameter, h=mountDepth, center=true);
    }
  
  }
  
}

if (type == "left") {
  mirror([1, 0, 0]) {
    poland_rack_mount();
  }
} else {
  poland_rack_mount();
}

