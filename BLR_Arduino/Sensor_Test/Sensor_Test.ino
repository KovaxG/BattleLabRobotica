int dist1 = A0;
int dist2 = A2;

void setup() {
  pinMode(dist1, INPUT);
  pinMode(dist2, INPUT);

  Serial.begin(9600);
}

void loop() {
  int d1 = analogRead(dist1);
  int d2 = analogRead(dist2);

  Serial.println(d1);
  delay(200);
}
