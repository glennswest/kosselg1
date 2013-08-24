/*
	3D Power Supply Mount
	by Free Beachler of Terawatt Industries

This work is licensed under the Creative Commons Attribution-ShareAlike 3.0 Unported License. To view a copy of this license, visit http://creativecommons.org/licenses/by-sa/3.0/.
*/

//Round corner diameter
round_corner_diameter = 8;

m5_diameter = 5.5;
m5_nut_diameter = 9.5;
m5_cap_diameter = 8.5;
m4_diameter = 4.5;
m4_nut_diameter = 7.5;
m3_diameter = 3.2;
m3_nut_diameter = 5.3;

power_mount();
// power supply
//% color([0.1, 0.9, 0]) translate([0, 2.5, 10]) cube([85, 175, 70]);

module power_mount() {
	difference() {
		union() {
			platform();
			translate([0, 25 + 5 + 2.5, 17]) rotate([0, 0, 90]) mount_arm_m3(0, 0, 0, 0.1, 2);
			translate([0, 87.5 + 5 + 2.5, 17]) rotate([0, 0, 90]) mount_arm_m3(0, 0, 0, 0.1, 2);
			translate([0, 150 + 5 + 2.5, 17]) rotate([0, 0, 90]) mount_arm_m3(0, 0, 0, 0.1, 2);
		}
		translate([0, 2.5, 2.5]) mount_holes();
	}
}

module platform() {
	difference() {
		// round some corners
		translate([0, 0, 5]) minkowski() {
			difference() {
				cube([90, 180, 25]);
				translate([10, -5.1, 10]) cube([75, 205.2, 70]);
			}
			cylinder(r=2.5, h=0.01, center=false, $fn=12);
			//	rotate([0, 90, 0]) cylinder(r=2.5, h=0.01, center=false, $fn=12);
		}
		translate([0, 0, 10]) cube([87, 178, 75]);
	}
	// square the mount plate area
	translate([-5.5, -2.5, 5]) cube([5.5, 185, 25]);
	//	translate([-9.5, 5, 0]) cube([97.5, 185, 5]);
}

module mount_holes() {
	for (i = [25, 87.5, 150]) {
		rotate([0, 90, 0]) translate([-10, i, -20]) cylinder(r=m5_diameter / 2, h=150, center = false, $fn=12);
		rotate([0, 90, 0]) translate([-10, i, -4.9]) cylinder(r=m5_cap_diameter / 2, h=10, center = false, $fn=12);
	}
}


module mount_arm_m3(h, w, d, tol, wt) {
	for (z = [d - wt - 5 + 3.5]) {
		// trapezoid block
		difference() { 
			hull() {
				hull() {
					translate([h - 10, w + 4, z - 6]) cube([10, 5, 10], center = false);
					translate([h + 5, w, z + 6.5]) rotate([0, 90, 90]) cube([15, 15 + wt * 2, 5], center = false);
				}
				// rounded block
				translate([h - 12.5, w + wt + 1.5 + 3.5, z + 2.5]) rotate([90, 0, 90]) cylinder(r = 1, h = 15, center = false, $fn = 24);
				translate([h - 12.5, w + wt + 1.5 + 3.5, z - 7 + 2.5]) rotate([90, 0, 90]) cylinder(r = 1, h = 15, center = false, $fn = 24);
			}
			// M3 mount hole
			translate([h - 5, w * 2, z - 3.5 + 2.5]) rotate([90, 0, 0]) cylinder(r = 1.6, h = d * 2, center = false, $fn = 24);
		}
	}
}

