total_width = 117.25;
total_length = 53.48;
thickness = 2.3;

module screw_hole() {
    cylinder(r1=2.0/2, r2=3.0/2, h=thickness, $fn=360);
}

module block() {
    cube([total_length, total_width, thickness]);
}

module screw_holes() {
    sll = 23.14;
    w_offset = 5.66;
    translate([sll, w_offset, 0]) screw_hole();
    translate([sll+ 20.89, w_offset, 0]) screw_hole();
    translate([15.5, 102.25,0]) screw_hole();
}

module final() {
    difference() {
        block();
        screw_holes();
    }
};

final();