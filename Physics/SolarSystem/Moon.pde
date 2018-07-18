class Moon{
  float objectRadius; //km
  float mass; //kg
  float periapsis; //m
  float apoapsis; //m
  float periapsisLongitude; //degrees
  float inclination; //degrees
  float planetMass; // kg
  float planetPE; // m
  float planetAP; // m
  float planetPeriapsisLongitude; //m
  float planetInclination; //m
  float starMass; // kg

  Moon(float tempobjectRadius, float tempMass, float tempPeriapsis, float tempApoapsis, float tempPeriapsisLongitude, float tempInclination,
       float tempPlanetMass, float tempPlanetPE, float tempPlanetAP, float tempPlanetPeriapsisLongitude, float tempPlanetInclination, float tempStarMass){
          objectRadius = tempobjectRadius;
          mass = tempMass;
          periapsis = tempPeriapsis;
          apoapsis = tempApoapsis;
          periapsisLongitude = tempPeriapsisLongitude;
          inclination = tempInclination;
          planetMass = tempPlanetMass;
          planetPE = tempPlanetPE;
          planetAP = tempPlanetAP;
          planetPeriapsisLongitude = tempPlanetPeriapsisLongitude;
          planetInclination = tempPlanetInclination;
          starMass = tempStarMass;


  }

  //Vital Lunar Facts
  float moonEccentricity(){
    return ((apoapsis-periapsis)/2)/(apoapsis+periapsis);
  }

  float moonSemiMajor(){
    return (apoapsis+periapsis)/2;
  }

  float moonSemiMinor(){
    return (moonSemiMajor()*sqrt(1-pow(moonEccentricity(),2)));
  }

  float moonPeriod(){
    return

      //Kepler's Third Law
      (2*PI*
        sqrt(
              (pow(moonSemiMajor(),3) //Gives the semi-major axis
              /
              (6.674e-11*planetMass)) //Gives the Standard Gravitational Parameter of the System
            )
      );
  }

  //Vital Planetary Facts
  float planetEccentricity(){
    return ((planetAP-planetPE)/2)/(planetAP+planetPE);
  }

  float planetSemiMajor(){
    return (planetAP+planetPE)/2;
  }

  float planetSemiMinor(){
    return (planetSemiMajor()*sqrt(1-pow(planetEccentricity(),2)));
  }

  float planetPeriod(){
    return

      //Kepler's Third Law
      (2*PI*
        sqrt(
              (pow(planetSemiMajor(),3) //Gives the semi-major axis
              /
              (6.674e-11*starMass)) //Gives the Standard Gravitational Parameter of the System
            )
      );
  }

  float planetAngle(){
    return
            ((timewarp * //Speeds everything up
               (timeticker/planetPeriod()) // percentage of the period completed so it can be transformed into an angle
               - differenceAngle)
               % 360
            ); //Transforms a percentage into an angle
  }

float moonOrbitRadiusScaler = 600000000;
  void plotOrbit(){
    stroke(255); //color of the orbit line
    noFill(); //ensures the ellipse is transparent
    strokeWeight(100*exp((3*solarSystemZoom)-1.5)+0.25); //calculated with a table of values at www.desmos.com/calculator/fz1zzieuwa

    pushMatrix(); //Begin transformation

    rotateZ(radians(planetPeriapsisLongitude)); //Matches its longitude of periapsis
    rotateX(radians(planetInclination)); //Matches its orbital inclination
    //periapsisLine();


    //The actual orbit
    translate(
               cos(radians(planetAngle())-radians(planetPeriapsisLongitude))* //x-angle of planet with respect to center body
               ((planetSemiMinor())/orbitRadiusScaler) //length magnitude of sateliite with respect to center body
               + (cos(radians(planetPeriapsisLongitude))*((planetAP-planetPE)/2))/orbitRadiusScaler //Adjustment from foci
               ,
               sin(radians(planetAngle())-radians(planetPeriapsisLongitude))* //y-angle of planet with respect to center body
               ((planetSemiMajor())/orbitRadiusScaler) //Length magnitude of planet with respect to center body
               + (sin(radians(planetPeriapsisLongitude))*((planetAP-planetPE)/2))/orbitRadiusScaler //Adjustment from foci
             );

    rotateZ(radians(periapsisLongitude)); //Matches its longitude of periapsis
    rotateX(radians(inclination)); //Matches its orbital inclination
    translate(    (cos(radians(periapsisLongitude))*((apoapsis-periapsis)/2))/orbitRadiusScaler,
                  (sin(radians(periapsisLongitude))*((apoapsis-periapsis)/2))/orbitRadiusScaler);

    if(key == 'a'){
      moonOrbitRadiusScaler = 30000000;
    } else{
      moonOrbitRadiusScaler = 600000000;
    }
    ellipse(
              0,0,
              (moonSemiMinor()*2)/moonOrbitRadiusScaler,
              (moonSemiMajor()*2)/moonOrbitRadiusScaler
           );

    popMatrix(); //End transformation
    strokeWeight(1);
  }

  //Time Warp
  float differenceAngle = 0;
  float solarSystemSavedAngle;
  float timewarp = 100000;

  void changeTimeWarp(){
    //println("works");
    solarSystemSavedAngle = planetAngle();

    if(key == '.'){
      timewarp = timewarp * 1.2;
    }
    if(key == ','){
      timewarp = timewarp / 1.2;
    }

    differenceAngle = differenceAngle + planetAngle() - solarSystemSavedAngle;


  }


}
