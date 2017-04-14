/*
 * "Main Class" of the program. Everything starts here.
 * 2017.04.09 - Kovacs Gyorgy
 */

// Global variables
Robot optimus; // The main robot
Robot dummy; // Enemy robot
Ring ring; // The ring 

// The setup function to initialize main objects
void setup() {
  // Set screen size and fps
  size(500, 500);
  frameRate(Const.fps);
  
  // Initialize objects
  ring = new Ring(width/2, height/2);
  optimus = new Robot(ring);
  dummy = new Robot(width/2 + 100, height/2 - 100, ring, PI/2);
  dummy.hideSensors = true;
  dummy.mouseFollower = true;
  
  optimus.setEnemy(dummy);
  
  
}

// Draw the objects to the screen
// Note - uses framerate that is set in the setup
void draw() {
  // Clear the screen
  background(0);
  
  // Deals with input and such
  updateStuff();
  
  // Invoke draw methods of objects
  ring.draw();
  optimus.draw();
  dummy.draw();
}

// The rest of what is here deals with input handling --------+
//                                                            |
//                                                           \ /
//                                                            v

void updateStuff() {
  
  optimus.accel = 0;
  if (forward) optimus.accel = 20;
  else if (backward) optimus.accel = -20;
  
  optimus.angacc = 0;
  if (turnLeft) optimus.angacc = -20;
  else if (turnRight) optimus.angacc = 20;
  
  optimus.update();
  dummy.update();
}

boolean turnRight = false;
boolean turnLeft = false;
boolean forward = false;
boolean backward = false;

void keyPressed() {
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
  switch(key) {
  case 'a': turnLeft = false; break;
  case 'd': turnRight = false; break;
  case 'w': forward = false; break;
  case 's': backward = false; break;
  default: break;
  }
}