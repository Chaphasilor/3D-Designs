// Print the shield part with any hard material (e.g. Tough PLA)
// Print the addon clip with TPU

// ------------ Recess measurements -------------
width = 90; // shield width
upperLowerDistance = 54; // length of direct path from upper edge to lower edge 
height = 48; // vertical distance from upper edge to lower edge
edgeWidthTopSide = 5; // width of the edge (sides and top)
edgeWidthBottom = 12.5; // width of the edge (bottom)
safeBendDistance = 40; // the minimum distance from the metal before the cables can be shielded
angle = 60; // the angle at which the angled part bends
angledPartLength = 33; // the length of the angled part

// --------------- Shield settings ---------------
wallThickness = 7; // thickness of the shield walls
depth = cos(angle) * angledPartLength; // the horizontal distance from upper edge to lower edge
scaleX = (width - wallThickness*2) / width; // the scaling factor in x-direction
scaleY = (safeBendDistance + depth - wallThickness) / (safeBendDistance +  depth); // the scaling factor in y-direction
scaleZ = (height - wallThickness) / height; // the scaling factor in z-direction
lipOffset = 4; // the added length that potrudes behind the edges
lipThickness = 2; // the thinkness of the lips

module shield() {
  
  color("#202020") {

    difference() {

      union() {

        difference() {
          shieldOuter();

          translate([wallThickness, wallThickness, 0])
            scale([scaleX, scaleY, scaleZ])
              shieldOuter();
        }

        shieldBottom();
      
      }

      translate([0, lipOffset, 0]) {

        translate([0, safeBendDistance, sin(angle) * angledPartLength])
          rotate([-angle, 0, 0])
            cube([width, angledPartLength, height]);
        
        translate([0, safeBendDistance, sin(angle) * angledPartLength])
          cube([width, angledPartLength, height]);
        
      }

      bottomLipRail();

      
    }
    
  }
  
}

module shieldOuter() {

  cube([width, safeBendDistance + depth + lipOffset, height], center=false);
  
}

module shieldBottom() {

  translate([0, safeBendDistance + lipOffset, 0])
    cube([width, depth, wallThickness]);
  
}

module bottomLipRail() {

  scale([2, 1, 1])
    #translate([-width*0.25, safeBendDistance + depth - lipOffset/2, cos(angle) * edgeWidthBottom/2])
      rotate([-angle, 0, 0])
        bottomLip();
  
}

module bottomLip() {

  union() {
    cube([width, edgeWidthBottom/2, lipThickness]);
    translate([0, 0, -lipThickness*0.25])
      cube([width, lipOffset/2, lipThickness*1.5]);
  }
  
}

shield();
