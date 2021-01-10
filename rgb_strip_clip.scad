// VARIABLES

stripWidth = 11;
gapLength = 8.5;
stripThickness = 0.5;
wallThickness = 1;
angle = 25;
finLength = 15;

// code
clip();

prismTop = stripWidth + wallThickness;
prismBack = prismTop * sin(angle);
prismBottom = prismTop * cos(angle);
finTotalLength = 2*finLength + stripWidth;

module clip() {

  prism(gapLength, prismBottom, prismBack);

  difference() {
    
    #rotate([angle, 0, 0]) 
      translate([0, -prismTop, 0])
        cube([gapLength, 2*prismTop, (wallThickness + stripThickness)]);

    rotate([angle, 0, 0]) 
      translate([0, wallThickness, 0])
      cube([gapLength, stripWidth, stripThickness]);

    translate([0, -prismTop*1.5, -prismTop])
      cube([gapLength, 3*prismTop, prismTop]);
      
  }

  translate([0, -finLength, 0])
    cube([gapLength, finTotalLength, wallThickness]);

}

module prism(l, w, h){

  polyhedron(
    points=[[0,0,0], [l,0,0], [l,w,0], [0,w,0], [0,w,h], [l,w,h]],
    faces=[[0,1,2,3],[5,4,3,2],[0,4,5,1],[0,3,4],[5,2,1]]
  );
  
}