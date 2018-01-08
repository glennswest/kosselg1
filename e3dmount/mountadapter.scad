use <../MCAD/nuts_and_bolts.scad>;

offset = 22;  // Same as DELTA_EFFECTOR_OFFSET in Marlin.
height=10;
m3_radius=1.5;
m3_nut_radius=1.7;
m3_wide_radius=1.6;
separation=44;
mount_radius = 18.5;  // Hotend mounting screws, standard would be 25mm.
hotend_radius = 8;  // Hole for the hotend (J-Head diameter is 16mm).
mount_space=23/2;

module bolt(thesize,thelength)
{
    boltHole(thesize, length=thelength);
    %boltHole(thesize, length=thelength);
}

module adapter()
{
  difference(){
    cylinder(r=offset, h=height, center=true, $fn=100);
    cylinder(r=hotend_radius, h=height+1, center=true,$fn=100);
    translate([-11,-6, -2])  bolt(3, 20);
    translate([ 11,-6, -2])  bolt(3, 20);
    translate([  0,-13,-2])  bolt(3, 20);
    translate([  0, 13,-2])  bolt(3, 20);
    for (a = [0:120:359]) rotate([0, 0, a+90]) {
      translate([0, mount_radius, -17]) bolt(3,22); 
      translate([0, mount_radius,  height/2-2]) nutHole(3.1);
      translate([0, mount_radius,  height/2-4]) nutHole(3.1);      
    }
   }
 }
 
 //projection() translate([0,0,5]) adapter();
 adapter();