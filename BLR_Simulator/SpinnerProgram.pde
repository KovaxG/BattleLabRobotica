/*
 * An algorithm designed such that the robot spins on the table with variable radius.
 *
 * 2017.04.19 - Popescu Mihaela
 *
 */

public class SpinnerProgram extends Program {

  private boolean clockwiseDirection; //set to true if you want to turn the robot CLOCKWISE on the table

  public SpinnerProgram (Robot r, boolean clockwiseDirection) {
    super(r);
    this.clockwiseDirection = clockwiseDirection;
  }

  void setup() {
    // No need to set pinModes and stuff
    // Can be added later if required
  }

  float angularSpeedDeg = 10;
  float minRadius = 15;
  float radius = minRadius;
  float absIncrement = 0.2;
  float increment = absIncrement;

  void loop () {

    //verify if the robot reached the white line
    boolean border = digitalRead(lsPin1) || 
                     digitalRead(lsPin2) || 
                     digitalRead(lsPin3) || 
                     digitalRead(lsPin4);
    
    //decrease the radius when the robot reaches the white line
    if (border) {
     increment = -absIncrement;
    } 
    //increase the radius when the robot is in the centre of the table
    else if (radius < minRadius){
     increment = absIncrement;
    }
    
    //turn right or turn left to spin, depending on the direction of rotation
    radius+=increment;
    angularSpeedDeg-=increment/10;
    moveOnCircularTrajectory(clockwiseDirection, angularSpeedDeg, radius);
    Serial.println("radius: " + radius + ", angSpeed: " + angularSpeedDeg);
  }

} // End of Program