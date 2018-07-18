Planet Mercury;
Planet Venus;
Planet Earth;
Planet Mars;
Planet Jupiter;
Planet Saturn;
Planet Uranus;
Planet Neptune;
Planet Halley;
Moon Moon;

Star sun;
void settings(){
        fullScreen(P3D);
}

void setup(){

    sun = new Star(695700,1.989E30,213,182,10);

      //plamet radius (km), mass (kg),periapsis (m), apoapsis (m), longitude of peripasis,orbital inclination
      Mercury = new Planet(2440,0.33011E24,4.6E10,6.982E10,77.46,7,sun.mass);
      Venus = new Planet(6052,4.8675E24,1.0748E11,1.0894E11,131.533,3.3947,sun.mass);
      Earth = new Planet(6357,5.972E24,1.471E11,1.521E11,102.9,0,sun.mass);
      Mars = new Planet(3390,6.39E23,2.066E11,2.492E11,336,1.85,sun.mass);
      Jupiter = new Planet(69911,1.898E27,7.4052E11,8.1662E11,14.75,1.304,sun.mass);
      Saturn = new Planet(60268,5.6834E26,1.35255E12,1.5145E12,92.43194,2.48446,sun.mass);
      Uranus = new Planet(25559,8.6813E25,2.7413E12,3.00362E12,170.96,0.76986,sun.mass);
      Neptune = new Planet(24764,1.02413E26,4.44445E12,4.54567E12,44.9713,1.76917,sun.mass);
      Halley = new Planet(6,2.2E14,8.766E10,5.2481925E12,111.33,1,sun.mass);
      Moon = new Moon(1737,7.348e22,3.633E8,4.055E8,318.15,5.1,Earth.mass,Earth.periapsis,Earth.apoapsis,Earth.periapsisLongitude,Earth.inclination,sun.mass);
}

//Settings to adjust the dimension of the planets
int timeticker = 0;
int orbitRadiusScaler = 600000000;
int planetSizeScaler = 600;

int spaceMode = 1; //0=homescreen, 1=solarSystem, 2=planetSystem

void draw(){

  //time ticker
  timeticker++; //global increment that increases each frame
  background(30);

  switch(spaceMode){
    case 1: solarSystem(); break;
  }
  fill(255);

}

void solarSystem(){

  sphereDetail(10);
  //pointLight(213,182,10, width/2, height/2, 0);

  pushMatrix(); //Begin Transformation
  translate(width/2,height/2); //Sets the center to the middle of the screen
  scale(solarSystemZoom);

  enableRotation();

  //Planet Orbit Lines
  Mercury.plotOrbit();
  Venus.plotOrbit();
  Earth.plotOrbit();
  Mars.plotOrbit();
  Jupiter.plotOrbit();
  Saturn.plotOrbit();
  Uranus.plotOrbit();
  Neptune.plotOrbit();
  Halley.plotOrbit();
  Moon.plotOrbit();

  //Star
  sun.plotBody();

  //Plane of Reference
  //noStroke();
  //ellipse(0,0,147,147);
  //stroke(200);
  //strokeWeight(1);

  //Planets
  Mercury.plotPlanet();
  Venus.plotPlanet();
  Earth.plotPlanet();
  Mars.plotPlanet();
  Jupiter.plotPlanet();
  Saturn.plotPlanet();
  Uranus.plotPlanet();
  Neptune.plotPlanet();
  Halley.plotPlanet();

  popMatrix(); //End Transformation. Anything put beyond this line will not be affected by rotation
}


boolean solarSystemNoClick = true; //The mouse is not being clicked down
float[] solarSystemSavedPositions = {0,0,0,0}; //{x-position,y-position,x-angle,y-angle}

//Function that allows everything to be rotated
void enableRotation(){
  //Conditions:
    //A translate function setting the origin to 500,500
    //Must be wrapped in pushMatrix() and popMatrix()

  if(mousePressed){

    //Since there are no booleans that differentiates between mouseClicked and mousePressed, here is a workaround with the global variable solarSystemNoClick
    if(solarSystemNoClick){ //Checks if the mouse is clicking (and not being held down)
      solarSystemNoClick = false; //the mouse is no longer clicking, it's being held down

      //Gives reference point to original position of mouse
      solarSystemSavedPositions[0] = mouseX;
      solarSystemSavedPositions[1] = -mouseY;
    }

    //Rotates EVERYTHING around the x and y axis by the current x and y position of the mouse
    rotateY(solarSystemSavedPositions[2]+radians((mouseX-solarSystemSavedPositions[0])/10.8)); //the 10.8 ensures it takes longer to rotate along y-axis
    rotateX(solarSystemSavedPositions[3]+radians((-mouseY-solarSystemSavedPositions[1])/5.4)); //the 5.4 ensures it's easier to rotate along x-axis to see orbital inclination

  } else{

    //Rotates EVERYTHING according to the last saved angle
    rotateY(solarSystemSavedPositions[2]);
    rotateX(solarSystemSavedPositions[3]);
  }
}

void mouseReleased(){
  //Saves positions when rotation is enabled
  if(solarSystemNoClick == false){ //Ensures this will only be called after rotation
    solarSystemSavedPositions[2] = solarSystemSavedPositions[2]+radians((mouseX-solarSystemSavedPositions[0])/10.8);
    solarSystemSavedPositions[3] = solarSystemSavedPositions[3]+radians((-mouseY-solarSystemSavedPositions[1])/5.4);

    solarSystemNoClick = true;
  }
}

float solarSystemZoom = -1;
float solarSystemIsScroll;

//BUG solarSystemZoom code has to be directly put under PhysicsAcademy.pde

void mouseWheel(MouseEvent event) {
  if(spaceMode==1){
    solarSystemIsScroll = event.getCount();
    solarSystemZoom = solarSystemZoom + (solarSystemIsScroll/20);
    if(solarSystemZoom>0){
      solarSystemZoom = solarSystemZoom - (solarSystemIsScroll/20);
    }
    //println(solarSystemZoom);
  }
}


void keyPressed(){
  Mercury.changeTimeWarp();
  Venus.changeTimeWarp();
  Earth.changeTimeWarp();
  Mars.changeTimeWarp();
  Jupiter.changeTimeWarp();
  Saturn.changeTimeWarp();
  Uranus.changeTimeWarp();
  Neptune.changeTimeWarp();
  Halley.changeTimeWarp();
  Moon.changeTimeWarp();
}
