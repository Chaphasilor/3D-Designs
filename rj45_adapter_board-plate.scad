// -------------- Measurements -----------------
plateWidth = 32;
plateHeight = 29;
plateThickness = 2;

holeDistanceTop = 11;
holeDistanceSides = 1.8;
holeDiameter = 4;

// ------------------ Computed --------------------- 

holeDistanceBottom = plateHeight - (holeDistanceTop + holeDiameter/2);
holeDistanceLeft = holeDistanceSides + holeDiameter/2;
holeDistanceRight = plateWidth - (holeDistanceSides + holeDiameter/2);

echo(str("holeDistanceLeft: ", holeDistanceLeft));
echo(str("holeDistanceRight: ", holeDistanceRight));
echo(str("holeDistanceBottom: ", holeDistanceBottom));

// ------------- Print Settings ----------------

faceplate = false;
$fn = 40;

// ---------------- Modules --------------------

module hole() {
  cylinder(d=holeDiameter, h=plateThickness, center = false);
}

module plate() {

  difference() {
    // panel
    cube([plateWidth, plateHeight, plateThickness]);

    // holes
    translate([holeDistanceLeft, holeDistanceBottom, 0])
      hole();
    translate([holeDistanceRight, holeDistanceBottom, 0])
      hole();

  }

}

plate();