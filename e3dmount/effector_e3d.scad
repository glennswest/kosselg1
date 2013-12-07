include <configuration.scad>;

separation = 44;  // Distance between ball joint mounting faces.
offset = 22;  // Same as DELTA_EFFECTOR_OFFSET in Marlin.
mount_radius = 18.5;  // Hotend mounting screws, standard would be 25mm.
hotend_radius = 14;  // Hole for the hotend (J-Head diameter is 16mm).
height = 10;
cone_r1 = 2.5;
cone_r2 = 14;


module effector() {
  difference() {
    union() {
      cylinder(r=offset-2, h=height, center=true, $fn=36);
      for (a = [60:120:359]) rotate([0, 0, a]) {
	rotate([0, 0, 30]) translate([offset-2, 0, 0])
	  cube([4, 12, height], center=true);
	for (s = [-1, 1]) scale([s, 1, 1]) {
	  translate([0, offset, 0]) difference() {
	    intersection() {
	      cube([separation, 40, height], center=true);
	      translate([0, -4, 0]) rotate([0, 90, 0])
		cylinder(r=10, h=separation, center=true);
	      translate([separation/2-7, 0, 0]) rotate([0, 90, 0])
		cylinder(r1=cone_r2, r2=cone_r1, h=14, center=true, $fn=24);
	    }
	    rotate([0, 90, 0])
	      cylinder(r=m3_radius, h=separation+1, center=true, $fn=12);
	    rotate([90, 0, 90])
	      cylinder(r=m3_nut_radius, h=separation-20, center=true, $fn=6);
	  }
        }
      }
    }
    translate([0, 0, -height/2])
	cylinder(r1=hotend_radius, r2=hotend_radius+1, h=height+1, $fn=36);
    for (a = [0:120:359]) rotate([0, 0, a]) {
      translate([0, mount_radius, 0])
	cylinder(r=m3_wide_radius, h=2*height, center=true, $fn=12);
    }
  }
}

translate([0, 0, height/2]) effector();
