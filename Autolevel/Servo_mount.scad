//////////////////////////////////////////////////////////////////////////////////////
// Mount for a servo for autoleveling
// modified servo_mount.scad 12/12/13 by zennmaster (thing:167440)
// last modified: 12/14/13
/////////////////////////////////////////////////////////////////////////////////////
include <configuration.scad>;
// From Auto Bed Level
// http://www.thingiverse.com/thing:209384/#files
separation = 44;  // Distance between ball joint mounting faces.
offset = 22;  // Same as DELTA_EFFECTOR_OFFSET in Marlin.
mount_radius = 18.5;  // Hotend mounting screws, standard would be 25mm.
hotend_radius = 14;  // Hole for the hotend (J-Head diameter is 16mm).
height = 4;
cone_r1 = 2.5;
cone_r2 = 14;

servo_width=23.5;  // Width of cutout for servo.
servo_height=12.75; // Height of cutout for servo. 
servo_bolt_size=3; // Diameter of bolt shaft
mount_bolt_size = 3.2;

rotate([90,0,0]) // Lay it down for printing:

union(){
	difference(){
		mainblock();
		translate([0,0,3])
		servo_hole();
	}
}

module mainblock() { //Set up the "blank" part:
	difference() {
		block();
		rotate([90,0,0])
			translate([0,17.25,0])
				cylinder (h=10,r=2, $fn=30, center = true);
	}
}

module block(){
	// Main body:
    difference() {
       cube([55,6.35,25.5], true);
       translate(20,6.35,50) cube([20,6.35,20]);
    }
    
	// mount
	difference() {
         rotate([0,0,270]) translate([0,47,-10.5]) effector([45,38.5,6.35],true);
		//mounting screw holes
		translate([15,30,-20]) rotate([0,0,0])cylinder(h=20,r=mount_bolt_size/2,$fn=50);
		translate([-15,30,-20]) rotate([0,0,0])cylinder(h=20,r=mount_bolt_size/2,$fn=50);
        

	}
}

module servo_hole(){ // Make the opening for the servo.  Adjust the variables above to fir your part.
	cube([servo_width,10,servo_height], true);
	translate([servo_width/2 + servo_bolt_size/2 +1 ,0,0])
		rotate([90,0,0])
			cylinder (h=10,r=servo_bolt_size/2, $fn=30, center = true);
		translate([-servo_width/2 - servo_bolt_size/2-1,0,0])
			rotate([90,0,0])
				cylinder (h=10,r=servo_bolt_size/2, $fn=30, center = true);
}

module effector() {
  difference() {
    union() {
      cylinder(r=offset-2, h=height, center=true, $fn=36);
      for (a = [60:120:359]) rotate([0, 0, a]) {
	rotate([0, 0, 30]) translate([offset-2, 0, 0])
	  cube([4, 12, height], center=true);
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
