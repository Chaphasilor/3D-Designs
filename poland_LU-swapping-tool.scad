include <BOSL2/std.scad>

tool = "left"; // [left, right]

layerHeight = 0.2; // [0.05:0.05:5]

baseClearanceBottom = 10; // [0:0.05:15]

toolHeight = baseClearanceBottom;
toolDepth = 5; // [0:0.1:50]
toolGripWidth = 15; // [0:0.1:100]
toolGripHeight = 5; // [0:0.1:25]
toolGripDepth = 175; // [0:0.1:250]
leftToolWidth = 50; // [0:0.1:100]
rightToolWidth = 40; // [0:0.1:100]
leftToolGripOffsetLeft = leftToolWidth/2 - toolGripWidth/2;
rightToolGripOffsetLeft = rightToolWidth/2 - toolGripWidth/2;

maxSegmentDepth = 30; // [1:150]
segmentFoldAngle = 60; // [5:160]
hingeSpacing = 0.25; // [0:0.05:10]
hingeLayers = 1; // [1:10]

textSize = 10;
textInsetDepth = 1;

module main() {

  if (tool == "left") {
    leftTool();
  } else if (tool == "right") {
    rightTool();
  }
    
}

module leftTool() {

  back(toolGripDepth)
    head(leftToolWidth);
  right(leftToolGripOffsetLeft)
    difference() {
      grip();
      
      textHolePuncher("L");
    }
  
}

module rightTool() {

  back(toolGripDepth)
    head(rightToolWidth);
  right(rightToolGripOffsetLeft)
    difference() {
      grip();
      
      textHolePuncher("R");
    }

}

module textHolePuncher(text) {
  up(toolGripHeight - textInsetDepth) right(toolGripWidth/2)
      back(toolGripDepth - (maxSegmentDepth-getWedgeTopWidth(segmentFoldAngle))/2)
        text3d(text, h=textInsetDepth, size=textSize, anchor=str(BOTTOM+CENTER));
}

module head(width) {

  difference() {
    
    linear_extrude(toolHeight)
      polygon(points=[
        [0, 0],
        [width, 0],
        [width, toolDepth*0.25],
        [width-toolDepth, toolDepth],
        [toolDepth, toolDepth],
        [0, toolDepth*0.25],
      ]);
    
    // sloped top
    back(toolDepth) up(toolHeight) rotate([0, 180, 0])
      prismoid(size1=[width, toolDepth], size2=[width, toolDepth], h=toolHeight*0.25, shift=[0, toolDepth*0.75], anchor=RIGHT+BOTTOM);
    
  }

}

module grip() {

  difference() {
    cube([toolGripWidth, toolGripDepth, toolGripHeight]);
    
    
    wedgeTopWidth = getWedgeTopWidth(segmentFoldAngle);
    for (i=[1:floor(toolGripDepth/maxSegmentDepth)]) {
      #back(toolGripDepth) right(toolGripWidth/2) up(layerHeight*hingeLayers)
        fwd(i*maxSegmentDepth - wedgeTopWidth/2)
          wedge(segmentFoldAngle);
    }
    
  }

}

function getWedgeTopWidth(angle) = 2* toolGripHeight * tan(angle/2) + hingeSpacing;

module wedge(angle=60, spacing=0) {

  topWidth = getWedgeTopWidth(angle);
  prismoid(size1=[toolGripWidth, hingeSpacing], size2=[toolGripWidth, topWidth], h=toolGripHeight);

}

main();
