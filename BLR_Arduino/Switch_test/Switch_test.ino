void setup() {
  pinMode(3, INPUT);
  pinMode(13, OUTPUT);
}

void loop() {
  digitalWrite(13, digitalRead(3));
}
