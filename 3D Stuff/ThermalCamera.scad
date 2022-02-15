use <PiBaseHat.scad>;

CX=65/2;
CY=59/2;

difference()
{
    baseHat();

    translate([CX-7,CY-3,-.1]) cylinder(d=3.2,h=3.2,$fn=120);
    translate([CX+7,CY-3,-.1]) cylinder(d=3.2,h=3.2,$fn=120);
    translate([CX-3,CY-7,-.1]) cylinder(d=3.2,h=3.2,$fn=120);
    translate([CX-3,CY+7,-.1]) cylinder(d=3.2,h=3.2,$fn=120);
    
    translate([CX-7,CY+3,-.1]) cylinder(d=3.2,h=3.2,$fn=120);
    translate([CX+7,CY+3,-.1]) cylinder(d=3.2,h=3.2,$fn=120);
    translate([CX+3,CY-7,-.1]) cylinder(d=3.2,h=3.2,$fn=120);
    translate([CX+3,CY+7,-.1]) cylinder(d=3.2,h=3.2,$fn=120);
}