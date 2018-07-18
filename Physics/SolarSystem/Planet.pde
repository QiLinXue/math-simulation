class Planet{
  float objectRadius; //km
  float mass; //kg
  float periapsis; //m
  float apoapsis; //m
  float periapsisLongitude; //degrees
  float inclination; //degrees
  float centerMass; // kg

  PVector orbit; // (angle, magnitude of length from star)


  Planet(float tempobjectRadius, float tempMass, float tempPeriapsis, float tempApoapsis, float tempPeriapsisLongitude, float tempInclination, float tempCenterMass){
    objectRadius = tempobjectRadius;
    mass = tempMass;
    periapsis = tempPeriapsis;
    apoapsis = tempApoapsis;
    periapsisLongitude = tempPeriapsisLongitude;
    inclination = tempInclination;
    centerMass = tempCenterMass;
  }

  //Vital Planetary Facts
  float eccentricity(){
    return ((apoapsis-periapsis)/2)/(apoapsis+periapsis);
  }

  float semiMajor(){
    return (apoapsis+periapsis)/2;
  }

  float semiMinor(){
    return (semiMajor()*sqrt(1-pow(eccentricity(),2)));
  }

  float period(){
    return

      //Kepler's Third Law
      (2*PI*
        sqrt(
              (pow(semiMajor(),3) //Gives the semi-major axis
              /
              (6.674e-11*centerMass)) //Gives the Standard Gravitational Parameter of the System
            )
      );
  }

  float angle(){
    return
            ((timewarp * //Speeds everything up
               (timeticker/period()) // percentage of the period completed so it can be transformed into an angle
               - differenceAngle)
               % 360
            ); //Transforms a percentage into an angle
  }

  float altitude(float angle){
    //Using an adaptation of Kepler's Equation
    //r^3=(GM*T^2)/4pi^2
    //The bottom only works for circular orbits
    /*
    return (
      pow(
        (((6.674e-11*centerMass)  //Standard Gravitational Parameter
          *
          pow(period(),2)) //Period Squared
        /
        (4*pow(PI,2))) //4pi^2
        ,
       0.3333) //Cube Rooted
    );*/

    //Using trigonometry with polar coordinates
    // To prove this, first start with the cartesian equation of ellipse
    // x^2/a^2 + y^2/b^2 = 1
    // x^2 * b^2 + y^2 * a^2 = a^2 & b^2
    // Replace x = r cos(θ) and y = r sin(θ) to move it into the polar coordinates
    // r = ab/sqrt(a^2 * sin^2(θ) + b^2 * cos^2(θ))
    /*
    return(
        (periapsis*apoapsis)
        /
        sqrt(
          pow(apoapsis,2)*pow(cos(radians(angle)),2)+pow(periapsis,2)*pow(sin(radians(angle)),2)
        )
      );
    */

    return(
        (semiMajor()*(1-pow(eccentricity()*2,2)))
        /
        (1+(eccentricity()*2*cos(radians(180-angle()))))
        );
  }

  float angularvelocity(){
    //Vis-Viva Equation
    //sqrt(μ*[(2/r)-(1/a)])
    return (
      sqrt(
        (6.674e-11*centerMass) // standard gravitational Parameter
        *
        (
          (2/altitude(angle())) // 2/r
          -
          (1/(semiMajor())) // 1/a
        )
      )
      );
  }

  void periapsisLine(){
    pushMatrix();
    translate(              (cos(radians(periapsisLongitude))*(apoapsis-periapsis)/2)/orbitRadiusScaler,
              (sin(radians(periapsisLongitude))*(apoapsis-periapsis)/2)/orbitRadiusScaler);
    //fill(0);
    //ellipse(0,0,100,100);
    //noFill();
    line(0,0,(cos(radians(periapsisLongitude-90))*semiMinor())/orbitRadiusScaler,(sin(radians(periapsisLongitude-90)) *semiMajor())/orbitRadiusScaler);
    popMatrix();
  }


  //Plotting Things Out
  void plotPlanet(){

    pushMatrix(); //Begin transformation
    rotateZ(radians(periapsisLongitude)); //Matches its longitude of periapsis
    rotateX(radians(inclination)); //Matches its orbital inclination

    //Transforms the planet according to the current angle and its orbital properties
    translate(
               cos(radians(angle())-radians(periapsisLongitude))* //x-angle of planet with respect to center body
               ((semiMinor())/orbitRadiusScaler) //length magnitude of sateliite with respect to center body
               + (cos(radians(periapsisLongitude))*((apoapsis-periapsis)/2))/orbitRadiusScaler //Adjustment from foci
               ,
               sin(radians(angle())-radians(periapsisLongitude))* //y-angle of planet with respect to center body
               ((semiMajor())/orbitRadiusScaler) //Length magnitude of planet with respect to center body
               + (sin(radians(periapsisLongitude))*((apoapsis-periapsis)/2))/orbitRadiusScaler //Adjustment from foci
             );

    //stroke(0); //Gives the stroke color of the sphere details
    noStroke();
    sphereDetail(20);
    fill(153,50,204); //pinkish color
    if(key=='s'){
      sphere(objectRadius/orbitRadiusScaler);
    } else{
      sphere(objectRadius/planetSizeScaler); //Actual planet itself
    }
    stroke(1);
    popMatrix(); //Ends transformation
  }

  void plotOrbit(){
    stroke(255); //color of the orbit line
    noFill(); //ensures the ellipse is transparent
    strokeWeight(100*exp((3*solarSystemZoom)-1.5)+0.25); //estimated with a table of values at www.desmos.com/calculator/fz1zzieuwa

    pushMatrix(); //Begin transformation

    rotateZ(radians(periapsisLongitude)); //Matches its longitude of periapsis
    rotateX(radians(inclination)); //Matches its orbital inclination
    //periapsisLine();


    //The actual orbit
    translate(    (cos(radians(periapsisLongitude))*((apoapsis-periapsis)/2))/orbitRadiusScaler,
                  (sin(radians(periapsisLongitude))*((apoapsis-periapsis)/2))/orbitRadiusScaler);

    ellipse(
              0,0,
              (semiMinor()*2)/orbitRadiusScaler,
              (semiMajor()*2)/orbitRadiusScaler
           );

    popMatrix(); //End transformation
    strokeWeight(1);
  }

  //Debugging
  void displayFacts(){
    println(angle(),altitude(angle()));
    //line(0,0,(cos(radians(180+periapsisLongitude))*periapsis)/orbitRadiusScaler,(sin(radians(180+periapsisLongitude))*periapsis)/orbitRadiusScaler);
  }


  //Time Warp
  float differenceAngle = 0;
  float solarSystemSavedAngle;
  float timewarp = 100000;

  void changeTimeWarp(){
    //println("works");
    solarSystemSavedAngle = angle();

    if(key == '.'){
      timewarp = timewarp * 1.2;
    }
    if(key == ','){
      timewarp = timewarp / 1.2;
    }

    differenceAngle = differenceAngle + angle() - solarSystemSavedAngle;


  }

}
