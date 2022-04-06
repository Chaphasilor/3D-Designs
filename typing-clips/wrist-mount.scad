include <BOSL2/std.scad>

pcbWidth = 40.5;
pcbDepth = 60;
pcbHeight = 1.6;
pcbClearanceBottom = 3;
pcbClearanceTop = 5;
pcbMountInset = 1;
pcbMountInsetChamfer = 1;

velcroWidth = 15;
velcroHeight = 1.25;
velcroMountDepth = 7;
velcroMountExpansionFactor = 1.3;
velcroMountPaddingX = 5;
velcroMountPaddingY = 5;

wallThickness = 2;

frameWidth = 2*wallThickness - 2* pcbMountInset + pcbWidth;
frameDepth = pcbDepth;
frameHeight = wallThickness + pcbClearanceBottom + pcbHeight + pcbClearanceTop;

module main() {

  difference() {
    frame();

    #holePuncherPCB();
  }

  right(velcroMountPaddingX) back(velcroMountPaddingY)
    velcroMount();
  right(frameWidth - velcroMountDepth - velcroMountPaddingX) back(velcroMountPaddingY)
    velcroMount();
  right(velcroMountPaddingX) back(frameDepth - velcroWidth*velcroMountExpansionFactor - velcroMountPaddingY)
    velcroMount();
  right(frameWidth - velcroMountDepth - velcroMountPaddingX) back(frameDepth - velcroWidth*velcroMountExpansionFactor - velcroMountPaddingY)
    velcroMount();
  
}

module frame() {
  difference() {
    cube([frameWidth, frameDepth, frameHeight]);

    right(wallThickness) up(wallThickness)
      cube([frameWidth - 2*wallThickness, frameDepth, frameHeight - wallThickness]);
  }
}

module holePuncherPCB() {

  right(wallThickness - pcbMountInset) up(wallThickness + pcbClearanceBottom)
    cuboid([pcbWidth, pcbDepth, pcbHeight + 2*pcbMountInsetChamfer], chamfer=pcbMountInsetChamfer, edges=[TOP+LEFT,TOP+RIGHT,BOTTOM+LEFT,BOTTOM+RIGHT], anchor=BOTTOM+LEFT+FRONT);

}

module velcroMount() {

  module innerMount() {
    prismoid(size1=[velcroWidth*velcroMountExpansionFactor, velcroMountDepth], size2=[velcroWidth, velcroMountDepth], h=velcroHeight, shift=[0,0], anchor=BOTTOM, orient=DOWN, spin=90);
  }
  
  right(velcroMountDepth/2) back(velcroWidth*velcroMountExpansionFactor/2)
    difference() {
      scale([1, 1.2, 1.75]) {
        innerMount();
      }

      innerMount();
    }
  
}

main();
