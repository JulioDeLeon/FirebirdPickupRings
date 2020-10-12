plate_length = 102;
plate_width = 44.95;
plate_depth = 2.30;
pickup_length = 67.4;
pickup_width = 29.3;

screw_diam = 2.75;
screw_offset = 3.7 + (screw_diam/2);

module screw_hole() {
    diam = screw_diam;
    depth = plate_depth;
    cylinder(h = depth, d1 = diam, d2 = diam, $fn = 360);
}

module plate(l, w, d) {
    difference() {
        cube([l,w,d]);
        //top left
        translate([screw_offset, w - screw_offset , 0]) screw_hole();
        //top right
        translate([l - screw_offset, w- screw_offset, 0]) screw_hole();
        //bottom left
        translate([screw_offset, screw_offset, 0]) screw_hole();
        //bottom right
        translate([l - screw_offset, screw_offset, 0]) screw_hole();
    };
}


module pickup_plate(
    plate_l,
    plate_w,
    plate_d,
    pu_l,
    pu_w
) {    
    l_offset = (plate_length - pu_l) / 2;
    
    w_offset = (plate_width - pu_w) / 2;  
    
    difference() {
        plate(plate_l, plate_w, plate_d);
        translate([l_offset, w_offset, 0]) cube([pu_l, pu_w, plate_d]);
        
        // left 
        translate([l_offset - 5, w_offset + (pu_w / 2), 0]) screw_hole();
        
        // right
        translate([l_offset + pu_l + 5, w_offset + (pu_w / 2), 0]) screw_hole();
        
    }
}


pickup_plate(
    plate_length,
    plate_width,
    plate_depth,
    pickup_length,
    pickup_width
);