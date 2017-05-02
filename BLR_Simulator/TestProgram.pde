/*
 * An example of an implementation of a program running on the controller.
 * You can (ought to really) try to implement a control for the robot, just to
 * see how the robot will behave.
 * 2017.04.14 - Kovacs Gyorgy
 *
 * PLS Don't change or remove this file, instead just add another file, like the EmptyProgram class 
 */

public class TestProgram extends Program {
  
  public TestProgram(Robot r) {
    super(r);
  }
  
  void setup() {
    // No need to set pinModes and stuff
    // Can be added later if required
  }
  
  boolean upperBorder = false;
  boolean lowerBorder = true;
  boolean wait = false;
  float speed = 1;
  
  void loop () {
    boolean border = digitalRead(lsPin1) || 
                     digitalRead(lsPin2) || 
                     digitalRead(lsPin3) || 
                     digitalRead(lsPin4);
    
    if (border && !wait) {
      wait = true;
      if (lowerBorder) {
        lowerBorder = false;
        upperBorder = true;
      }
      else {
        lowerBorder = true;
        upperBorder = false;
      }
    }
    else if (!border){
      wait = false;
    }
    
    Serial.println(lowerBorder + " " + upperBorder);
    
    if (lowerBorder) {
      motorControl(1, speed);
      motorControl(2, speed);
    }
    else {
      motorControl(1, -speed);
      motorControl(2, -speed);
    }
  }
} // End of Program