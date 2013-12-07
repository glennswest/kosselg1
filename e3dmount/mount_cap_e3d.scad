include <configuration.scad>;

separation = 44;  // Distance between ball joint mounting faces.
offset = 22;  // Same as DELTA_EFFECTOR_OFFSET in Marlin.
mount_radius = 18.5;  // Hotend mounting screws, standard would be 25mm.
jhead_od_radius = 8;  // Hole for the hotend (J-Head diameter is 16mm).
jhead_id_radius = 6;
height = 4;
jhead_height=2.5;


module mount_cap() {
  difference() {
    union() {
		cylinder(r=offset-5, h=height, center=true, $fn=36);
		
		for (a = [0:120:359]) rotate([0, 0, a]) {
      	translate([0, mount_radius, 0])	cylinder(r=7.5, h=height, center=true, $fn=36);
    		}

	}
		
    translate([0, 0, -height/2])cylinder(r=4, h=height, $fn=36);
    translate([0, 0, -height/2+jhead_height])cylinder(r=jhead_od_radius, h=jhead_height, $fn=36);

    for (a = [0:120:359]) rotate([0, 0, a]) {
      translate([0, mount_radius, height/2])	cylinder(r=m3_wide_radius, h=2*height, center=true, $fn=12);
    }

	
    for (a = [60:120:359]) rotate([0, 0, a]) {
      translate([0, offset, height/2])	cylinder(r=13, h=2*height, center=true, $fn=36);
    }

  }
}

translate([0, 0, height/2]) mount_cap();