plate_thickness = 2.06;
total_length = 113.0;
total_width = 283.0;
$fn = 360;

module curve(width, height, length, dh) {
    r = (pow(length/2, 2) + pow(dh, 2))/(2*dh);
    a = 2*asin((length/2)/r);
    translate([-(r -dh), 0, -width/2]) rotate([0, 0, -a/2])         rotate_extrude(angle = a) translate([r, 0, 0]) square(size = [height, width], center = true);
}

module c_curve(width, height, length, dh) {
    translate([0,height/2,plate_thickness])
    curve(width, height,  length, dh);
}

module screw() {
        screw_top = 4.00 / 2;
        screw_bottom = 3.00 /2;
    
    
        cylinder(h=plate_thickness, r1=screw_bottom, r2=screw_top, $fn=360);
}

module switch_cutout() {
        l = 13.20 / 2;
    
        cylinder(h=plate_thickness, r1=l, r2=l, $fn=360);
}

module cutouts() {
    translate([5.4, 14.0, 0]) screw();
    translate([52, 87.75, 0]) screw();
    translate([5.4, 116, 0]) screw();
    translate([83, 171.25, 0]) screw();
    translate([5.4, 219.45, 0]) screw();
    translate([85, 242.95, 0]) switch_cutout();
    translate([95.25, 272, 0]) screw();
    

    
}

module border() {
    color("blue") difference() {
        cube([total_length + 10 , total_width + 10, plate_thickness]);
        cube([total_length , total_width, plate_thickness]);
        
    }
}

module basic() {
    cylinder(r1=1, r2=1, h=plate_thickness);
}

module plate(thickness, length, width) {
        color("green")
        translate([85, 275, 0])
        rotate(120)
        c_curve(plate_thickness, 2, 30, 6);
        
        color("green")
        translate([103.7, 270, 0])
        rotate(38)
        c_curve(plate_thickness, 2, 30, 6);
    
        color("green")
        translate([65.5, 255, 0])
        rotate(-25)
        c_curve(plate_thickness, 2, 25, 1);
    
        color("green")
        translate([32, 240, 0])
        rotate(-69)
        c_curve(plate_thickness, 3, 70, 12);
    
        color("purple")
        translate([101.5, 215, 0])
        rotate(-12)
        c_curve(plate_thickness, 3, 100, 5);
        
        color("blue")
        translate([62, 105, 0])
        rotate(-23)
        c_curve(plate_thickness, 3, 177, 5.9);
        
        color("pink")
        translate([23, 20, 0])
        rotate(-35)
        c_curve(plate_thickness, 2, 33, 2);
        
        color("magenta")
        translate([1,226,0])
        basic();
        
    
        color("magenta")
        translate([32,226,0])
        basic();
        hull() {
            color("magenta")
            translate([50,226,0])
            basic();
            
            color("magenta")
            translate([93,176,0])
            basic();
            
            color("magenta")
            translate([93,282,0])
            basic();
            
                        
            color("magenta")
            translate([80,278,0])
            basic();
            
            color("magenta")
            translate([105,277,0])
            basic();
            
            color("magenta")
            translate([112,260,0])
            basic();
            
            color("magenta")
            translate([107,220,0])
            basic();
            
        }
        
        translate([30,215,0])
        rotate(27)
        cube([50,10,thickness]);
        
        hull() {
            color("blue")
            translate([72, 266, 0])
            basic();
            
            color("blue")
            translate([77, 275, 0])
            basic();
            color("blue")
            translate([111, 265, 0])
            basic();
            
            color("blue")
            translate([108, 273, 0])
            basic();
        }

        hull() {
                
                        
            translate([67,102,0])
            cylinder(r1=1,r2=1, h=plate_thickness);
            //top left chunk?
             tlc_y_trans = 1.5 + 57.25 + 28.25 + 73.75 + 14;
            tlc_x_trans = 92.58;
            tlc_width = 51.38;
            translate([0, tlc_y_trans, 0]) 
            cube([tlc_x_trans, tlc_width, thickness]);
            
            //second mid chunk
            smc_width = 32.66;
            smc_y_trans = tlc_y_trans - smc_width;
            smc_x_trans = 80.55;
            translate([0, smc_y_trans, 0])
            cube([smc_x_trans, smc_width, thickness]);
            
            //third mid chunk
            tmc_width = 62.17;
            tmc_y_trans = smc_y_trans - tmc_width;
            tmc_x_trans = 58.30;
            translate([0,  tmc_y_trans, 0])
            cube([tmc_x_trans, tmc_width, thickness]);
            
            //fourth mid chunk
            fmc_width = 37;
            fmc_x_trans = 40.46;
            fmc_y_trans = tmc_y_trans - fmc_width;
            translate([0, fmc_y_trans, 0])
            cube([fmc_x_trans, fmc_width, thickness]);
            
            //fifth mid chunk
            ffmc_width = 20;
            ffmc_x_trans = 27;
            ffmc_y_trans = fmc_y_trans - ffmc_width;
            translate([0, ffmc_y_trans, 0])
            cube([ffmc_x_trans, ffmc_width, thickness]);
            
            //sixth mid chunk
            stmc_width = 15.7;
            stmc_x_trans = 15.6;
            stmc_y_trans = ffmc_y_trans - stmc_width;
            translate([0, stmc_y_trans, 0])
            cube([stmc_x_trans, stmc_width, thickness]);
            
            //seventh mid chunk
            polyhedron(
                points = [
                    [0,0,0],
                    [0,0,thickness],
                    [0,stmc_y_trans,0],
                    [0,stmc_y_trans, thickness],
                    [stmc_x_trans, stmc_y_trans, 0],
                    [stmc_x_trans, stmc_y_trans, thickness]
                ],
                faces = [
                    [0,1,5,4],
                    [4,0,2],
                    [2,4,5,3],
                    [3,2,0,1],
                    [1,5,3]
                ],
                convexity = 1
            );
    }

    
}

module final() {
    difference() {
        plate(plate_thickness, total_length, total_width);
        cutouts();
    }
}

//cutouts();

//color("blue") plate(plate_thickness, total_length, total_width);
final();



