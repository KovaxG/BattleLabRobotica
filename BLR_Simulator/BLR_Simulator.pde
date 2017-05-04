/*
 * "Main Class" of the program. Everything starts here.
 * 2017.04.09 - Kovacs Gyorgy
 *
 * If you want to control the robot manually, set the value 
 * of the program object in the setup method to null!!
 */

// Global variables
Robot optimus; // The main robot
Robot dummy; // Enemy robot
Ring ring; // The ring 
Program program;
CommandPanel panel;
boolean SWITCH = false;

float WIDTH = 500;
float HEIGHT = 500;

// The setup function to initialize main objects
void setup() {
  // Set screen size and fps
  size(600, 500);
  frameRate(Const.fps);
  
  // Initialize Objects
  ring = new Ring((int)WIDTH/2, (int)HEIGHT/2);
  optimus = new Robot(WIDTH/2, HEIGHT/2, ring);
  panel = new CommandPanel(WIDTH, 0, 98, HEIGHT - 2);
  
  // Initialize Enemy
  dummy = new Robot(1000, 1000, ring, PI/2);
  dummy.hideSensors = true;
  dummy.mouseFollower = false;
  optimus.setEnemy(dummy);

  // Program related initializations
  //program = new EmptyProgram(optimus); // Set to null if you want to control the robot manually
  program = new FrontSensorsProgram(optimus); 
  if (program != null) program.setup();  
}

ArrayList<Point> trajectory = new ArrayList<Point>();
boolean memoriseTrajectory = false;


// Draw the objects to the screen
// Note - uses framerate that is set in the setup
void draw() {
  // Clear the screen
  background(0);
  
  // Command Panel
  panel.draw();
  
  // Deals with input and such
  updateStuff();
  
  // Invoke draw methods of objects
  ring.draw();
  optimus.draw();
  dummy.draw();
  drawTrajectory();
}

void drawTrajectory() {
  for (int i = 0; i < trajectory.size()-1; i++) {
    stroke(255, 0, 0);
    line(trajectory.get(i), trajectory.get(i+1));
  }
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
    if (forward) {
      optimus.rWheelForce = 5;
      optimus.lWheelForce = 5;
    }
    else if (backward) {
      optimus.rWheelForce = -5;
      optimus.lWheelForce = -5;
    }
    else {
      optimus.rWheelForce = 0;
      optimus.lWheelForce = 0;
    }
    
    if (turnLeft) {
      optimus.lWheelForce = -5;
      optimus.rWheelForce = 5;
    }
    else if (turnRight) {
      optimus.rWheelForce = -5;
      optimus.lWheelForce = 5;
    }
  }
  
  optimus.update();
  dummy.update();
  
  // Memorise Trajectory
  Point a = new Point(optimus.x, optimus.y);
  if (memoriseTrajectory && !trajectory.contains(a)) trajectory.add(a);
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

void mousePressed() {
  panel.click();
}