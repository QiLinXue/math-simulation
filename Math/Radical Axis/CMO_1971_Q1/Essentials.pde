boolean somethingIsDragging = false;
class Point{
    float x,y,size;
    boolean draggable = false;
    boolean xlock, ylock;
    String label;

    Point(String tempLabel, float startX, float startY, float tempSize, boolean tempXlock, boolean tempYlock){
        x = startX;
        y = startY;
        size = tempSize;
        xlock = tempXlock;
        ylock = tempYlock;
        label = tempLabel;
    }

    void show(){
        fill(255);
        ellipse(x,y,size,size);


        textAlign(CENTER,CENTER);
        textSize(30);
        fill(255,0,0);
        text(label,x,y);
    }

    void move(){
        if(dist(x,y,mouseX,mouseY) < size && mousePressed && !somethingIsDragging){
            draggable = true;
            somethingIsDragging = true;
        }
        else if(!mousePressed){
            draggable = false;
            somethingIsDragging = false;
        }
        if(draggable){
            if(!xlock) x = mouseX;
            if(!ylock) y = mouseY;
        }
    }

    void renderAndMove(){
        show();
        move();
    }
}

class ContestInfo{
    String title;
    String description;
    ContestInfo(String tempTitle, String tempDescription){
        title = tempTitle;
        description = tempDescription;
    }
    void display(){
        fill(255);
        textAlign(CENTER,CENTER);

        textSize(100);
        text(title,width/2,height/20);

        textSize(50);
        textAlign(CENTER,TOP);
        text(description,0,2*height/20,width,height);
    }
}

class Text{
    String text;
    float x,y;
    float size;
    Text(String tempText, float tempx, float tempy, float tempSize){
        text = tempText;
        x = tempx;
        y = tempy;
        size = tempSize;
    }
    void display(){
        fill(255);
        textAlign(CENTER,CENTER);

        textSize(size);
        text(text,x,y);
    }
}
