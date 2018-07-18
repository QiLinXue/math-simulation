Point A,B,C;
void setup(){
    C = new Point("C",2*width/5,height/2,50,false,false);
    A = new Point("A",3*width/5,height/2,50,false,false);
    B = new Point("B",width/2,2*height/5,50,false,false);

}

void settings(){
    fullScreen();
}

void draw(){
    background(20);

    //Regular Lines
    connectingLine(C,B,"A",4);
    connectingLine(A,B,"C",1);
    connectingLine(C,A,"B",6);

    //Median
    median();

    //GM circle
    gmcircle();


    //Draw Points
    A.renderAndMove();
    B.renderAndMove();
    C.renderAndMove();

    if(C.isMouseDragging()) A.x=C.x;
    if(A.isMouseDragging()) C.x=A.x;

    if(B.isMouseDragging()) C.y=B.y;
    if(C.isMouseDragging()) B.y=C.y;

    //Label
    textSize(80);
    fill(255);
    text("A: " + (abs(B.x-C.y)/100),8*width/9,height/20);
    text("B: " + (abs(A.y-C.y)/100),8*width/9,2*height/20);
    text("C: " + round(dist(B.x,B.y,A.x,A.y)*10)/1000.0,8*width/9,3*height/20);

    text("Median: " + dist(C.x,C.y,(A.x+B.x)/2,(A.y+B.y)/2)/100,8*width/9,4*height/20);
    //text("Angle B: " + atan(abs(A.y-C.y)/abs(B.x-C.y)),8*width/9,4*height/20);

}

void median(){
    stroke(255);
    strokeWeight(5);
    line(C.x,C.y,(A.x+B.x)/2,(A.y+B.y)/2);
}

void gmcircle(){
    float mean = sqrt(abs(A.y-C.y) * abs(C.x-B.x));
    noFill();
    stroke(255);
    strokeWeight(5);
    ellipse(C.x,C.y,2*mean,2*mean);
}
