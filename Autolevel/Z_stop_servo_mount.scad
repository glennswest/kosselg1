//////////////////////////////////////////////////////////////////////////////////////////////////
// Created on 12/13/2013 by Stephen Castello
// Last update: 12/21/2013
//////////////////////////////////////////////////////////////////////////////////////////////////
// variables
//////////////////////////////////////////////////////////////////////////////////////////////////
Z_Rod_dia=10;				// diameter of Z rod
Screw_dia=3.2;				// clamp screw diameter
Screw_Thread_dia=2.5;		// screw hole diameter to make a 3mm threaded hole
Switch_ht=15;				// height of holder
Switch_thk = 4;				// thickness of holder
Switch_hole_sep=22;		// distance between holes for switch (19 for mechanical endstop v1.2)
Switch_hole_offset = 10;		// switch hole offest (mech endstop v1.2 doesn't have one)
Nut_wrench_size = 5.5;		// wrench size of nut
Nut_depth = 2.3;			// thickness of nut
Nylok_depth = 4;			// thickness of nylok nut
Lever_wd = 12;				// width of lever
Lever_ht = 33;				// lever length
Servo_dia = 8.2;			// outside diameter of servo lever
//////////////////////////////////////////////////////////////////////////////////////////////////
// make the parts
//////////////////////////////////////////////////////////////////////////////////////////////////

rotate([0,-90,0]) {
 	switch_side();
	lever();
}

//////////////////////////////////////////////////////////////////////////////////////////////////
// modules for each part
//////////////////////////////////////////////////////////////////////////////////////////////////

module switch_side(Switch_Only) { // riser for switch
	difference() {
		difference() {
			difference() {
				cube([Switch_thk,29,Switch_ht],false);
				// screw holes for switch
				rotate(a=[0,90,0]) {		
					translate([-(Switch_ht-2.5), 4, 0]) {
						cylinder(h = 11, r = Screw_dia/2, center = false, $fn=100);
					}
				}
				rotate(a=[0,90,0]) {
					translate(v = [-(Switch_ht-2.5)+Switch_hole_offset, 4+Switch_hole_sep, 0]) {
					cylinder(h = 11, r = Screw_dia/2, center = false, $fn=100);
					}
				}
			}
		}
	}
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////
module lever() {  // servo lever
	difference() {
		hull() {
			translate([0,0,15]) cube([Switch_thk,Lever_wd,Lever_ht-5],false); // lever with a rounded end
			translate([0,6,Lever_ht + 10.5]) rotate([0,90,0]) cylinder(h=Switch_thk,r=Lever_wd/2,$fn=50);
		}
		translate([2.6,3,15]) cube([Switch_thk/2,Lever_wd/2,Lever_ht-5],false); // groove
		translate([-5,6,Lever_ht + 10]) rotate([0,90,0]) cylinder(h=20,r=Servo_dia/2,$fn=50); // servo arm hole
		//rotate(a=[0,90,0]) {	// repeated from switch_side	
		//	translate([-(Switch_ht-2.5), 4, 0]) {
		//		cylinder(h = 11, r = Screw_dia/2, center = false, $fn=100);
		//	}
		//}
 	}
	translate([0,12,11]) rotate([45,0,0]) cube([Switch_thk,5,5],false); // gusset
}

//////////////////////end of Z stop servo mount.scad /////////////////////////////////////////////////
