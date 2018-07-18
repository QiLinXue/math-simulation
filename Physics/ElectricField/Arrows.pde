void displayArrow(float x, float y, float electricX, float electricY){
    fill(255);
    stroke(255);

    float lengthX = 0,lengthY = 0;
    if(mode == 0){
        lengthX = log(abs(electricX))*8;
        lengthY = log(abs(electricY))*8;
    }
    else if(mode == 1){
        lengthX = spacing/1.5;
        lengthY = spacing/1.5;
    }

    float magnitude = sqrt(electricX*electricX+electricY*electricY);
    colorMode(HSB,255,99,99);
    stroke(magnitude+25,99,99);
    colorMode(RGB,255,255,255);

    if(electricX < 0) lengthX *= -1;
    if(electricY < 0) lengthY *= -1;

    float angle = atan(lengthY/lengthX);
    if(lengthX < 0) angle += PI;
    drawArrow(x,y,x+lengthX,y+lengthY,angle);
    //line(x,y,x+lengthX,y+lengthY);
    //triangle(x+lengthX,y+lengthY,x+lengthX+5,y+lengthY+5,x+lengthX-5,y+lengthY-5);

}

int spacing = 75;
void displayArrow(){
    for(int i = 0; i < width; i += spacing){
        for(int j = 0; j < height; j += spacing){
            float electricX=0;
            float electricY=0;
            //ellipse(i,j,5,5);

            int k=0;
            for(Particle p : particleList){
                k++;
                if(!doesListContainInt(ignoreList,k)){
                    electricX += superPose(i,j,p)[0];
                    electricY += superPose(i,j,p)[1];
                }
            }

            displayArrow(i,j,electricX,electricY);
        }
    }


}

float[] superPose(int i, int j, Particle p){
    float electricX,electricY;
    if(i<p.x){
        electricX = -electricField(p.charge,p.x,p.y,i,j)[0];
        electricY = -electricField(p.charge,p.x,p.y,i,j)[1];
    }
    else{
        electricX = electricField(p.charge,p.x,p.y,i,j)[0];
        electricY = electricField(p.charge,p.x,p.y,i,j)[1];
    }
    float[] output = {electricX,electricY};
    return output;
}

float[] electricField(float q, float qx, float qy, float x, float y){
    float r = dist(qx,qy,x,y);
    float angle = atan((y-qy)/(x-qx));
    float e = q/(r*r);

    float e_x = e*cos(angle)*1E7;
    float e_y = e*sin(angle)*1E7;

    float[] output = {e_x,e_y};
    return output;
}

void drawArrow(float cx, float cy, float x, float y, float angle){
  line(cx,cy,x,y);
  pushMatrix();
  translate(x, y);
  rotate(angle);
  line(0, 0, 0 - 8, -8);
  line(0, 0, 0 - 8, 8);
  popMatrix();
}
