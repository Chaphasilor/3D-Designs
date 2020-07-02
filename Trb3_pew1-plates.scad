// -------------- Measurements -----------------
plateWidth = 69.1;
plateHeight = 23.95;
plateThickness = 2;
coutersunkenBoltHoleDistanceSide = 2.3;
coutersunkenBoltHoleDiameter = 3.3;
countersunkenBoltHoleHeight = 1;
countersunkBoltHoleDiameterMin = coutersunkenBoltHoleDiameter;
countersunkBoltHoleDiameterMax = 5.7;

faceplateHoleEdgeLeft = 16;
faceplateHoleEdgeTop = 9.4;
faceplateHoleEdgeRight = 39;
faceplateHoleEdgeBottom = 6.3;

backplateHoleEdgeLeft = 15.5;
backplateHoleEdgeBottom = 6;
backplateHoleWidth = 20;
backplateHoleHeight = 10;
backplateHoleEarsWidth = 3.6;
backplateHoleEarsHeight = 3.3;
backplateHoleEarsDistanceLeft = 2;
backplateHoleEarsDistanceRight = backplateHoleEarsDistanceLeft;

// ------------------ Case --------------------- 

countersunkenBoltCenterDistanceLeftRight = coutersunkenBoltHoleDistanceSide + coutersunkenBoltHoleDiameter/2;
countersunkenBoltCenterDistanceTopBottom = plateHeight/2;

faceplateHoleWidth = plateWidth - (faceplateHoleEdgeLeft + faceplateHoleEdgeRight);
faceplateHoleHeight = plateHeight - (faceplateHoleEdgeTop + faceplateHoleEdgeBottom);

// ------------- Print Settings ----------------

faceplate = false;
$fn = 40;

// ---------------- Modules --------------------

module countersunkBoltHole() {
  union() {
    cylinder(d1=countersunkBoltHoleDiameterMax, d2=countersunkBoltHoleDiameterMin, h=countersunkenBoltHoleHeight, center = false);
    cylinder(d=coutersunkenBoltHoleDiameter, h=plateThickness, center = false);

  }
}

module faceplate() {

  difference() {
    // panel
    cube([plateWidth, plateHeight, plateThickness]);

    // hole

    translate([faceplateHoleEdgeLeft, faceplateHoleEdgeBottom, 0])
      cube([faceplateHoleWidth, faceplateHoleHeight, plateThickness], center=false);

    // countersunken bolt holes
    translate([countersunkenBoltCenterDistanceLeftRight, countersunkenBoltCenterDistanceTopBottom, plateThickness])
      rotate([180, 0, 0])
        countersunkBoltHole();
    translate([plateWidth - countersunkenBoltCenterDistanceLeftRight, countersunkenBoltCenterDistanceTopBottom, plateThickness])
      rotate([180, 0, 0])
        countersunkBoltHole();

  }

}

module backplate() {

  difference() {
    // panel
    cube([plateWidth, plateHeight, plateThickness]);

    // hole
    #translate([backplateHoleEdgeLeft, backplateHoleEdgeBottom, 0])
      cube([backplateHoleWidth, backplateHoleHeight, plateThickness], center=false);

    // "ears"
    #translate([backplateHoleEdgeLeft + backplateHoleEarsDistanceLeft, backplateHoleEdgeBottom + backplateHoleHeight, 0])
      cube([backplateHoleEarsWidth, backplateHoleEarsHeight, plateThickness], center=false);
    #translate([backplateHoleEdgeLeft + backplateHoleWidth - (backplateHoleEarsWidth + backplateHoleEarsDistanceRight), backplateHoleEdgeBottom + backplateHoleHeight, 0])
      cube([backplateHoleEarsWidth, backplateHoleEarsHeight, plateThickness], center=false);

    // countersunken bolt holes
    translate([countersunkenBoltCenterDistanceLeftRight, countersunkenBoltCenterDistanceTopBottom, plateThickness])
      rotate([180, 0, 0])
        countersunkBoltHole();
    translate([plateWidth - countersunkenBoltCenterDistanceLeftRight, countersunkenBoltCenterDistanceTopBottom, plateThickness])
      rotate([180, 0, 0])
        countersunkBoltHole();

  }

}


if (faceplate) {

  faceplate();

} else {

  backplate();

}