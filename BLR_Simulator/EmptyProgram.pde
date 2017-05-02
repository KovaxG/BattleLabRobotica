/*
 * YOU, yes YOU. Your code goes here.
 */

public class EmptyProgram extends Program {
  public EmptyProgram(Robot r) {super(r);} // Don't mind me
  
  void setup() {
    // You don't have to set the pinMode, it is already set.
    
    // To make this the program that runs on the robot, change this line from 
    // BLR_Simulator:
    
    /* program = new TestProgram(optimus); */
    
    // Change the line to:
    
    /* program = new EmptyProgram(optimus) */
    
    // That's it.
  }
  
  void loop() {
    // You can read the value of a lines sensor using the function:
    // boolean a = digitalRead(pin)
    // You can use the pins {1,2,3,4} or {lsPin1, lsPin2, lsPin3, lsPin4} whichever you like,
    // like this: 
    
    boolean a = digitalRead(lsPin1); // read the first pin
    
    // You can control the direction and the speed of the motors with
    // motorControl(motor#, speed) {1 == left, 2 == right}
    // NOTE: Speed can be negative, to move backward
    
    motorControl(2, 5); // Rotate right motor with 5 speed
    
  }
} // End of Program