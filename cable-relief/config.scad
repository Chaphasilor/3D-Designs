// VARIABLES

// connector
connectorWidth = 67.5;
connectorHeight = 16.5;
connectorRimDepth = 1.5;
holeDiameter = 3.5;
holePaddingBottom = 6.75;
holePaddingSide = 1.5;
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
casingBottomThickness = 1.5;
casingWallThickness = 1.5;
lipHolePadding = 1.5;
screwLipWidth = 3; // the added diameter

// casing/cable
// cableDiameter = 22.6;
cableDiameter = 58/PI;
strippedCableLength = 55;
cableLength = 28; // just a reference part of the cable
squeezeMargin = 1.85;
lidScrewHoleDiameter = 2.8;
lidScrewHoleNutDiameter = 6.5;
lidScrewHoleDepth = 18;
lidScrewHolePadding = 2.5;
lidScrewHoleOffset = 2;
lidScrewEarThickness = 3;

// lid
lidThickness = 3.5;
lidInsetDepth = 0;
teethOffset = 0;
teethLength = 2.5;
// teethWidth = 10;
teethWidth = cableDiameter*0.95;
teethHeight = 2;



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
casingClampOffset = casingWidth/2 - cableDiameter/2 - casingBottomThickness;
casingWallHeight = cableDiameter + max(casingRailWallThickness, casingBottomThickness) - squeezeMargin;

lidAngle = casingRailWallThickness < casingBottomThickness ?
  atan((cableDiameter - squeezeMargin - connectorHeight) / strippedCableLength)
  :
  atan((cableDiameter - squeezeMargin - connectorHeight + (casingBottomThickness - casingRailWallThickness)) / strippedCableLength);

lidLength = sqrt(pow(cableDiameter - (casingBottomThickness + connectorHeight), 2) + pow(strippedCableLength, 2));
casingWallOffset = paddingBackSideLarger + casingRailWallThickness - casingWallThickness;

lidScrewEarWidth = lidScrewHoleDiameter + lidScrewHolePadding*2;
lidScrewEarAngle = atan(lidScrewEarWidth / casingWallHeight);

casingRadii = [
  [0, casingWallOffset, 0],
  [strippedCableLength*0.2, casingClampOffset*0.35, 5],
  [strippedCableLength*0.3, casingClampOffset*0.5, 100],
  [strippedCableLength*0.7, casingClampOffset*0.9, 100],
  [strippedCableLength, casingClampOffset, 0],
  [strippedCableLength, casingClampOffset + cableDiameter + casingBottomThickness*2, 0],
  [strippedCableLength*0.7, casingClampOffset + cableDiameter + casingBottomThickness*2 + casingClampOffset*0.1, 100],
  [strippedCableLength*0.3, casingClampOffset + cableDiameter + casingBottomThickness*2 + casingClampOffset*0.5, 100],
  [strippedCableLength*0.2, casingClampOffset + cableDiameter + casingBottomThickness*2 + casingClampOffset*0.65, 5],
  [0, casingWidth - casingWallOffset, 0]
];

casingWallRadii = [
  [0, casingWallOffset, 0],
  [strippedCableLength*0.2, casingClampOffset*0.35, 5],
  [strippedCableLength*0.3, casingClampOffset*0.5, 100],
  [strippedCableLength*0.7, casingClampOffset*0.9, 100],
  [strippedCableLength, casingClampOffset, 0],
];

lidScrewEarRadii = [
  [0, 0, 0],
  [0, casingWallHeight, 0],
  [lidScrewEarWidth + lidScrewHoleOffset, casingWallHeight, 1.5],
  [lidScrewEarWidth + lidScrewHoleOffset, casingWallHeight - lidScrewEarThickness, 1.5],
  [(lidScrewEarWidth + lidScrewHoleOffset)*0.6, (casingWallHeight - lidScrewEarThickness)*0.85, 5],
  [(lidScrewEarWidth + lidScrewHoleOffset)*0.4, (casingWallHeight - lidScrewEarThickness)*0.7, 5],
  [(lidScrewEarWidth + lidScrewHoleOffset)*0.25, (casingWallHeight - lidScrewEarThickness)*0.5, 10],
  [casingWallThickness, 0, 2.5]
];

lidScrewEarInnerRadii = [
  [lidScrewEarWidth + lidScrewHoleOffset, casingWallHeight - lidScrewEarThickness, 1.5],
  [(lidScrewEarWidth + lidScrewHoleOffset)*0.5, (casingWallHeight - lidScrewEarThickness)*1, 2],
  [(lidScrewEarWidth + lidScrewHoleOffset)*0.25, (casingWallHeight - lidScrewEarThickness)*0.95, 2.5],
  [(lidScrewEarWidth + lidScrewHoleOffset)*0.2, (casingWallHeight - lidScrewEarThickness)*0.75, 10],
  [casingWallThickness, 0, 2.5]
];