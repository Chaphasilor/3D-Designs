include <Round-Anything/polyround.scad>;
include <Round-Anything/MinkowskiRound.scad>;

// connector variables
connectorWidth = 67;
connectorHeight = 15.5;
connectorRimDepth = 1;
holeDiameter = 3.2;
holePaddingBottom = 6.4;
holePaddingSide = 1.4;
protrusionDepthFront = 6.2;
protrusionDepthBack = 4;
paddingFrontTop = 2.2;
paddingFrontBottom = 2.2;
paddingBackTop = 0.7;
paddingBackBottom = 0.8;
paddingFrontSideSmaller = 8.2;
paddingFrontSideLarger = 7.1;
paddingBackSideSmaller = 7.5;
paddingBackSideLarger = 5.75;
contacsHeight = 7.2;
contacsWidth = 45.7;
contactsDepth = 3.3;
paddingContactsSide = 11;
paddingContactsTopBottom = 4.3;


// connector variables (calculated)
holePaddingBottomCentered = holePaddingBottom + holeDiameter/2;
holePaddingSideCentered = holePaddingSide + holeDiameter/2;

protrusionFrontWidthSmaller = connectorWidth - 2*paddingFrontSideSmaller;
protrusionFrontWidthLarger = connectorWidth - 2*paddingFrontSideLarger;
protrusionBackWidthSmaller = connectorWidth - 2*paddingBackSideSmaller;
protrusionBackWidthLarger = connectorWidth - 2*paddingBackSideLarger;
protrusionFrontWidthDifference = (protrusionFrontWidthLarger - protrusionFrontWidthSmaller)/2;
protrusionBackWidthDifference = (protrusionBackWidthLarger - protrusionBackWidthSmaller)/2;
protrusionFrontHeight = connectorHeight - (paddingFrontTop + paddingFrontBottom);
protrusionBackHeight = connectorHeight - (paddingBackTop + paddingBackBottom);

protrusionFrontPolygonRadii = [
  [0, protrusionFrontHeight, 0.5],
  [protrusionFrontWidthDifference, 0, 0.5],
  [protrusionFrontWidthDifference + protrusionFrontWidthSmaller, 0, 0.5],
  [protrusionFrontWidthLarger, protrusionFrontHeight, 0.5]
];

protrusionBackPolygonRadii = [
  [0, protrusionBackHeight, 0.5],
  [protrusionBackWidthDifference, 0, 0.5],
  [protrusionBackWidthDifference + protrusionBackWidthSmaller, 0, 0.5],
  [protrusionBackWidthLarger, protrusionBackHeight, 0.5]
];

connectorContactsRadii = [
  [0, contacsHeight, 0.5],
  [0, 0, 0.5],
  [contacsWidth, 0, 0.5],
  [contacsWidth, contacsHeight, 0.5]
];

rimPointsRadii = [
  [0, 0, 1.5],
  [connectorWidth, 0, 1.5],
  [connectorWidth, connectorHeight, 1.5],
  [0, connectorHeight, 1.5]
];

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