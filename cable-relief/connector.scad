include <Round-Anything/polyround.scad>;
include <Round-Anything/MinkowskiRound.scad>;

include <./config.scad>

module connector() {

  translate([0, 0, -(contactsDepth + protrusionDepthBack)]) {
    
    translate([0, 0, (contactsDepth + protrusionDepthBack)])
      difference() {
        polygon(points = polyRound(rimPointsRadii, 5));

        translate([holePaddingSideCentered, holePaddingBottomCentered, 0])
          cylinder(d=holeDiameter, h=connectorRimDepth, center=true, $fn=20);
        translate([connectorWidth - holePaddingSideCentered, holePaddingBottomCentered, 0])
          cylinder(d=holeDiameter, h=connectorRimDepth, center=true, $fn=20);
        
      }
    
    color("green") {
      translate([paddingFrontSideLarger, paddingFrontBottom, (contactsDepth + protrusionDepthBack)])
        connector_protrusion_front();
    }
    color("yellow") {
      translate([paddingBackSideLarger, paddingBackBottom, contactsDepth])
        connector_protrusion_back();
    }

    color("red") {
      translate([paddingContactsSide, paddingContactsTopBottom, 0])
        connector_contacts();
    }
  
  }

}

module connector_protrusion_front() {

  linear_extrude(height = protrusionDepthFront, center = false, convexity = 1, slices = 20, scale = 1.0, $fn = 16) {

    polygon(points = polyRound(protrusionFrontPolygonRadii, 5));
    
  }
  
}

module connector_protrusion_back() {

  linear_extrude(height = protrusionDepthBack, center = false, convexity = 1, slices = 20, scale = 1.0, $fn = 16) {

    polygon(points = polyRound(protrusionBackPolygonRadii, 5));
    
  }
  
}

module connector_contacts() {

  linear_extrude(height = contactsDepth, center = false, convexity = 1, slices = 20, scale = 1.0, $fn = 16) {

    polygon(points = polyRound(connectorContactsRadii, 5));
    
  }
  
}