#define LS1 6
#define LS2 7
#define LS3 8
#define LS4 5

// LS3 used to be 6
// LS1 used to be 8

#define startSignal 13

#define CMD1Pin_1 12
#define CMD2Pin_1 11

#define CMD1Pin_2 10
#define CMD2Pin_2 9

#define distance1 A0
#define distance2 A1

void setup() {
  Serial.begin(9600);
  //while(!Serial) {}
  Serial.println("Setting up:");
  
  pinMode(LS1, INPUT);
  pinMode(LS2, INPUT);
  pinMode(LS3, INPUT);
  pinMode(LS4, INPUT);

  pinMode(distance1, INPUT);
  pinMode(distance1, INPUT);
  
  pinMode(CMD1Pin_1, OUTPUT);
  digitalWrite(CMD1Pin_1, LOW);
  pinMode(CMD2Pin_1, OUTPUT);
  digitalWrite(CMD2Pin_1, HIGH);
  
  pinMode(CMD1Pin_2, OUTPUT);
  digitalWrite(CMD1Pin_2, LOW);
  pinMode(CMD2Pin_2, OUTPUT);
  digitalWrite(CMD2Pin_2, HIGH);
  
  pinMode(startSignal, INPUT);

  delay(2000);

  Serial.println("Waiting for signal.");
  
  while(digitalRead(startSignal) == LOW) {}
} // End of setup

boolean dist1 = false;
boolean dist2 = false;

int distState = 0;

boolean ls1 = false;
boolean ls2 = false;
boolean ls3 = false;
boolean ls4 = false;

int state = 0;
int action = 0;

boolean readLineSensor(int pin) {
  
  unsigned int _maxValue = 5000;
  
  unsigned long mic;
  
  digitalWrite(pin, HIGH);
  pinMode(pin, OUTPUT);
  
  delayMicroseconds(10);
  
  pinMode(pin, INPUT);
  digitalWrite(pin, LOW);
  
  unsigned long startTime = micros();
  while (micros() - startTime < _maxValue) {
    unsigned int time = micros() - startTime;
    if (digitalRead(pin) == LOW && time < mic) mic = time;
  }
  
  return (mic > 2000)? true : false;
} // End of readLineSensor

#define threshold 150

boolean readDistance(int pin) {
  int value = analogRead(pin);
  return (value > threshold)? true : false;
} // End of readDistance

void readSensors() {
  ls1 = readLineSensor(LS1);
  ls2 = readLineSensor(LS2);
  ls3 = readLineSensor(LS3);
  ls4 = readLineSensor(LS4);

  dist1 = readDistance(distance1);
  dist2 = readDistance(distance2);
} // End of readSensors

void determineState() {
  if (!ls1 && !ls2 && !ls3 && !ls4) {
    if (!dist1 && !dist2) {
      action = 2;
      return;  
    }
    if (dist1 && dist2) {
      action = 0;
      return;  
    }
    if (!dist1 && dist2) {
      action = 1;
      return;  
    }
    if (dist1 && !dist2) {
      action = 3;
      return;  
    }
  }
  if (!ls1 && !ls2 && !ls3 && ls4) {
    action = 1;
    return;
  }
  if (!ls1 && !ls2 && ls3 && !ls4){
    action = 3;
    return;
  }
  if (!ls1 && !ls2 && ls3 && ls4) {
    action = 0;
    return;
  }
  if (!ls1 && ls2 && !ls3 && !ls4){
    action = 5;
    return;
  }
  if (!ls1 && ls2 && !ls3 && ls4) { 
    action = 4;
    return;
  }
  if (!ls1 && ls2 && ls3 && !ls4) {
    action = 7;
    return;
  }
  if (!ls1 && ls2 && !ls3 && ls4) {
    action = 7;
    return;
  }
  if (ls1 && !ls2 && !ls3 && !ls4) {
    action = 2;
    return;
  }
  if (ls1 && !ls2 && !ls3 && ls4) {
    action = 4;
    return;
  }
  if (ls1 && !ls2 && ls3 && !ls4) {
    action = 8;
    return;
  }
  if (ls1 && ls2 && !ls3 && !ls4) {
    action = 0;
    return;
  }
} // End of determineState

/*
 * #define CMD1Pin_1 12
#define CMD2Pin_1 11

#define CMD1Pin_2 10
#define CMD2Pin_2 9
 */

void performAction() {
  boolean s1 = false;
  boolean s2 = false;
  boolean s3 = false;
  boolean s4 = false;
  
  switch(action) {
    case 0:
      s1 = HIGH;
      s2 = HIGH;
      s3 = HIGH;
      s4 = HIGH;
      break;
    case 1:
      s1 = HIGH;
      s2 = HIGH;
      s3 = HIGH;
      s4 = LOW;
      break;
    case 2:
      s1 = HIGH;
      s2 = HIGH;
      s3 = LOW;
      s4 = LOW;
      break;
    case 3:
      s1 = HIGH;
      s2 = LOW;
      s3 = HIGH;
      s4 = HIGH;
      break;
    case 4:
      s1 = HIGH;
      s2 = LOW;
      s3 = HIGH;
      s4 = LOW;
      break;
    case 5:
      s1 = HIGH;
      s2 = LOW;
      s3 = LOW;
      s4 = LOW;
      break;
    case 6:
      s1 = LOW;
      s2 = LOW;
      s3 = HIGH;
      s4 = HIGH;
      break;
    case 7:
      s1 = LOW;
      s2 = LOW;
      s3 = HIGH;
      s4 = LOW;
      break;
    case 8:
      s1 = LOW;
      s2 = LOW;
      s3 = LOW;
      s4 = LOW;
      break;
  }

  digitalWrite(CMD1Pin_1, s1);
  digitalWrite(CMD2Pin_1, s2);
  digitalWrite(CMD1Pin_2, s3);
  digitalWrite(CMD2Pin_2, s4);
}

void loop() {
  readSensors();
  determineState();
  performAction();
  delay(20);

  Serial.print("LS1 = ");
  Serial.print(ls1);
  Serial.print("LS2 = ");
  Serial.print(ls2);
  Serial.print("LS3 = ");
  Serial.print(ls3);
  Serial.print("LS4 = ");
  Serial.print(ls4);
  Serial.print("Dist1 = ");
  Serial.print(dist1);
  Serial.print("Dist2 = ");
  Serial.println(dist2);

  Serial.print("State = ");
  Serial.print(state);
  Serial.print("Action = ");
  Serial.println(action);
  
  if (digitalRead(startSignal) == LOW) {
    while(true) {}  
  }
}
