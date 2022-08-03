include <BOSL2/std.scad>

module dummyBackplane() {

  color("green")
  cuboid([64, 128.5, 1.6], anchor=BOTTOM+FRONT+LEFT);

  up(1.6)
  back(35)
  color("red") {
    right(6.4)
      cuboid([9, 56, 11], anchor=BOTTOM+FRONT+LEFT);
    right(26.55)
      cuboid([9, 56, 11], anchor=BOTTOM+FRONT+LEFT);
    right(46.7)
      cuboid([9, 56, 11], anchor=BOTTOM+FRONT+LEFT);
  }

  color("green")
  up(12.6)
  back(13.9)
  right(30.2)
    cuboid([1.8, 100, 90], anchor=BOTTOM+FRONT+LEFT);

}
