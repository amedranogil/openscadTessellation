include <shapes.scad>

module tessellarConnect(d,possitive,negative=[],t=0,deltaAngle=0){
    sides=len(possitive);
    D=360/sides;
    difference(){
        union(){
            children(0);
            for (a = [0:sides-1]) {
                if(possitive[a] == 1){
                    rotate([0,0,180+a*D+deltaAngle]) 
                        translate([-d/2,0,0]) 
                            children(1);
                }
            }
        }
        for (a = [0:sides-1]) {
                if((len(negative)==0 && possitive[a] ==0) 
                    || (len(negative)>0 && negative[a] == 1)){
                    rotate([0,0,a*D+deltaAngle]) 
                        translate([d/2,0,0]) 
                            scale(1+t)
                                children(1);
                }
        }
    }
}

/*
 * Tile Parameters
 */
Positive=[1,0,1];
Negative=[];
SideLength=20;
Height=1.5;
Roundness=1;

/*
 * Conenction
 */
ConnectionGeometry="puzzle"; //[triangle,puzzle,rectangle,loop]
ConnectionRatio=1.01;//(0,1]
ConnectionDelta=0; // only for "double" ConnectionType
ConnectionTolerance=0.02; // percentage for making the negative part bigger
ConnectorSize=5;

NSides=len(Positive);

R=R2a(polySide2R(SideLength,NSides),NSides);

tessellarConnect(R*2,Positive,Negative,t=ConnectionTolerance,deltaAngle= 180/(NSides)){
    roundedPolygon(SideLength,Height,NSides,Roundness);
    
    if(ConnectionGeometry=="triangle"){
        triangleCon(ConnectorSize,Height*ConnectionRatio);
    }
    else if(ConnectionGeometry=="puzzle"){
        puzzleCon(ConnectorSize,Height*ConnectionRatio);
    }
    else if(ConnectionGeometry=="rectangle"){
        rectangleCon(ConnectorSize,Height*ConnectionRatio);
    }
}