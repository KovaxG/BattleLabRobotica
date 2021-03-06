// Cod BattleLab Robotica 2017

// Define TEST to disable the SWITCH
// CAREFULL WITH THIS STUFF!!
// THIS SHOULD BE COMMENTED OUT IN FINAL CODE!
//#define TEST

// Constants for delays(will probably not use)
#define _1s 1000
#define _2s 2000
#define _3s 3000

// H-Bridge Pins
int cmdR1 = 5;
int cmdR2 = 7;
int cmdM1 = 2;
int cmdM2 = 4;

// Kill and Startswitch pins
// the robot should only be active while the pin is HIGH
int SWITCH = 3;

// Sensors
#define _Sensor_1_Treshhold 300
#define _Sensor_2_Treshhold 300

int dist1 = A5; // < 180
int dist2 = A3; // < 150

void setup() {
  //Serial.begin(9600);
  
  // H-Bridge Pins
  pinMode(cmdR1, OUTPUT);
  pinMode(cmdR2, OUTPUT);
  pinMode(cmdM1, OUTPUT);
  pinMode(cmdM2, OUTPUT);

  // Hault motion
  STOP();

  // SWITCH Pin
  pinMode(SWITCH, INPUT);

  // Sensors
  pinMode(A0, INPUT);
  pinMode(A2, INPUT);

  #ifndef TEST
    while(digitalRead(SWITCH) == LOW) {/* Wait until Switch is pressed */}
  #endif 
} // End of Setup

void loop() {

  int state = determineState();
  performAction(state);
  
  #ifndef TEST
    if (digitalRead(SWITCH) == LOW) {
      STOP();
      while(true) {} // Program is over!
    }
  #endif
} // End of loop

int determineState() {
  
  // None of the sensors are active
  if (!leftsensor() && !rightsensor()) return 0;
    
  // At least one sensor is active
  if (leftsensor() || rightsensor()) return 1; 
    
  //error state
  return -1; // Theoretically impossible
} // End of determineState

void performAction(int state){
    switch (state) {
    case 0:
      // Rotating Movement
      ROTATERIGHT();
      //Serial.println("STOP");
      //STOP();
      break;
    case 1:
     // Move forward
    //Serial.println("GOGOGO");
      FORWARD();
      break;
    case -1:
      // Again, this should never happen
      STOP();
      break;
    }
} // End of performAction

/*
 * Change the state of the H-Bridge, thus changing the direction of the motor.
 * 
 * OK inputs:
 * motorCommand(0, -1);
 * motorCommand(0,  0);
 * motorCommand(0,  1);
 * motorCommand(1, -1);
 * motorCommand(1,  0);
 * motorCommand(1,  1);
 * 
 * Default command is motorCommand(0 0);
 */
void motorCommand(int motor, int dir) {

  // Direction that needs to be set to eigher 1 or -1, depending on the
  // orientation of the H-Bridge and the motor.
  int forward = -1;

  // The Deffault H-Bridge pins to be changed
  int p1 = cmdM1;
  int p2 = cmdM2;

  // Choose the orientation of the H-Bridge and pins
  if (motor == 0) {
    // Punte Mihaela
    p1 = cmdM1;
    p2 = cmdM2;
    forward = forward;
  }
  else {
    // Punte Ronny
    p1 = cmdR1;
    p2 = cmdR2;
    forward = forward;
  }

  // Switch based on the provided direction and the
  // internal direction (forward)
  if (dir == forward) {
      // Forward 
      digitalWrite(p1, LOW);
      digitalWrite(p2, LOW);
  }
  else if (dir == -forward) {
      // Backward
      digitalWrite(p1, HIGH);
      digitalWrite(p2, HIGH);
  }
  else {
      // Stop
      digitalWrite(p1, HIGH);
      digitalWrite(p2, LOW);   
  }
} // End of motorCommanD



bool leftsensor() {
  int val = analogRead(dist1);
  
  return (val > _Sensor_1_Treshhold)? true : false;
} // End of leftsensor

bool rightsensor() {
  int val = analogRead(dist2);
  //Serial.println(val);
  return (val > _Sensor_2_Treshhold)? true : false;  
} // End of rightsensor

void STOP() {
  motorCommand(0, 0); // Stop Mihaela
  motorCommand(1, 0); // Stop Ronny
} // End of STOP

void FORWARD() {
  motorCommand(0, 1); // Forward Mihaela
  motorCommand(1, 1); // Forward Ronny
} // End of FORWARD

void BACKWARD() {
  motorCommand(0, -1); // Backward Mihaela
  motorCommand(1, -1); // Backward Ronny
} // End of BACKWARD

void SPINLEFT() {
  motorCommand(0,  1); // Forward Mihaela
  motorCommand(1, -1); // Backward Ronny  
} // End of SPINLEFT

void SPINRIGHT() {
  motorCommand(0, -1); // Backward Mihaela
  motorCommand(1,  1); // Forward Ronny  
} // End of SPINRIGHT

void ROTATELEFT() {
  motorCommand(0, 1); // Forward Mihaela
  motorCommand(1, 0); // Stop Ronny
} // End of ROTATELEFT

void ROTATERIGHT() {
  motorCommand(0,  0); // Stop Mihaela
  motorCommand(1,  1); // Forward Ronny
} // End of ROTATERIGHT
