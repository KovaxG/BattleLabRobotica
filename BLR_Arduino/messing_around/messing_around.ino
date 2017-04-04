// Messing around

void setup() {
  // put your setup code here, to run once:
  pinMode(A0, INPUT);
  Serial.begin(9600);
  while(!Serial) {}
}

int a1 = 0;
int a2 = 0;
int a3 = 0;
int a4 = 0;
int a5 = 0;

void loop() {
  // put your main code here, to run repeatedly:
  //Serial.println(analogRead(A0));

  a5 = a4;
  a4 = a3;
  a3 = a2;
  a2 = a1;
  a1 = analogRead(A0);

  if ((a1 + a2 + a3 + a4 + a5) / 5 > 60) {
    Serial.println("Object");
  }
  else {
    Serial.println("-");
  }
}

