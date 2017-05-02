int pin = 8;

void setup() {
  pinMode(8, OUTPUT);
  Serial.begin(9600);
}

void loop() {
  // Set pin to high
  pinMode(pin, OUTPUT);
  digitalWrite(pin, HIGH);

  // Wait a few microseconds
  delayMicroseconds(10);

  // Start reading from the line
  pinMode(pin, INPUT);

  // Measure the time it took for the capacitor to loose charge
  unsigned int maximumWait = 5000;
  unsigned long chargeLostTime = 0;
  unsigned long startTime = micros();
  while (micros() - startTime < maximumWait && digitalRead(pin) == HIGH) {
    chargeLostTime = micros() - startTime;
  }

  // Print measured time
  Serial.println(chargeLostTime);
}
