class Particle{
    float charge,x,y;
    Particle(float tempCharge, int tempX, int tempY){
        charge = tempCharge;
        x = tempX;
        y = tempY;
    }
    void display(){
        //fill()
        if(charge > 0) fill(0,255,0);
        else if(charge < 0) fill(255,0,0);
        else if(charge == 0) fill(200);
        ellipse(x,y,50,50);
    }
}
