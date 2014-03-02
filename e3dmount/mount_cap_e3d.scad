include <configuration.scad>;
include <fan_mount.scad>;

separation = 44;  // Distance between ball joint mounting faces.
offset = 22;  // Same as DELTA_EFFECTOR_OFFSET in Marlin.
mount_radius = 18.5;  // Hotend mounting screws, standard would be 25mm.
jhead_od_radius = 8;  // Hole for the hotend (J-Head diameter is 16mm).
jhead_id_radius = 6;
height = 4;
jhead_height=2.5;

module fan_stud(){
       cube([40,14,4]);
}


module A8452_mount() {
           difference(){
             cube([16,27,4]);
             union() {
               translate([3,8,0]) cylinder(r=m3_wide_radius, h=2*height, center=true, $fn=12);
               translate([3,23,0]) cylinder(r=m3_wide_radius, h=2*height, center=true, $fn=12);
              }
          }
}

module mount_cap() {
  difference() {
    union() {
        // Mount for MMA8452 Module
        translate([-8,mount_radius+12.2,-2]) rotate(a=[90,0,0]) A8452_mount();        
        // Do a bracket to push the fan down a bit
        translate([-20,-17,-2]) rotate(a=[90,0,0]) fan_stud();
        translate([-20,-17,11]) rotate(a=[90,0,0]) fan_mount(size=40,thick=4);    
		cylinder(r=offset-5, h=height, center=true, $fn=36);
		
		for (a = [0:120:359]) rotate([0, 0, a]) {
      	translate([0, mount_radius, 0])	cylinder(r=8.5, h=height, center=true, $fn=36);
    		}

	}
		
    translate([0, 0, -height/2])cylinder(r=jhead_od_radius, h=height, $fn=36);
    translate([0, 0, -height/2+jhead_height])cylinder(r=jhead_od_radius, h=jhead_height, $fn=36);

    for (a = [0:120:359]) rotate([0, 0, a]) {
      translate([0, mount_radius, height/2])	cylinder(r=m3_wide_radius, h=2*height, center=true, $fn=12);
    }

	
    for (a = [60:120:359]) rotate([0, 0, a]) {
      translate([0, offset, height/2])	cylinder(r=12, h=2*height, center=true, $fn=36);
    }

  }
}

translate([0, 0, height/2]) mount_cap();
