// camera hat for rpi

CX=65/2;
CY=59/2;
FN=120;


module mtg_hole(x,y,z,dia)
{
    translate([x,y,z-.1]) color("red") cylinder(d=dia,h=3.2,$fn=FN);
    
    }

   
module baseHat()
   { 
    difference()
    {
cube([65,56,3]);

mtg_hole(3.5,3.5,0,3);
mtg_hole(3.5,49+3.5,0,3);
mtg_hole(58+3.5,3.5,0,3);
mtg_hole(58+3.5,49+3.5,0,3);      

    }
        
}
 
baseHat();
        
