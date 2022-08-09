// all calculated values are defined in this file

// stilts 1
stiltWidthTop = stiltWidth * stiltWidthExpansionFactor;

// backplane frame

screwOffsetDistance = stiltWidth + bpFrameScrewPadding;
bpFrameRimThicknessAdjusted = bpFrameRimThickness + screwOffsetDistance;

backplaneFrameBottomThickness = bpHeight + wallThickness;
backplaneFrameBottomOuterWidth = bpWidth + 2 * bpFrameRimThicknessAdjusted;
backplaneFrameBottomOuterDepth = bpDepth + 2 * bpFrameRimThicknessAdjusted;
backplaneFrameBottomInnerOffsetBottom = backplaneFrameBottomThickness - bpHeight;
backplaneFrameBottomInnerWidth = bpWidth;
backplaneFrameBottomInnerDepth = bpDepth;
backplaneFrameBottomCutoutWidth = bpWidth - 2 * bpPadding;
backplaneFrameBottomCutoutDepth = bpDepth - 2 * bpPadding;

maxFrameRimBpPadding = max(bpFrameRimThicknessAdjusted, bpPadding);
screwOffsets = [
  [screwOffsetDistance, screwOffsetDistance],
  [backplaneFrameBottomOuterWidth - screwOffsetDistance, screwOffsetDistance],
  [screwOffsetDistance, backplaneFrameBottomOuterDepth - screwOffsetDistance],
  [backplaneFrameBottomOuterWidth - screwOffsetDistance, backplaneFrameBottomOuterDepth - screwOffsetDistance],
];
// feet
feetDiameter = bpFrameScrewDiameter + 2*bpFrameScrewPadding;
feetHeight = bpClearanceBottom + backplaneFrameBottomThickness - wallThickness;
feetOffsetTop = feetHeight - backplaneFrameBottomThickness;

screwHoleHeightBottom = backplaneFrameBottomThickness + feetHeight;

backplaneFrameTopThickness = wallThickness;
backplaneFrameTopOuterWidth = bpWidth + 2 * maxFrameRimBpPadding;
backplaneFrameTopOuterDepth = bpDepth + 2 * maxFrameRimBpPadding;
backplaneFrameTopCutoutWidth = bpWidth - 2 * bpPadding;
backplaneFrameTopCutoutDepth = bpDepth - 2 * bpPadding;
backplaneFrameTopCutoutOffsetLeft = (backplaneFrameTopOuterWidth - backplaneFrameTopCutoutWidth) / 2;
backplaneFrameTopCutoutOffsetFront = (backplaneFrameTopOuterDepth - backplaneFrameTopCutoutDepth) / 2;

// stilts 2
stiltShiftHyp = stiltHeight / cos(stiltTiltAngle);
tiltShift = stiltShiftHyp * sin(stiltTiltAngle);
stiltShiftTop = [
  -(stiltWidth - stiltWidthTop) / 2 - tiltShift,
  -(stiltWidth - stiltWidthTop) / 2 - tiltShift
];
stiltsXFlipLocation = backplaneFrameTopOuterWidth / 2;
stiltsYFlipLocation = backplaneFrameTopOuterDepth / 2;

// rails
connectorDistance = connectorWidth + connectorGap;
connectorRailWidthDifference = railWidth - (connectorWidth - connectorLeftWallThickness/2);
railDepthBottom = railDepth * (1/railDepthExpansionFactor); 
railFrameInnerDifference = 6;
railFrameInnerDifferenceBottom = min(railDepthBottom/2, railDepthBottom - railFrameInnerDifference);;
railFrameInnerDifferenceTop = min(railDepth/2, railDepth - railFrameInnerDifference);
railFrameInnerDifferenceHeight = min(railHeight/2, railFrameInnerDifference * 4);
railFrameInnerOffset = railFrameInnerDifferenceBottom / 2;
railShift = [
  0,
  (railDepthBottom - railDepth) / 2
];

railCount = floor((bpWidth - connectorLeftOffset - bpPadding) / connectorDistance); // only one time `bpPadding` because the left padding is included with the connector offset
railRelativeOffset = connectorRailWidthDifference/2;
railOffsetLeft = backplaneFrameTopCutoutOffsetLeft - bpPadding + connectorLeftOffset;
railEdgeOffsetFront = insertedPcbOffsetFront + bpFrameRimThicknessAdjusted+bpPadding + railSlotDepth - railSlotClearance - railDepthBottom;
railsYFlipLocation = railEdgeOffsetFront + railDepthBottom - (railSlotDepth - railSlotClearance);
railsDistance = insertedPcbDepth + 0*railSlotClearance;
railTotalOffsetFront = insertedPcbOffsetFront - railSlotDepth/2;
railSlotInsideThickness = insertedPcbThickness;
railTotalOffsetBack = (bpDepth - railsDistance - insertedPcbOffsetFront) - railSlotDepth/2;
railSlotOutsideThickness = insertedPcbThickness * railSlotExpansionFactor;
railSlotShift = (railSlotOutsideThickness - railSlotInsideThickness) / 2;
railSlotOffsetLeft = connectorLeftWallThickness - (railSlotOutsideThickness - railSlotInsideThickness)/2;
railSlotOffsetFront = railDepthBottom;

railWallWidth = connectorDistance * railCount + railWidth;
railWallOffsetLeft = (railWidth - connectorWidth) / 2;

backplaneFrameTopCutoutDepthAdjusted = backplaneFrameTopCutoutDepth - railTotalOffsetFront - railTotalOffsetBack;
backplaneFrameTopCutoutOffsetFrontAdjusted = backplaneFrameTopCutoutOffsetFront + railTotalOffsetFront + railSlotDepth;
// backplaneFrameTopCutoutOffsetBack = backplaneFrameTopOuterDepth - backplaneFrameTopCutoutOffsetFront/2 - railTotalOffsetFront/2 - railTotalOffsetBack + railSlotDepth;
backplaneFrameTopCutoutOffsetBack = backplaneFrameTopOuterDepth - backplaneFrameTopCutoutOffsetFrontAdjusted/2;
