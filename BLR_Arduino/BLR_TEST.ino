void setup() {
  pinMode(13, INPUT);
  Serial.begin(9600);
  while(!Serial) {}
}

void loop() {
  boolean value = digitalRead(13);
  Serial.println(value);
}
