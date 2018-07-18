int mode = 0;
int movingParticleNumber;
Particle[] particleList = new Particle[0];

void setup(){
    Particle[] temp = particleList;
    particleList = (ElectricField.Particle[])append(temp,new Particle(1,mouseX,mouseY));
    size(800,800);
}

void settings(){
    fullScreen();
}

void draw(){
    background(20);

    int i=0;
    for(Particle p: particleList){
        i++;
        if(!doesListContainInt(ignoreList,i)) p.display();
    }
    movingParticleNumber = particleList.length-1;
    particleList[movingParticleNumber].x = mouseX;
    particleList[movingParticleNumber].y = mouseY;

    //displayArrow();

}

void mousePressed(){
    Particle[] temp = particleList;
    particleList = (ElectricField.Particle[])append(temp,new Particle(temp[temp.length-1].charge,mouseX,mouseY));
}

int[] ignoreList = {-1};

void keyPressed(){
    if(particleList[movingParticleNumber].charge != 0) particleList[movingParticleNumber].charge *= -1;
    else particleList[movingParticleNumber].charge = 1;

    if(keyCode == BACKSPACE){
        int[] temp = ignoreList;
        ignoreList = append(temp,particleList.length-ignoreList.length);
    }

    if(keyCode == ENTER){
        noCursor();
        saveFrame("/screenshots/simulation-####.png");
        cursor();
        Particle[] temp = particleList;
        particleList = (ElectricField.Particle[])append(temp,new Particle(temp[temp.length-1].charge,mouseX,mouseY));
    }
}

boolean doesListContainInt(int[] list, int whatToFind){
    for(int i: list){
        if(i == whatToFind) return true;
    }
    return false;
}
