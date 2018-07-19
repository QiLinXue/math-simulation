int compassMode = -1; //1 = compass, -1 = ruler

void draw(){
    background(20);
    cDraw();
}

void keyPressed(){
    cKey();
}

void mousePressed(){
    cMouse();
}

boolean cActivated = false;
void cDraw(){
    if(cActivated){
        displayEverything();
        if(compassMode == 1) compassDisplay();
        if(compassMode == -1) rulerDisplay();
    }
}

void cKey(){
    if(key == ' ' && cActivated) compassMode *= -1;
}

void cMouse(){
    if(cActivated){
        if(compassMode == 1) switchCompassMode();
        if(compassMode == -1) switchRulerMode();
    }
}

float[][] compass = {};
float[][] ellipse = {};

int compassMode = 1;
float[] currentCo = {0,0};
float currentDist = 3;
void compassDisplay(){

    if(compassMode == 1){
        fill(255);
        currentCo[0] = mouseX;
        currentCo[1] = mouseY;
        ellipse(mouseX,mouseY,40,40);
        fill(0);
        ellipse(mouseX,mouseY,10,10);
    }

    if(compassMode == -1){
        noFill();
        stroke(255);
        strokeWeight(10);
        currentDist = 2*dist(currentCo[0],currentCo[1],mouseX,mouseY);
        ellipse(currentCo[0],currentCo[1],currentDist,currentDist);
    }
}

void switchCompassMode(){

    if(compassMode == 1){
        float[] array = {currentCo[0],currentCo[1]};
        ellipse = (float[][])append(ellipse,array);
    }

    if(compassMode == -1){
        float[] array = {currentCo[0],currentCo[1],currentDist};
        compass = (float[][])append(compass,array);
    }
    compassMode *= -1;


}

void switchRulerMode(){
    if(rulercompassMode == -1){
        float[] array = {currentCo[0],currentCo[1],mouseX,mouseY};
        ruler = (float[][])append(ruler,array);
    }
    rulercompassMode *= -1;
}

int rulercompassMode = 1;
float[][] ruler = {};
void rulerDisplay(){
    if(rulercompassMode == 1){
        fill(255);
        currentCo[0] = mouseX;
        currentCo[1] = mouseY;
        ellipse(mouseX,mouseY,40,40);
        fill(0);
        ellipse(mouseX,mouseY,10,10);
    }
    if(rulercompassMode == -1){
        stroke(255);
        strokeWeight(10);
        line(currentCo[0],currentCo[1],mouseX,mouseY);
    }
}

void displayEverything(){
    int length = ruler.length;
    for(int i=0;i<length;i++){
        stroke(255);
        strokeWeight(10);
        line(ruler[i][0],ruler[i][1],ruler[i][2],ruler[i][3]);
    }

    length = compass.length;
    for(int i = 0; i < length; i++){
        noFill();
        ellipse(compass[i][0],compass[i][1],compass[i][2],compass[i][2]);
    }

    length = ellipse.length;
    for(int i = 0; i < length; i++){
        fill(255);
        ellipse(ellipse[i][0],ellipse[i][1],20,20);
    }
}
