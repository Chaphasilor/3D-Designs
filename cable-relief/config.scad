// VARIABLES

// connector
connectorWidth = 68;
connectorHeight = 15.5;
connectorRimDepth = 1.5;
holeDiameter = 3.3;
holePaddingBottom = 6.45;
holePaddingSide = 1.45;
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

// relief
casingRailWallThickness = 1.5;
casingThickness = 1.5;
lipHolePadding = 1.5;
screwLipWidth = 2.5; // the added diameter

// casing/cable
// cableDiameter = 22.6;
cableDiameter = 58/PI;
strippedCableLength = 55;
cableLength = 20; // just a reference part of the cable
squeezeMargin = 2.5;




// VARIABLES (CALCULATED)

// connector
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

// relief
screwHoleDepth = protrusionDepthBack + contactsDepth;
casingDepth = casingRailWallThickness + connectorRimDepth + screwHoleDepth;
casingWidth = connectorWidth + 2*casingRailWallThickness;
lipHeightSide = holePaddingBottom - lipHolePadding;

// casing/cable
casingClampOffset = casingWidth/2 - cableDiameter/2 - casingThickness;
casingWallHeight = cableDiameter;
lidAngle = atan((casingWallHeight - squeezeMargin - connectorHeight) / strippedCableLength);
lidLength = sqrt(pow(casingWallHeight - (casingThickness + connectorHeight), 2) + pow(strippedCableLength, 2));
casingWallOffset = paddingBackSideLarger + casingRailWallThickness - casingThickness;

casingRadii = [
  [0, casingWallOffset, 0],
  [strippedCableLength*0.2, casingClampOffset*0.35, 5],
  [strippedCableLength*0.3, casingClampOffset*0.5, 100],
  [strippedCableLength*0.7, casingClampOffset*0.9, 100],
  [strippedCableLength, casingClampOffset, 0],
  [strippedCableLength, casingClampOffset + cableDiameter + casingThickness*2, 0],
  [strippedCableLength*0.7, casingClampOffset + cableDiameter + casingThickness*2 + casingClampOffset*0.1, 100],
  [strippedCableLength*0.3, casingClampOffset + cableDiameter + casingThickness*2 + casingClampOffset*0.5, 100],
  [strippedCableLength*0.2, casingClampOffset + cableDiameter + casingThickness*2 + casingClampOffset*0.65, 5],
  [0, casingWidth - casingWallOffset, 0]
];

casingWallRadii = [
  [0, casingWallOffset, 0],
  [strippedCableLength*0.2, casingClampOffset*0.35, 5],
  [strippedCableLength*0.3, casingClampOffset*0.5, 100],
  [strippedCableLength*0.7, casingClampOffset*0.9, 100],
  [strippedCableLength, casingClampOffset, 0],
];