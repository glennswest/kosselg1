/*************************************************
 hitec Servo Library
 Author: Maarten Weyn
 Website: http://mweyn.wesdec.be

 v0.4


 Servo Modules:
 - Servo_Hitec_HS_645MG(showaxis=false)
 - Servo_Hitec_HS_485HB(showaxis=false)

 * showaxis shows the other side of the axis which can be used as a connection point

  Horn Modules
 - Horn_Hitec_HD_LS(fulldetail=true) Heavy Duty L Horn
 - Horn_Hitec_R_X(fulldetail=true)  Regular X Horn

 * fulldetail=false only gives the exterior which makes it easier to use in a difference


Changes
v0.4: 
	- added cylinder near label
	- fixed cylinder radios on top (near axis) for HS 485HB


*************************************************/


$fn=50;

// Servos
module Servo_Hitec_HS_645MG(showaxis=false)
{
	Servo_Hitec_Standard(showaxis, 40.6, 19.8, 35.8, 2, 27, 6.4, 30.7, 13, 6, 6, 3.5, 5);
}

module Servo_Hitec_HS_485HB(showaxis=false)
{
	Servo_Hitec_Standard(showaxis, 40, 19.82, 34.8, 3, 28, 6.55, 30, 14, 1, 6, 3.5, 1);
}

module Servo_Hitec_Standard(showaxis=false, boxlength, boxwidth, boxheight, topheight, connectionheight, connectionlength, axisxposition, topclinderradius, wirelength, wirewidth, wireheight, wirezposition)
{

	translate([-axisxposition, -boxwidth/2, -boxheight]) 
	{
		cube([boxlength, boxwidth, boxheight]);

		Servo_HS_Standard_Connections(connectionheight, connectionlength, boxwidth);
		rotate(180) translate([-boxlength, -boxwidth,0]) Servo_HS_Standard_Connections(connectionheight, connectionlength, boxwidth);

		translate([axisxposition, boxwidth/2, boxheight]) cylinder(h=topheight,r=19.8/2);
		translate([6, 1.15, boxheight]) cube([22.1, 17.5, topheight]);
		
		translate([8.5, boxwidth/2, boxheight]) cylinder(h=topheight,r=5.5);

		translate([axisxposition, boxwidth/2, boxheight + topheight]) cylinder(h=2,r=topclinderradius/2);
		translate([axisxposition, boxwidth/2, boxheight + topheight + 2]) cylinder(h=3.2,r=5.5/2);

		translate([boxlength,(boxwidth-wirewidth)/2,wirezposition]) cube([wirelength, wirewidth,wireheight]);

		if (showaxis)			
			translate([axisxposition, boxwidth/2, -7]) %cylinder(h=50,r=5.5/2);

	}
}

module Servo_HS_Standard_Connections(zPosition, length, width )
{
	translate([-length,0,zPosition])	
		difference()
		{
			union()
			{
				cube([20, width, 2]);
				
				translate([0,width/2,0])
				hull()
				{
					cube([0.1, 1, 2.5]);
					translate([length - 0.01,0,0])	 cube([1, 1, 4]);
				}
			}


			for(y=[4.8, 15])
			{
				translate([-1, y-1.25, -1]) cube([3, 2.5, 4]);
				translate([2.5,y,-1]) cylinder(h=4,r=2.21);
			}
		}
}


// Horns
module Horn_Hitec_HD_LS(fulldetail=true)
{

	hornScrewDiameter = 1.6;

	translate([0, 0, -1])
	difference()
	{
	union()
	{
		hull()
		{
			cylinder(h=2, r=7);
			translate([22, 0, 0]) cylinder(h=2, r=4);
		}
		
		hull()
		{
			translate([0, 0,  -1]) 
			{
				cylinder(h=4, r=5.5);
				translate([0, -5,  0])  cube([6, 10, 4]);
			}
	
			cylinder(h=2, r=7);
			translate([0, -6,  0])  cube([7, 12, 2]);			
		}

		hull()
		{
			translate([0, 0,  -3]) 
			{
				cylinder(h=2, r=4);
				translate([0, 0,  1.8])  cylinder(h=0.2, r=5.5);
			}	
		}		
	}

	if (fulldetail)
	{
		union()
		{
			translate([0, 0, -4]) cylinder(h=8, r=1);
			translate([0, 0,  1]) cylinder(h=3, r=4.5);
			translate([0, 0, -4]) cylinder(h=4, r=3);
		}

		for ( x = [13, 16, 19, 22]) {
			translate([x, 0,  -1])cylinder(h=4, r=hornScrewDiameter/2);
		}
	}
	}
}

module Horn_Hitec_R_X(fulldetail=true)
{
	hornScrewDiameter = 1.5;
	difference()
	{
		union()
		{
			hull()
			{
				cylinder(h=2, r=5.5);
				translate([13.25,0,0]) cylinder(h=2, r=2);
				translate([-13.25,0,0]) cylinder(h=2, r=2);
			}
			hull()
			{
				cylinder(h=2, r=5.5);
				translate([0,13.75,0]) cylinder(h=2, r=2);
				translate([0,-13.75,0]) cylinder(h=2, r=2);
			}

			translate([0,0,-2]) cylinder(h=4, r=4.4);
			cylinder(h=2.5, r=4);
		}

		if (fulldetail)
		{
			translate([0,0,-3]) cylinder(h=8, r=1.5);
			translate([0,0,1.5]) cylinder(h=2, r=3);
			translate([0,0,-5]) cylinder(h=6, r=2.5);

			for ( x = [-12.5, -10, -7.5, 7.5, 10, 12.5]) {
				translate([x, 0,  -1]) cylinder(h=4, r=hornScrewDiameter/2);
			}
			for ( y = [-13, -10.5, -8, 8, 10.5, 13]) {
				translate([0, y,  -1]) cylinder(h=4, r=hornScrewDiameter/2);
			}
		}
	}	
}

module showServos()
{
	Servo_Hitec_HS_645MG(false);
	translate([0,0,9]) Horn_Hitec_HD_LS(true);

	translate([0,50,0])
	{
		Servo_Hitec_HS_485HB();
		//translate([0,0,8]) Horn_Hitec_R_X(true);
	}
}

//showServos();