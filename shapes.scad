function polySide2R(side,n) = side/(2*sin(180/n));
function R2a(R,n) = R*cos(180/n);

module roundedPolygon(side, h,sides=4,r=1){
    H = r / cos(180/sides);
    linear_extrude(height=h)
    offset(r = r)
        circle(polySide2R(side,sides)-H,$fn=sides);
}

module regularPolygon(side,h, sides=4){
    cylinder(r=polySide2R(side,sides),h=h,$fn=sides);
}

//roundedPolygon(10,2,6,3);
//translate([0,0,2])regularPolygon(10,2,6);

module puzzleCon(s,$fn=15){
    h = 1;
    projection()
    difference(){
        union(){
        translate([-s*3/4,0,0]) scale([1,1.25,1]) cylinder(d=s,h=h);
        translate([-s/2,-s/2,0]) cube([s/2,s,h]);
        }
        translate([-s/4,-s/2,0]) cylinder(r=s/4,h=h);
        translate([-s/4,+s/2,0]) cylinder(r=s/4,h=h);
    }
}

module triangleCon(ConnectorSize){
    translate([-ConnectorSize/4,0,0]) circle(d=ConnectorSize,$fn=3);
}

module rectangleCon(ConnectorSize){
    h=1;
    projection()
    mirror([1,0,0]) union(){
                translate([0,-ConnectorSize/4,0]) 
                cube([ConnectorSize/2,ConnectorSize/2,h]);
                translate([ConnectorSize/2,-ConnectorSize/2,0])
                cube([ConnectorSize/2,ConnectorSize,h]);
            };
}
