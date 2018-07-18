/*
1) Show definition of "Power of a point": |pow(P,w)| = PA x PB
2) Explore the limits, and the different cases
2) Show POP Proof
    a) Case 1: Inside
    b) Case 2: Outside - Tangent
    c) Case 3: Outside - Secant (Normal)
3) Show Alternate POP Formula

Video key order: 1, T,
*/


Point A, B, P, C, D, O, X;
void setup(){
    A = new Point("A",2*width/5,height/2,50,false,false);
    B = new Point("B",3*width/5,height/2,50,false,false);
    P = new Point("P",width/2,height/5,50,false,false);
    C = new Point("C",width/2,height/2,50,true,true);
    D = new Point("D",width/2,height/2,50,true,true);
    O = new Point("O",width/2,height/2,50,true,true);
    X = new Point("X",width/2,height/2,50,true,true);
}

void settings(){
    fullScreen();
}

float diameter;

int mode = 2;
/*
1: normal
2: extend lines
3: similar triangles
4: only show points ABP
5: only show point P
6: only show point P and line PB
*/

int showText = -1;

void draw(){
    background(20);

    //Circle AB
    stroke(255);
    strokeWeight(10);
    noFill();
    diameter = 2*dist((B.x+A.x)/2,(B.y+A.y)/2,B.x,B.y);
    ellipse((B.x+A.x)/2,(B.y+A.y)/2,diameter,diameter);

    //Line PAt
    if(mode != 4 && mode != 5 && mode != 6 && mode != 7 && mode != 8) line(P.x,P.y,A.x,A.y);
    if(mode != 4 && mode != 5 && mode != 6 && mode != 7 && mode != 8) ac();
    if(mode == 2) acExtended();

    //Line PB
    if(mode != 4 && mode != 5 && mode != 6 && mode != 8) line(P.x,P.y,B.x,B.y);
    if(mode != 4 && mode != 5 && mode != 6 && mode != 8) bd();
    if(mode == 2) bdExtended();

    //Line AD && CB
    if(mode == 3){
        strokeWeight(5);
        line(A.x,A.y,D.x,D.y);
        line(C.x,C.y,B.x,B.y);
    }

    //Follow Mouse Line
    if(mode == 6) line(P.x,P.y,mouseX,mouseY);

    //Center
    if(mode == 8){
        line(O.x,O.y,P.x,P.y);
        ox();
        O.renderAndMove();
        X.renderAndMove();
        O.x = (A.x+B.x)/2;
        O.y = (A.y+B.y)/2;
    }

    //Draggable Points
    if(mode != 5 && mode != 6 && mode != 7 && mode != 8) A.renderAndMove();
    if(mode != 5 && mode != 6 && mode != 8) B.renderAndMove();
    P.renderAndMove();

    //Intersection Points
    if(mode != 4 && mode != 5 && mode != 6 && mode != 7 && mode != 8) C.renderAndMove();
    if(mode != 4 && mode != 5 && mode != 6 && mode != 8) D.renderAndMove();


    //Text
    textSize(50);
    fill(255);
    if(showText == 1){
        text("PC x PA: " + round(dist(P.x,P.y,C.x,C.y)*dist(P.x,P.y,A.x,A.y)/10000),8*width/9,height/20);
        text("PD x PB: " + round(dist(P.x,P.y,D.x,D.y)*dist(P.x,P.y,B.x,B.y)/10000),8*width/9,2*height/20);
    }

}

void ac(){
    float oldx = A.x;
    float oldy = A.y;
    float dr = 0.01;

    strokeWeight(10);
    stroke(255);

    boolean lineInsideCircle = true;
    float newx, newy;
    while(lineInsideCircle){
        newx = oldx+(P.x-A.x)*dr;
        newy = oldy+(P.y-A.y)*dr;

        line(oldx,oldy,newx,newy);
        oldx = newx;
        oldy = newy;

        if(dist(newx,newy,(A.x+B.x)/2,(A.y+B.y)/2)>diameter/2){
            lineInsideCircle = false;
            C.x = newx;
            C.y = newy;
        }
    }
}

void bd(){
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

        line(oldx,oldy,newx,newy);
        oldx = newx;
        oldy = newy;

        if(dist(newx,newy,(A.x+B.x)/2,(A.y+B.y)/2)>diameter/2){
            lineInsideCircle = false;
            D.x = newx;
            D.y = newy;
        }
    }
}

void ox(){
    float oldx = O.x;
    float oldy = O.y;
    float dr = 0.01;

    strokeWeight(10);
    stroke(255);

    boolean lineInsideCircle = true;
    float newx, newy;
    while(lineInsideCircle){
        newx = oldx+(P.x-O.x)*dr;
        newy = oldy+(P.y-O.y)*dr;

        line(oldx,oldy,newx,newy);
        oldx = newx;
        oldy = newy;

        if(dist(newx,newy,(A.x+B.x)/2,(A.y+B.y)/2)>diameter/2){
            lineInsideCircle = false;
            X.x = newx;
            X.y = newy;
        }
    }
}

void acExtended(){
    float oldx = A.x;
    float oldy = A.y;
    float dr = 0.01;

    strokeWeight(10);
    stroke(255);

    float newx, newy;

    for(int i=0; i<1000; i++){
        newx = oldx-(P.x-A.x)*dr;
        newy = oldy-(P.y-A.y)*dr;

        line(oldx,oldy,newx,newy);
        oldx = newx;
        oldy = newy;
    }
}

void bdExtended(){
    float oldx = B.x;
    float oldy = B.y;
    float dr = 0.01;

    strokeWeight(10);
    stroke(255);

    float newx, newy;

    for(int i=0; i<1000; i++){
        newx = oldx-(P.x-B.x)*dr;
        newy = oldy-(P.y-B.y)*dr;

        line(oldx,oldy,newx,newy);
        oldx = newx;
        oldy = newy;
    }
}

void keyPressed(){
    if(key == 't') showText *= -1;
    else mode = Character.getNumericValue((char)key);
}
