/*
 * The robot is controlled using a state machine, based on the line sensor.
 * TODO: add states based on the distance sensor
 *
 * 2017.05.03 - Popescu Mihaela
 *
 */

public class StateMachineProgram extends Program {

  public StateMachineProgram (Robot r) {
    super(r);
  }

  void setup() {
    // No need to set pinModes and stuff
    // Can be added later if required
  }

  int oldState, currentState = 0;

  void loop () {
    if (SWITCH == false) {
      
      //save the old state
      oldState = currentState;

      //determine the current state
      currentState = determineState();

      //perform the action corresponding to the state
      if (oldState != 0)
        performAction(oldState);
      else
        performAction(currentState);
    } else 
    {
      stopBothMotors();
    }
    
    Serial.println("Current state: "+ currentState);
  }

  int determineState()
  {
    //no sensor is active
    if (!digitalRead(lsPin1) && !digitalRead(lsPin2) && !digitalRead(lsPin3) && !digitalRead(lsPin4))
      return 0;

    //front left sensor is active
    if (digitalRead(lsPin1) &&  !digitalRead(lsPin2) && !digitalRead(lsPin3) && !digitalRead(lsPin4))
      return 1;

    //front right sensor is active
    if (!digitalRead(lsPin1) &&  !digitalRead(lsPin2) && digitalRead(lsPin3) && !digitalRead(lsPin4))
      return 2; 

    //front sensors are active
    if (digitalRead(lsPin1) &&  digitalRead(lsPin3) && !digitalRead(lsPin2) && !digitalRead(lsPin4))
      return 3;

    //back sensors are active
    if ((digitalRead(lsPin2) ||  digitalRead(lsPin4)) && !digitalRead(lsPin1) && !digitalRead(lsPin3))
      return 4;

    //undetermined state
    return -1;
  }

  void performAction(int state)
  {
    float speed = 2;
    float radius = 15;

    switch (state) {
    case 0:
      //go forward
      motorControl(1, speed);
      motorControl(2, speed);
      break;
    case 1:
      //rotate
      moveOnCircularTrajectory(false, -speed*10, radius);
      break;
    case 2:
      //rotate
      moveOnCircularTrajectory(true, -speed*10, radius);
      break;
    case 3:
      //rotate
      moveOnCircularTrajectory(true, -speed*5, radius);
      break;
    case 4:
      //go forward
      motorControl(1, speed);
      motorControl(2, speed);
      break;
    case -1:
      //stop both motors
      stopBothMotors();
      break;
    }
  }
} // End of Program