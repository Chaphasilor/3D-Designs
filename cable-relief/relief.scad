include <./config.scad>

module lower_relief() {

  union() {

    // bottom side
    cube([casingDepth, connectorWidth + 2*casingRailWallThickness, casingThickness]);

    translate([0, 0, abs(casingThickness - casingRailWallThickness)]) {

      connector_lip();

      translate([casingRailWallThickness + connectorRimDepth, casingRailWallThickness, casingRailWallThickness])
        screw_hole();
      translate([casingRailWallThickness + connectorRimDepth, connectorWidth + casingRailWallThickness - paddingBackSideLarger, casingRailWallThickness])
        screw_hole();

    }

  }

}

module connector_lip() {

  difference() {

    union() {
      
      // front lip
      translate([0, 0, 0])
        cube([connectorRimDepth + casingRailWallThickness, connectorWidth + 2*casingRailWallThickness, casingRailWallThickness + paddingFrontBottom]);

      // side lips
      translate([0, 0, casingRailWallThickness]) {
        cube([casingRailWallThickness + connectorRimDepth + screwHoleDepth, 2*casingRailWallThickness, lipHeightSide]);
      }
      translate([0, connectorWidth, casingRailWallThickness]) {
        cube([casingRailWallThickness + connectorRimDepth + screwHoleDepth, 2*casingRailWallThickness, lipHeightSide]);
      }

    }

    translate([casingRailWallThickness, casingRailWallThickness, casingRailWallThickness])
      cube([casingRailWallThickness + connectorRimDepth + screwHoleDepth, connectorWidth, connectorHeight]);
    
  }
  
}

module screw_hole() {

  difference() {

    cube([screwHoleDepth, paddingBackSideLarger, connectorHeight]);

    translate([0, casingRailWallThickness + holePaddingSide, casingRailWallThickness + holePaddingBottom])
      rotate([0, 90, 0])
        cylinder(d=holeDiameter, h=protrusionDepthBack + contactsDepth, center = false, $fn = 20);

  }
  
}