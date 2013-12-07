include <configuration.scad>;

separation = 44;  // Distance between ball joint mounting faces.
offset = 22;  // Same as DELTA_EFFECTOR_OFFSET in Marlin.
mount_radius = 18.5;  // Hotend mounting screws, standard would be 25mm.
jhead_od_radius = 8;  // Hole for the hotend (J-Head diameter is 16mm).
jhead_id_radius = 6;
height = 6;
jhead_height=5;
mount_height=32;


  difference() {
    union() {

		for (a = [0:120:359]) rotate([0, 0, a]) {
    		  translate([0, mount_radius,0])cylinder(r1=3,r2=2, h=mount_height/2, center=true, $fn=16);
    		  translate([0, mount_radius,16])cylinder(r1=2,r2=3, h=mount_height/2, center=true, $fn=16);
		}
		
    }

    for (a = [0:30:359]) rotate([0, 0, a]) {
      translate([0, mount_radius, 0])	cylinder(r=m3_wide_radius, h=2*mount_height+height, center=true, $fn=12);
    }

  }
