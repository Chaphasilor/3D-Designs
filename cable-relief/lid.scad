include <./config.scad>

module lid() {

  difference() {

    cube([casingDepth, casingWidth, lidThickness]);

    translate([casingRailWallThickness, casingRailWallThickness, 0])
    #cube([connectorRimDepth, connectorWidth, lidInsetDepth]);

  }

  color("orange")
    translate([casingDepth + strippedCableLength - teethOffsetTop, (casingWidth/2 + teethWidth/2), 0])
      teeth();

  translate([casingDepth, 0, 0]) {

    linear_extrude(height = lidThickness, center = false, convexity = 1, slices = 20, scale = 1.0, $fn = 16) {

      polygon(points = polyRound(casingRadii, 5));
      
    }

    translate([strippedCableLength - lidScrewEarWidth, casingWidth - casingClampOffset + lidScrewHolePadding*1.5, 0])
      cube([lidScrewEarWidth, lidScrewEarWidth + lidScrewHoleOffset, lidThickness]);

    translate([strippedCableLength, casingClampOffset - lidScrewHolePadding*1.5, 0])
      rotate([0, 0, 180])
        cube([lidScrewEarWidth, lidScrewEarWidth + lidScrewHoleOffset, lidThickness]);

  }


  translate([0, 0, -paddingFrontTop])
    cube([casingRailWallThickness, connectorWidth + 2*casingRailWallThickness, paddingFrontTop]);

}

module hole_puncher() {

  translate([casingDepth, 0, 0]) {

    // back
    translate([strippedCableLength - lidScrewEarWidth/2, casingWidth - casingClampOffset + lidScrewEarWidth/2 + lidScrewHoleOffset + lidScrewHolePadding*1.5, -lidScrewHoleDepth])
      cylinder(d=lidScrewHoleDiameter, h=lidScrewHoleDepth+2.5, center=false, $fn=20);
    translate([strippedCableLength - lidScrewEarWidth/2, casingClampOffset - lidScrewEarWidth/2 - lidScrewHoleOffset - lidScrewHolePadding*1.5, -lidScrewHoleDepth])
      cylinder(d=lidScrewHoleDiameter, h=lidScrewHoleDepth+2.5, center=false, $fn=20);

    // middle
    translate([strippedCableLength - cableLength + lidScrewHoleDiameter/2 + lidScrewHolePadding, casingClampOffset + casingWallThickness + cableDiameter/2, -lidScrewHoleDepth]) {
      translate([0, cableDiameter/2 + lidScrewHoleDiameter/2 + lidScrewHolePadding, 0])
        cylinder(d=lidScrewHoleDiameter, h=lidScrewHoleDepth+2.5, center=false, $fn=20);
      translate([0, -cableDiameter/2 - lidScrewHoleDiameter/2 - lidScrewHolePadding, 0])
        cylinder(d=lidScrewHoleDiameter, h=lidScrewHoleDepth+2.5, center=false, $fn=20);
    }

    // front
    translate([strippedCableLength*0.2, casingClampOffset*0.35 + casingWallThickness/2 + lidScrewHolePadding, -lidScrewHoleDepth]) 
      cylinder(d=lidScrewHoleDiameter, h=lidScrewHoleDepth+2.5, center=false, $fn=20);

    translate([strippedCableLength*0.2, casingWidth - (casingClampOffset*0.35 + casingWallThickness/2) - lidScrewHolePadding, -lidScrewHoleDepth]) 
      cylinder(d=lidScrewHoleDiameter, h=lidScrewHoleDepth+2.5, center=false, $fn=20);
    
  }
  
}

module teeth() {

  rotate([180, 0, 270]) {

    prism(teethWidth, teethLength, teethHeight);
    translate([0, teethLength, 0])
      prism(teethWidth, teethLength, teethHeight);
    translate([0, teethLength*2, 0])
      prism(teethWidth, teethLength, teethHeight);
      
  }
  
}

module prism(l, w, h){

  polyhedron(
    points=[[0,0,0], [l,0,0], [l,w,0], [0,w,0], [0,w,h], [l,w,h]],
    faces=[[0,1,2,3],[5,4,3,2],[0,4,5,1],[0,3,4],[5,2,1]]
  );
  
  // preview unfolded (do not include in your function)
  // z = 0.08;
  // separation = 2;
  // border = .2;
  // translate([0,w+separation,0])
  //   cube([l,w,z]);
  // translate([0,w+separation+w+border,0])
  //   cube([l,h,z]);
  // translate([0,w+separation+w+border+h+border,0])
  //   cube([l,sqrt(w*w+h*h),z]);
  // translate([l+border,w+separation+w+border+h+border,0])
  //   polyhedron(
  //     points=[[0,0,0],[h,0,0],[0,sqrt(w*w+h*h),0], [0,0,z],[h,0,z],[0,sqrt(w*w+h*h),z]],
  //     faces=[[0,1,2], [3,5,4], [0,3,4,1], [1,4,5,2], [2,5,3,0]]
  //   );
  // translate([0-border,w+separation+w+border+h+border,0])
  //   polyhedron(
  //     points=[[0,0,0],[0-h,0,0],[0,sqrt(w*w+h*h),0], [0,0,z],[0-h,0,z],[0,sqrt(w*w+h*h),z]],
  //     faces=[[1,0,2],[5,3,4],[0,1,4,3],[1,2,5,4],[2,0,3,5]]
  //   );

}
