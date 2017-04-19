/*
 * A naive algorithm for line following.
 * The robot makes an initial turn and then moves along the white line.
 * 
 * 2017.04.18 - Popescu Mihaela
 *
 */

public class LineFollowerProgram extends Program {

  private boolean clockwiseDirection; //set to true if you want to turn the robot CLOCKWISE on the table

  public LineFollowerProgram (Robot r, boolean clockwiseDirection) {
    super(r);
    this.clockwiseDirection = clockwiseDirection;
  }

  void setup() {
    // No need to set pinModes and stuff
    // Can be added later if required
  }

  //the part of the robot which is touching the white border
  boolean frontBorder = false; //true when at least one front sensor is true
  boolean backBorder = false;  //true when at least one back sensor is true

  boolean wait = false;
  
  boolean beginning = true;
  float beginningRadius = 35;
  
  float linearSpeed = 1.5;
  float angularSpeedDeg = 10;
  float radius = 8;

  void loop () {

    //check which part of the robot touched the border
    if (!wait) {
      wait = true;
      setActiveBorder();
    } else {
      wait = false;
    }

    Serial.println("f:" + frontBorder + " b:" + backBorder);
    
    //at the beginning, the robot makes a soft turn
    if (beginning)
    {
      moveOnCircularTrajectory(clockwiseDirection, angularSpeedDeg/2, beginningRadius);
    }

    //the robot moves along the white line
    if (frontBorder) {
      //turn right or turn left to follow the line, depending on the direction of rotation
      moveOnCircularTrajectory(clockwiseDirection, angularSpeedDeg, radius);
    } else if (backBorder) {
      moveOnCircularTrajectory(!clockwiseDirection, angularSpeedDeg, radius);
    } else if (!beginning) {
      //go straight, when no line sensor is active
      motorControl(1, linearSpeed);
      motorControl(2, linearSpeed);
    }
  }

  private void setActiveBorder()
  {
    //verify which sensors are active and set the corresponding variables to true
    //aditionally, when the border is detected, set beginning = false
    if (digitalRead(lsPin1) || digitalRead(lsPin3)) {
      frontBorder = true;
      backBorder = false;
      beginning = false;
    } else if (digitalRead(lsPin2) || digitalRead(lsPin4)) {
      frontBorder = false;
      backBorder = true;
      beginning = false;
    } else {
      frontBorder = false;
      backBorder = false;
    }
  }
} // End of Program