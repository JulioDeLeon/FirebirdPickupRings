plate_thickness = 2.06;
total_length = 113.0;
total_width = 278.0;

module curve(width, height, length, dh) {
    r = (pow(length/2, 2) + pow(dh, 2))/(2*dh);
    a = 2*asin((length/2)/r);
    translate([-(r -dh), 0, -width/2]) rotate([0, 0, -a/2])         rotate_extrude(angle = a) translate([r, 0, 0]) square(size = [height, width], center = true);
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
    translate([96.5, 272.45, 0]) screw();
    
    //cut away.
    translate([5, total_width + 8, 0]) cylinder(h=plate_thickness, r1 = 60.69, r2=60.69, $fn=360);
    
}

module border() {
    color("blue") difference() {
        cube([total_length + 10 , total_width + 10, plate_thickness]);
        cube([total_length , total_width, plate_thickness]);
        
    }
}

module plate(thickness, length, width) {
        hull() {
        //top right curve?
        trr = 20;
        translate([length - trr, width - trr, 0]) 
        cylinder(h=thickness, r1=trr, r2 = trr, $fn=360);
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
        fmc_x_trans = 39.46;
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
        
        
        // top right first mid chunk
        trfmc_y_trans = tlc_y_trans + tlc_width;
        trfmc_x_trans = 34.51;
        trfmc_length = 74.28;
        trfmc_width = 6.15;
        translate([trfmc_x_trans, trfmc_y_trans, 0])
        cube([trfmc_length, trfmc_width, thickness]);
    
    }
}

module final() {
    difference() {
        color("blue") plate(plate_thickness, total_length, total_width);
        cutouts();
    }
}

//cutouts();
//color("red") border();
//color("blue") plate(plate_thickness, total_length, total_width);
final();



