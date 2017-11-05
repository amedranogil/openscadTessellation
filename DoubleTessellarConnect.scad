include <shapes.scad>

module tessellarDoubleConnect(d,ch,t=0,zt=0,sides=4,deltaAngle=0){
    D=360/sides;
    zt = zt==0? t:zt;
    difference(){
        union(){
            children(0);
            for (a = [deltaAngle:D:359+deltaAngle]) {
                rotate([0,0,a]) 
                    translate([-d/2,0,0]) 
                        linear_extrude(height=ch) children(1);
            }
        }
        for (a = [deltaAngle:D:359+deltaAngle]) {
                rotate([0,0,a]) 
                  translate([-d/2,0,0]) 
                  mirror([0,1,0]) mirror([1,0,0]) 
                        linear_extrude(height=ch+zt ) 
                            offset(delta=t) children(1);
        }
    }
}

/*
 * Tile Parameters
 */
NSides=4;
SideLength=20;
Height=2;
Roundness=0.7;

/*
 * Conenction
 */
ConnectionGeometry="puzzle"; //[triangle,puzzle,rectangle,loop]
ConnectionRatio=0.5;//(0,1]
ConnectionDelta=7; // only for "double" ConnectionType
ConnectionTolerance=0.4; // clearence for bigger negative section
ConnectionVTolerance=0.7; // Vertical clearence for bigger negative section
ConnectorSize=4;

R=R2a(polySide2R(SideLength,NSides),NSides);

tessellarDoubleConnect(R*2,Height*ConnectionRatio,t=ConnectionTolerance,zt=ConnectionVTolerance,sides=NSides,deltaAngle=(NSides % 2 +1) * 180/(NSides)){
    roundedPolygon(SideLength,Height,NSides,Roundness,$fn=24);
    
    translate([0,ConnectionDelta/2,0])
    if(ConnectionGeometry=="triangle"){
        triangleCon(ConnectorSize);
    }
    else if(ConnectionGeometry=="puzzle"){
        puzzleCon(ConnectorSize);
    }
    else if(ConnectionGeometry=="rectangle"){
        rectangleCon(ConnectorSize);
    }
}

