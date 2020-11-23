include <Round-Anything/polyround.scad>;
include <Round-Anything/MinkowskiRound.scad>;

// connector variables
width = 77;
height = 15.5;
rimDepth = 1;
holeDiameter = 3.2;
holePaddingBottom = 6.4;
holePaddingSide = 1.4;
protrusionDepthFront = 6.2;
protrusionDepthBack = 4;
contactsDepth = 2.7;
paddingFrontTop = 2.2;
paddingFrontBottom = 2.2;
paddingBackTop = 0.7;
paddingBackBottom = 0.8;
paddingFrontSideSmaller = 8.2;
paddingFrontSideLarger = 7.1;
paddingBackSideSmaller = 7.5;
paddingBackSideLarger = 5.75;

// connector variables (calculated)
holePaddingBottomCentered = holePaddingBottom + holeDiameter/2;
holePaddingSideCentered = holePaddingSide + holeDiameter/2;

protrusionFrontWidthSmaller = width - 2*paddingFrontSideSmaller;
protrusionFrontWidthLarger = width - 2*paddingFrontSideLarger;
protrusionBackWidthSmaller = width - 2*paddingBackSideSmaller;
protrusionBackWidthLarger = width - 2*paddingBackSideLarger;
protrusionFrontWidthDifference = (protrusionFrontWidthLarger - protrusionFrontWidthSmaller)/2;
protrusionBackWidthDifference = (protrusionBackWidthLarger - protrusionBackWidthSmaller)/2;
protrusionFrontHeight = height - (paddingFrontTop + paddingFrontBottom);
protrusionBackHeight = height - (paddingBackTop + paddingBackBottom);

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

rimPointsRadii = [[0,0, 1.5], [width,0, 1.5], [width,height, 1.5], [0,height, 1.5]];

module connector() {
  
  translate([0, 0, protrusionDepthBack])
    difference() {
      polygon(points = polyRound(rimPointsRadii, 5));

      translate([holePaddingSideCentered, holePaddingBottomCentered, 0])
        cylinder(d=holeDiameter, h=rimDepth, center=true, $fn=20);
      translate([width - holePaddingSideCentered, holePaddingBottomCentered, 0])
        cylinder(d=holeDiameter, h=rimDepth, center=true, $fn=20);
      
    }
  
  color("green") {
    translate([paddingFrontSideLarger, paddingFrontBottom, protrusionDepthBack])
      connector_protrusion_front();
  }
  color("yellow") {
    translate([paddingBackSideLarger, paddingBackBottom, 0])
      connector_protrusion_back();
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

connector();