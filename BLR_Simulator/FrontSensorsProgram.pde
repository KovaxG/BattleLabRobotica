/* //<>//
 * The robot spins until it sees the other robot.
 * Then it goes straight ahead.
 * Just the two front distance sensors are used.
 *
 * 2017.05.03 - Popescu Mihaela
 *
 */

public class FrontSensorsProgram extends Program {

  public FrontSensorsProgram (Robot r) {
    super(r);
  }

  void setup() {
    // No need to set pinModes and stuff
    // Can be added later if required
  }

  int state = 0;

  void loop () {
    if (SWITCH == false) {
          state = determineState();
          performAction(state);
    } else 
    {
      stopBothMotors();
    }
    Serial.println("State: " + state + ", Sensors: "+ analogRead(1) + ", " + analogRead(0));
  }

  int determineState()
  {
    //no sensor is active
    if ((analogRead(0) > 180) && (analogRead(0) > 180)) return 0;
    
    //at least one sensor is active
    if ((analogRead(0) <= 180) || (analogRead(1) <= 180)) return 1; 
    
    //error state
    return -1;
  }

  void performAction(int state)
  {
    float speed = 5; //maybe better with full speed
    float angularSpeed = 3;
    float radius = 20;

    switch (state) {
    case 0:
      //spin
      moveOnCircularTrajectory(true, angularSpeed, radius);
      break;
    case 1:
     //move forward
      motorControl(1, speed);
      motorControl(2, speed);
      break;
    case -1:
      stopBothMotors();
      break;
    }
  }
} // End of Program