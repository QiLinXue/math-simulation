Point A, B, C, D, Z, P, M, N, X, Y;
void setup(){
    A = new Point("A",width/5,height/2,50,false,true);
    B = new Point("B",2*width/5,height/2,50,false,true);
    C = new Point("C",3*width/5,height/2,50,false,true);
    D = new Point("D",4*width/5,height/2,50,false,true);

    X = new Point("X",intersectionInfo()[0],intersectionInfo()[1],50,true,true);
    Y = new Point("Y",intersectionInfo()[0],intersectionInfo()[2],50,true,true);

    Z = new Point("Z",intersectionInfo()[0],height/2,50,true,true);
    P = new Point("P",intersectionInfo()[0],height/2-150,50,true,false);

    M = new Point("M",width/2,height/2,50,true,true);
    N = new Point("N",width/2,height/2,50,true,true);

}

void settings(){
    fullScreen();
}

int mode = 0;
/*
0: show everything
1: show only vital lines
2: show only vital lines but extend
*/

void draw(){
    background(20);

    noFill();
    stroke(255);
    strokeWeight(10);
    ellipse((A.x+C.x)/2,height/2,(A.x-C.x),(A.x-C.x));
    ellipse((B.x+D.x)/2,height/2,(B.x-D.x),(B.x-D.x));

    //Lines
    line(B.x,B.y,C.x,C.y); //BC
    cm(); //CM
    bn(); //BN
    line(A.x,A.y,M.x,M.y); //AM
    line(D.x,D.y,N.x,N.y); //DN

    if(mode == 2) ndExtended();
    if(mode == 2) amExtended();
    if(mode == 2) line(intersectionInfo()[0],0,intersectionInfo()[0],intersectionInfo()[2]);

    A.renderAndMove();
    B.renderAndMove();
    C.renderAndMove();
    D.renderAndMove();

    Z.x = intersectionInfo()[0];
    P.x = intersectionInfo()[0];

    circlesIntersectionDraw();
    if(mode != 1 && mode != 2) Z.renderAndMove();
    if(mode != 1 && mode != 2) P.renderAndMove();
    M.renderAndMove();
    N.renderAndMove();

    X.x = intersectionInfo()[0];
    X.y = intersectionInfo()[1];
    Y.x = intersectionInfo()[0];
    Y.y = intersectionInfo()[2];

    X.renderAndMove();
    Y.renderAndMove();

    if(P.y>intersectionInfo()[2]) P.y = intersectionInfo()[2];
    if(P.y<intersectionInfo()[1]) P.y = intersectionInfo()[1];

}

float[] intersectionInfo(){
    float r1 = pow((C.x-A.x)/2.0,2); //radius squared 1
    float r2 = pow((D.x-B.x)/2.0,2); //radius squared 2

    float o1 = ((C.x+A.x)/2); //center 1
    float o2 = ((D.x+B.x)/2); //center 2

    float xInt = (((r1-r2)+pow(o2,2)-pow(o1,2))
                 /
                 (2 * (o2-o1)));

    float yInt1 = height/2-sqrt(r2-pow(xInt-o2,2));
    float yInt2 = height/2+sqrt(r2-pow(xInt-o2,2));

    float[] array = {xInt,yInt1,yInt2};
    return array;
}

void circlesIntersectionDraw(){
    strokeWeight(10);
    stroke(255);
    line(intersectionInfo()[0],intersectionInfo()[1],intersectionInfo()[0],intersectionInfo()[2]);
}

void cm(){
    float oldx = C.x;
    float oldy = C.y;
    float dr = 0.01;

    strokeWeight(10);
    stroke(255);

    boolean lineInsideCircle = true;
    float newx, newy;
    while(lineInsideCircle){
        newx = oldx+(P.x-C.x)*dr;
        newy = oldy+(P.y-C.y)*dr;

        if(mode != 1 && mode != 2) line(oldx,oldy,newx,newy);
        oldx = newx;
        oldy = newy;

        if(dist(newx,newy,(C.x+A.x)/2,height/2)>(C.x-A.x)/2){
            lineInsideCircle = false;
            M.x = newx;
            M.y = newy;
        }
    }

}

void bn(){
    float oldx = B.x;
    float oldy = B.y;
    float dr = 0.01;

    strokeWeight(10);
    stroke(255);

    boolean lineInsideCircle = true;
    float newx, newy;
    while(lineInsideCircle){
        newx = oldx+(P.x-B.x)*dr;
        newy = oldy+(P.y-B.y)*dr;

        if(mode != 1 && mode != 2) line(oldx,oldy,newx,newy);
        oldx = newx;
        oldy = newy;

        if(dist(newx,newy,(D.x+B.x)/2,height/2)>(D.x-B.x)/2){
            lineInsideCircle = false;
            N.x = newx;
            N.y = newy;
        }
    }
}

void ndExtended(){
    float oldx = N.x;
    float oldy = N.y;
    float dr = 0.01;

    strokeWeight(10);
    stroke(255);

    float newx, newy;
    for(int i=0; i<1000; i++){
        newx = oldx+(N.x-D.x)*dr;
        newy = oldy+(N.y-D.y)*dr;

        line(oldx,oldy,newx,newy);
        oldx = newx;
        oldy = newy;

    }
}

void amExtended(){
    float oldx = M.x;
    float oldy = M.y;
    float dr = 0.01;

    strokeWeight(10);
    stroke(255);

    float newx, newy;
    for(int i=0; i<1000; i++){
        newx = oldx+(M.x-A.x)*dr;
        newy = oldy+(M.y-A.y)*dr;

        line(oldx,oldy,newx,newy);
        oldx = newx;
        oldy = newy;

    }
}
