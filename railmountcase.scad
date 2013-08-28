include <configuration.scad>;


module rumbacase() {
          scale([1, 1, 1]) import("rumbacase_notabs.STL");
          translate([15.5, 0, 15.5]) rotate([90, 0, 0])
               cylinder(r=1.65, h=20, center=true);
}

