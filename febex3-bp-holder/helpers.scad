include <BOSL2/std.scad>

module dummyBackplane() {

  color("green")
  cuboid([64, 128.5, 1.6], anchor=BOTTOM+FRONT+LEFT);

  up(1.6)
  back(35)
  color("red") {
    right(8 + (0 * 20.3))
      cuboid([8.8, 56, 11], anchor=BOTTOM+FRONT+LEFT);
    right(8 + (1 * 20.3))
      cuboid([8.8, 56, 11], anchor=BOTTOM+FRONT+LEFT);
    right(8 + (2 * 20.3))
      cuboid([8.8, 56, 11], anchor=BOTTOM+FRONT+LEFT);
  }

  color("green")
  up(12.6)
  back(15) {
    right(8 + 3.15 + (0 * 20.3))
      cuboid([1.6, 100, 90], anchor=BOTTOM+FRONT+LEFT);
    right(8 + 3.15 + (1 * 20.3))
      cuboid([1.6, 100, 90], anchor=BOTTOM+FRONT+LEFT);
    right(8 + 3.15 + (2 * 20.3))
      cuboid([1.6, 100, 90], anchor=BOTTOM+FRONT+LEFT);
  }

}
