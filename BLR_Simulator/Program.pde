/*
 * A program that controls a robot. This is an abstract class that needs to be implemented by other 
 * derivative classes such as the TestProgram class, that hopefully exists somewhere.
 * 2017.04.14 - Kovacs Gyorgy
 */

public abstract class Program {
  
  protected Robot robot; // A reference to the robot
  
  // Serial object that you can use to print to the console
  SERIAL Serial = new SERIAL(); 
  
  // The pins are declared here
  protected int lsPin1 = 1;
  protected int lsPin2 = 2;
  protected int lsPin3 = 3;
  protected int lsPin4 = 4;
  
  public Program(Robot r) {
    robot = r;
  }
  
  // These two functions run just as on the arduino
  abstract void setup();
  abstract void loop();
  
  // If you want to read a digital pin, you can use this function
  protected boolean digitalRead(int pin) {
    
    boolean value = false;
    
    switch(pin) {
    case 1: value = robot.ls1.read(); break;
    case 2: value = robot.ls2.read(); break;
    case 3: value = robot.ls3.read(); break;
    case 4: value = robot.ls4.read(); break;
    default: value = false; break;
    }
    
    return value;
  }
  
  // If you want to set the speed and the direction of a motor, you can do it
  // using this method
  protected void motorControl(int nr, float speed) {
    if (nr == 1) robot.rWheelForce = speed;
    else         robot.lWheelForce = speed;
  }
  
  // Used for printing stuff.
  // Better than writing System.out every time.
  class SERIAL {
    public void print(String s) {
      System.out.print(s);
    }
    
    public void println(String s) {
      print(s + "\n");
    }
  } // End of Class SERIAL
} // End of Class Program