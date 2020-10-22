$fn= 360;
total_width = 117.25;
total_length = 53.48;
thickness = 2.06;

module curve(width, height, length, dh) {
    r = (pow(length/2, 2) + pow(dh, 2))/(2*dh);
    a = 2*asin((length/2)/r);
    translate([-(r -dh), 0, -width/2]) rotate([0, 0, -a/2])         rotate_extrude(angle = a) translate([r, 0, 0]) square(size = [height, width], center = true);
}

module c_curve(width, height, length, dh) {
    translate([0,height/2,thickness])
    curve(width, height,  length, dh);
}

module screw_hole() {
    cylinder(r1=2.0/2, r2=3.0/2, h=thickness, $fn=360);
}

module block() {
    cube([total_length, total_width, thickness]);
}

module border() {
    bt = 20;
    difference() {
        translate([-bt, -bt, 0]) 
        cube([total_length + bt + bt, total_width + bt + bt, thickness]);
        
        block();
    }
}

module screw_holes() {
    sll = 23.14;
    w_offset = 5.66;
    translate([sll, w_offset, 0]) screw_hole();
    translate([sll+ 20.89, w_offset, 0]) screw_hole();
    translate([15.5, 102.25,0]) screw_hole();
}

module bottom_catch() {
    difference() {
        translate([16.45, 0,0])
        color("purple")
        cube([35.25,23.70, thickness]);
        screw_holes();
    }   
}


module bottom_left_curve() {
    color("blue") 
    translate([8,15.5,0])
    rotate([0,0,17])
    c_curve(thickness , 2,  59.50, 4.75);
}

module bottom_right_curve() {
    color("green")
    
    rotate([0,0,180 - 4])
    translate([-51.2,-16.5,0])
    c_curve(thickness, 2, 23.6, 1);
}

module top_left_curve() {
    color("green")
    rotate([0,0,-9.31])
    translate([-6.5,75,0])
    c_curve(thickness, 2, 65, 4.75);
}

module tip() {
    color("red")
    translate([16.5,101.5,0])
    rotate(40)
    c_curve(thickness, 1, 16.16, 5);
}

module mid_right_curve()  translate([0,0,0]); {
    color("blue")
    translate([45,30,0])
    rotate([0,0,180+50])
    c_curve(thickness, 2, 20.16, 3);
}

module mid_strait() {
    color("green")
    translate([40.75,32,0])
    rotate([0,0,180-75.15])
    cube([73.4, 2, thickness]);
}

module basic() {
    cylinder(r1=1,r2=1,h=thickness);
}
module fill() {
    color("red")
    hull() {
        translate([16,4,0])
        basic();
        
        translate([16,9,0])
        basic();
    }

    hull() {
        
        translate([16, 8,0])
        basic();
        
        translate([3,44,0])
        basic();
        
        translate([20,102,0])
        basic();
        
        translate([40,25,0])
        basic();
    }
    
    hull() {
        translate([2, 44, 0])
        basic();
        
        translate([3.5, 40, 0])
        basic();
    }
    
    
    hull() {
        translate([47,24,0])
        basic();
        
        translate([40,24,0])
        basic();
        
        translate([39,30,0])
        basic();
    }
    

    hull() {
        translate([13, 107, 0])
        basic();
        translate([12, 65, 0])
        basic();
        translate([18, 106, 0])
        basic();
        
        translate([20, 103, 0])
        basic();
    }
    
}

module fill_with_catch() {
    difference() {
        fill();
        translate([15.5, 102.25,0])
        screw_hole();
    }
}

module unclean_final() {
    
    bottom_catch();
    bottom_left_curve();
    bottom_right_curve();
    top_left_curve();
    mid_right_curve();
    mid_strait();
    fill_with_catch();
    tip();
}



module clean_final() {
    difference() {
        unclean_final();
        border();
    }
}

clean_final();



