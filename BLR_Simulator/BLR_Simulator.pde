/*
 * "Main Class" of the program. Everything starts here.
 * 2017.04.09 - Kovacs Gyorgy
 *
 * If you want to control the robot manually, set the value 
 * of the program object in the setup method to null!!
 */

// Global variables
Robot optimus; // The main robot
Ring ring; // The ring 
Program program;

// The setup function to initialize main objects
void setup() {
  // Set screen size and fps
  size(500, 500);
  frameRate(Const.fps);
  
  // Initialize objects
  ring = new Ring(width/2, height/2);
  optimus = new Robot(width/2, height/2, ring);
  
  // Program related initializations
  //program = new TestProgram(optimus); 
  program = new SpinnerProgram(optimus, false); // Set to null if you want to control the robot manually
  if (program != null) program.setup();
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
}

// The rest of what is here deals with input handling --------+
//                                                            |
//                                                           \ /
//                                                            v

void updateStuff() {
  
  if (program != null) {
    // Control via program
    program.loop();
  }
  else {
    // Manual Control
    optimus.accel = 0;
    if (forward) optimus.accel = 20;
    else if (backward) optimus.accel = -20;
    
    optimus.angacc = 0;
    if (turnLeft) optimus.angacc = -20;
    else if (turnRight) optimus.angacc = 20;
  }
  
  optimus.update();
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