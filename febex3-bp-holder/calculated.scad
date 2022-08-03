// all calculated values are defined in this file

// backplane frame
maxFrameRimBpPadding = max(bpFrameRimThickness, bpPadding);

backplaneFrameBottomThickness = bpHeight + wallThickness;
backplaneFrameBottomOuterWidth = bpWidth + 2 * bpFrameRimThickness;
backplaneFrameBottomOuterDepth = bpDepth + 2 * bpFrameRimThickness;
backplaneFrameBottomInnerWidth = bpWidth;
backplaneFrameBottomInnerDepth = bpDepth;
backplaneFrameBottomCutoutWidth = bpWidth - 2 * bpFrameRimThickness;
backplaneFrameBottomCutoutDepth = bpDepth - 2 * bpFrameRimThickness;

backplaneFrameTopThickness = wallThickness;
backplaneFrameTopOuterWidth = bpWidth + 2 * maxFrameRimBpPadding;
backplaneFrameTopOuterDepth = bpDepth + 2 * maxFrameRimBpPadding;
backplaneFrameTopCutoutWidth = bpWidth - 2 * bpPadding;
backplaneFrameTopCutoutDepth = bpDepth - 2 * bpPadding;
backplaneFrameTopCutoutOffsetLeft = (backplaneFrameTopOuterWidth - backplaneFrameTopCutoutWidth) / 2;
backplaneFrameTopCutoutOffsetFront = (backplaneFrameTopOuterDepth - backplaneFrameTopCutoutDepth) / 2;

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
