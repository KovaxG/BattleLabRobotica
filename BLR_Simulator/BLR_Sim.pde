Robot optimus;
Ring ring;

void setup() {
  size(500, 500);
  ring = new Ring(width/2, height/2);
  optimus = new Robot(width/2, height/2);
  frameRate(Const.fps);
}

void draw() {
  background(0);
  
  updateStuff();
  
  ring.draw();
  optimus.draw();
}

void updateStuff() {
  
  optimus.accel = 0;
  if (forward) optimus.accel = 1;
  else if (backward) optimus.accel = -1;
  
  optimus.angacc = 0;
  if (turnLeft) optimus.angacc = -1;
  else if (turnRight) optimus.angacc = 1;
  
  optimus.update();
}

boolean turnRight = false;
boolean turnLeft = false;
boolean forward = false;
boolean backward = false;

// TODO keyboard representation of keys pressed and stuff
void keyPressed() {
  System.out.println(key);
  if (key == 'a') {
    turnRight = false;
    turnLeft = true;
  }
  else if (key == 'd') {
    turnRight = true;
    turnLeft = false;
  }
  
  if (key == 'w') {
    forward = true;
    backward = false;
  }
  else if (key == 's') {
    forward = false;
    backward = true;
  }
  
  if (key == 'r') {
    setup();
  }
}

void keyReleased() {
  System.out.println(key);
  turnLeft = false;
  turnRight = false;
  forward = false;
  backward = false;
}