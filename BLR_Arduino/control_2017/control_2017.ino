// Cod BattleLab Robotica 2017

// Define TEST to disable the SWITCH
// CAREFULL WITH THIS STUFF!!
// THIS SHOULD BE COMMENTED OUT IN FINAL CODE!
#define TEST

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
int dist1 = A0; // < 180
int dist2 = A2; // < 150

void setup() {

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
  
  
  #ifndef TEST
    if (digitalRead(SWITCH) == LOW) {
      STOP();
      while(true) {} // Program is over!
    }
  #endif
} // End of loop

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
  int forward = 1;

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
    forward = -forward;
  }

  // Switch based on the provided direction and the
  // internal direction (forward)
  if (dir == forward) {
      // Forward 
      pinMode(p1, LOW);
      pinMode(p2, LOW);
  }
  else if (dir == -forward) {
      // Backward
      pinMode(p1, HIGH);
      pinMode(p2, HIGH);
  }
  else {
      // Stop
      pinMode(p1, HIGH);
      pinMode(p2, LOW);   
  }
} // End of motorCommand


int leftsensor() {
  return analogRead(dist1);
} // End of leftsensor

int rightsensor() {
  return analogRead(dist2);  
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
