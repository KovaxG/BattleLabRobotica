int cmd11 = 2;
int cmd12 = 4;

int cmd21 = 5;
int cmd22 = 7;

void setup() {
  pinMode(cmd11, OUTPUT);
  pinMode(cmd12, OUTPUT);
  pinMode(cmd21, OUTPUT);
  pinMode(cmd22, OUTPUT);
}

void setLow() {
  delay(3000);
  digitalWrite(cmd11, LOW);
  digitalWrite(cmd12, LOW);
  digitalWrite(cmd21, LOW);
  digitalWrite(cmd22, LOW);
}

void loop() {
  setLow();
  
  delay(3000);
  digitalWrite(cmd11, HIGH);

  delay(3000);
  digitalWrite(cmd12, HIGH);

  delay(3000);
  digitalWrite(cmd21, HIGH);

  delay(3000);
  digitalWrite(cmd22, HIGH);
}
