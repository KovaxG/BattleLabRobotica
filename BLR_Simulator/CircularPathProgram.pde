/*
 * A simple implementation of a line sensor based control.
 * The robot moves on a circular trajectory when it detects the white line
 * in order to avoid getting out of the table
 *
 * Theoretical aspects can be found here: 
 * https://chess.eecs.berkeley.edu/eecs149/documentation/differentialDrive.pdf
 * 
 * 2017.04.17 - Popescu Mihaela
 *
 */

public class CircularPathProgram extends Program {

  private float angularSpeedDeg; //eg. 2 DEG/sec
  private float radius;          //eg. 60 cm
  
  public CircularPathProgram(Robot r, float angularSpeedDeg, float radius) {
    super(r);
    this.angularSpeedDeg = angularSpeedDeg;
    this.radius = radius;
  }

  void setup() {
    // No need to set pinModes and stuff
    // Can be added later if required
  }

  boolean wait = false;
  float linearSpeed = 1;

  //the part of the robot which is touching the white border
  boolean frontBorder = false; //true when at least one front sensor is true
  boolean backBorder = false;  //true when at least one back sensor is true

  //params used to turn the robot
  boolean turnLeft = true;   //left should be false and right should be true, but it's a temporary fix until the motors bug is fixed
  boolean turnRight = false; 
 
  void loop () {
    boolean border = digitalRead(lsPin1) || 
                     digitalRead(lsPin2) || 
                     digitalRead(lsPin3) || 
                     digitalRead(lsPin4);

    //check which part of the robot touched the border
    if (border && !wait) {
      wait = true;
      setActiveBorder();
    } else if (!border) {
      wait = false;
    }

    Serial.println("f:" + frontBorder + " b:" + backBorder);

    if (frontBorder) {
      moveOnCircularTrajectory(turnLeft, -angularSpeedDeg, radius);
    } else if (backBorder) {
      moveOnCircularTrajectory(turnRight, angularSpeedDeg, radius);
    } else {
      motorControl(1, linearSpeed);
      motorControl(2, linearSpeed);
    }
  }

  private void setActiveBorder()
  {
    //verify which sensors are active and set the corresponding variables to true
    if (digitalRead(lsPin1) || digitalRead(lsPin3)) {
      frontBorder = true;
      backBorder = false;
    } else if (digitalRead(lsPin2) || digitalRead(lsPin4)) {
      frontBorder = false;
      backBorder = true;
    }
  }

  public void moveOnCircularTrajectory(boolean direction, float angularSpeedDeg, float radius)
  {
    //method to move the robot on a circular trajectory   
    //direction = true to turn right, and false to turn left 

    float rightSpeed;
    float leftSpeed;

    //convert the angular speed (DEG/s -> RAD/s)
    float angularSpeedRad = angularSpeedDeg/180*3.14;

    //compute the linear speed for the left and the right wheel, depending on the direction
    if (direction)
    {
      rightSpeed = (radius-robot.getSize()/2) * angularSpeedRad;
      leftSpeed = (radius+robot.getSize()/2) * angularSpeedRad;
    } else
    {
      rightSpeed = (radius+robot.getSize()/2) * angularSpeedRad;
      leftSpeed = (radius-robot.getSize()/2) * angularSpeedRad;
    }

    //send the command to the two motors
    motorControl(1, rightSpeed);
    motorControl(2, leftSpeed);
  }
  
} // End of Program