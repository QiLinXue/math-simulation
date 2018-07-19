/*

Please excuse my horrible coding skills. This was simply done to make a *quick* video


*/

Point O, C, B, D, E, P;
ContestInfo Info;

Text De, Eb, Ec, Radius, Radiusminusone, Form1, Form2, Form3;

void setup(){
    O = new Point("O",width/2,height/2,50,false,false);
    C = new Point("C",width/2,height/3,50,false,false);
    B = new Point("B",2*width,2*height,50,true,true);
    D = new Point("D",2*width,2*height,50,true,true);
    E = new Point("E",2*width,2*height,50,true,true);
    P = new Point("P",2*width,2*height,50,true,true);

    Info = new ContestInfo("1971 Canadian Math Olympiad - Problem #1","Let O be the center of the circle. BD is a chord of a circle such that the intersection between OC is called E. Given DE=3, EB=5 and EC=1, find the radius of the circle.");

    De = new Text("3",2*width,2*height,40);
    Eb = new Text("5",2*width,2*height,40);
    Ec = new Text("1",2*width,2*height,40);
    Radius = new Text("r",2*width,2*height,40);
    Radiusminusone = new Text("r-1",2*width,2*height,40);
    Form1 = new Text("(EP)(CE) = (BE)(ED)",2*width,2*height,80);
    Form2 = new Text("(r+r-1)(1) = (5)(3)",2*width,2*height,80);
    Form3 = new Text("2r-1 = 15",2*width,2*height,80);


}

void settings(){
    fullScreen();
}

void draw(){
    background(20);
    Info.display();

    stroke(255);
    strokeWeight(10);

    noFill();
    ellipse(O.x,O.y,2*dist(C.x,C.y,O.x,O.y),2*dist(C.x,C.y,O.x,O.y));

    line(O.x,O.y,C.x,C.y);

    if(counter == 2) line(B.x,B.y,mouseX,mouseY);
    if(counter >= 3) line(D.x,D.y,B.x,B.y);
    if(counter > 7) line(O.x,O.y,newx,newy);

    O.renderAndMove();
    E.renderAndMove();
    B.renderAndMove();
    C.renderAndMove();
    D.renderAndMove();
    P.renderAndMove();

    De.display();
    Eb.display();
    Ec.display();
    Radius.display();
    Radiusminusone.display();

    Form1.display();
    Form2.display();
    Form3.display();

}

int counter = 1;
float newx, newy;
void keyPressed(){
    if(keyCode == TAB){
        if(counter == 1){
            B.x = mouseX;
            B.y = mouseY;
        }
        if(counter == 2){
            D.x = mouseX;
            D.y = mouseY;
        }
        if(counter == 3){
            E.x = mouseX;
            E.y = mouseY;
        }
        if(counter == 4){
            De.x = mouseX;
            De.y = mouseY;
        }
        if(counter == 5){
            Eb.x = mouseX;
            Eb.y = mouseY;
        }
        if(counter == 6){
            Ec.x = mouseX;
            Ec.y = mouseY;
        }
        if(counter == 7){
            newx = O.x-(C.x-O.x);
            newy = O.y-(C.y-O.y);

            line(O.x,O.y,newx,newy);
            P.x = newx;
            P.y = newy;
        }
        if(counter == 8){
            Radius.x = mouseX;
            Radius.y = mouseY;
        }
        if(counter == 9){
            Radiusminusone.x = mouseX;
            Radiusminusone.y = mouseY;
        }
        if(counter == 10){
            Form1.x = mouseX;
            Form1.y = mouseY;
        }
        if(counter == 11){
            Form2.x = mouseX;
            Form2.y = mouseY;
        }
        if(counter == 12){
            Form3.x = mouseX;
            Form3.y = mouseY;
        }
        counter++;
    }
    else if(keyCode == ENTER){
        saveFrame("screenshot####.png");
    }
    else if(key == 'r') counter = 0;
}
