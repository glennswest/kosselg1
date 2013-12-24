//////////////////////////////////////////////////////////////////////////////////////
// Mount for a servo for autoleveling
// modified servo_mount.scad 12/12/13 by zennmaster (thing:167440)
// last modified: 12/14/13
/////////////////////////////////////////////////////////////////////////////////////

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
	cube([45,6.35,28.5], true);
	// mount
	difference() {
		translate([0,16.1,-11.1]) cube([45,38.5,6.35],true);
		//mounting screw holes
		translate([15,30,-20]) rotate([0,0,0])cylinder(h=20,r=mount_bolt_size/2,$fn=50);
		translate([-15,30,-20]) rotate([0,0,0])cylinder(h=20,r=mount_bolt_size/2,$fn=50);
		// hole in mount
		hull() {
			translate([3,17,-16]) rotate([0,0,0])cylinder(h=10,r=10,$fn=50);
			translate([-3,17,-16]) rotate([0,0,0])cylinder(h=10,r=10,$fn=50);
		}
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
