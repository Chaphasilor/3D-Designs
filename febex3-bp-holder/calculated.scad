// all calculated values are defined in this file

// stilts 1
stiltWidthTop = stiltWidth * stiltWidthExpansionFactor;

// backplane frame

screwOffsetDistance = stiltWidth + bpFrameScrewPadding;
bpFrameRimThicknessAdjusted = bpFrameRimThickness + screwOffsetDistance;

backplaneFrameBottomThickness = bpHeight + max(wallThickness, bpClearanceBottom);
backplaneFrameBottomOuterWidth = bpWidth + 2 * bpFrameRimThicknessAdjusted;
backplaneFrameBottomOuterDepth = bpDepth + 2 * bpFrameRimThicknessAdjusted;
backplaneFrameBottomInnerWidth = bpWidth;
backplaneFrameBottomInnerDepth = bpDepth;
backplaneFrameBottomCutoutWidth = bpWidth - 2 * bpFrameRimThicknessAdjusted;
backplaneFrameBottomCutoutDepth = bpDepth - 2 * bpFrameRimThicknessAdjusted;

maxFrameRimBpPadding = max(bpFrameRimThicknessAdjusted, bpPadding);
screwOffsets = [
  [screwOffsetDistance, screwOffsetDistance],
  [backplaneFrameBottomOuterWidth - screwOffsetDistance, screwOffsetDistance],
  [screwOffsetDistance, backplaneFrameBottomOuterDepth - screwOffsetDistance],
  [backplaneFrameBottomOuterWidth - screwOffsetDistance, backplaneFrameBottomOuterDepth - screwOffsetDistance],
];

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
connectorRailWidthDifference = railWidth - connectorWidth;

railCount = floor((bpWidth - connectorLeftOffset - bpPadding) / connectorDistance); // only one time `bpPadding` because the left padding is included with the connector offset
railRelativeOffset = connectorRailWidthDifference/2;
railOffsetLeft = backplaneFrameTopCutoutOffsetLeft - bpPadding + connectorLeftOffset;
railEdgeOffsetFront = backplaneFrameTopCutoutOffsetFront - railDepth + railSlotDepth;
railsYFlipLocation = railEdgeOffsetFront + railDepth - railSlotDepth;
railTotalOffsetFront = insertedPcbOffsetFront - railSlotDepth/2;
railSlotInsideThickness = insertedPcbThickness;
railTotalOffsetBack = (bpDepth - insertedPcbDepth - insertedPcbOffsetFront) - railSlotDepth/2;
railSlotOutsideThickness = insertedPcbThickness * railSlotExpansionFactor;
railSlotShift = (railSlotOutsideThickness - railSlotInsideThickness) / 2;
railSlotOffsetLeft = railSlotOutsideThickness/2 + railWidth/2;
railSlotOffsetFront = railDepth;

backplaneFrameTopCutoutDepthAdjusted = backplaneFrameTopCutoutDepth - railTotalOffsetFront - railTotalOffsetBack;
backplaneFrameTopCutoutOffsetFrontAdjusted = backplaneFrameTopCutoutOffsetFront + railTotalOffsetFront + railSlotDepth;
backplaneFrameTopCutoutOffsetBack = backplaneFrameTopOuterDepth - backplaneFrameTopCutoutOffsetFront/2 - railTotalOffsetFront/2 - railTotalOffsetBack + railSlotDepth;
