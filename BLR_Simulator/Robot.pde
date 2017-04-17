/*
 * This class is the representation of the robot.
 * 2017.04.09 - Kovacs Gyorgy
 */

public class Robot extends Entity {
  
  private int size = 20; // [cm] size of the robot in cm (width and length)
  private float x; // Absolute horizontal position (relative to upper left corner)
  private float y; // Absolute vertical position (relative to upper left corner)
  
  private float mass = 3;  // [kg] Mass of the robot, used in the motion laws
  public float rWheelForce = 0; // [N]
  public float lWheelForce = 0; // [N]
  
  private float speed = 0; // [m/s]
  private float accel = 0; // [(m/s)/s]
  
  private float angle = -PI/2;  // [rad]
  private float angvel = 0;     // [rad/s]
  private float angacc = 0;     // [(rad/s)/s]
  
  // The four line sensors
  private LineSensor ls1; //front left sensor 
  private LineSensor ls2; //back left sensor
  private LineSensor ls3; //front right sensor
  private LineSensor ls4; //back right sensor
  
  
  public Robot(float x, float y, Ring r) {
    this.x = x;
    this.y = y;
    
    ls1 = new LineSensor( 25, -25, r);
    ls2 = new LineSensor(-25, -25, r);
    ls3 = new LineSensor( 25,  25, r);
    ls4 = new LineSensor(-25,  25, r);
  }
  
  public int getSize()
  {
    return this.size;
  }
  
  /* update - Update internal states and the states of the sensors.
   * Note - The sensors each have internal updates, the real updates here happen only on
   *        the robot itself, then each sensor updates itself using the new states of the robot.
   */
  public void update() {
    // Calculate Acceleration
    float forwardForce = (rWheelForce + lWheelForce); // F = |F1| + |F2|
    accel = forwardForce / mass; // F = m * a => a = F / m
    accel = 10 * accel; // To balance the roation with the forward acceleration
    
    // Calculate Rotation acceleration
    float rotatingForce = rWheelForce - lWheelForce; // F = |F1| - |F2|
    float rotatingTorque = rotatingForce * size/2; // T = F * l
    angacc = rotatingTorque / mass; // T = m * a => a = T / m
    
    // Apply friction
    speed -= speed * 0.1;
    angvel -= angvel * 0.1;
    
    // Update internal states
    speed += accel * Const.Ts;
    angvel += angacc * Const.Ts;
    angle += angvel * Const.Ts;
    
    x += speed * cos(angle);
    y += speed * sin(angle);
    
    // Update sensors
    ls1.update(x , y, angle);
    ls2.update(x , y, angle);
    ls3.update(x , y, angle);
    ls4.update(x , y, angle);
    
  }
  
  /* draw - draw the robot to the screen.
   * Draws the robot on the screen, and also calls the draw for each sensor.
   */
  public void draw() {
    
    // Calculate stuff
    float realSize = size * scale; // Calculate real size, because of the scaling
    float offset = - realSize/2; // This is so that the rectangle's center will the at (x,y)
    
    // Draw the robot in the correct coordinates and the correct roatation
    // i. e. move the coordinate frame to the center of the robot
    translate(x, y);
    rotate(angle);
    
    // Specify the style of the robot rectangle
    strokeWeight(1); // Width of the edge of the rect
    stroke(255); // The color of the contour (255 == white)
    fill(0); // The fill of the rect (0 == black)
    
    // Draw the rectangle that represents the robot
    // Note - 0,0 is the center of the screen now, 
    // since the coordinate frame now is in the center of the screen
    // because of the translate and the rotate in the beginning
    rect(offset, offset, realSize, realSize);
    
    // Draw the components of the robot
    ls1.draw();
    ls2.draw();
    ls3.draw();
    ls4.draw();
    
    // Write text to the front of the robot
    fill(255);
    text("Front", 50, 0);
    
    // Write text to the right side of the robot
    rotate(PI/2);
    text("Right", 50, 0);
    
    // Write text to the left side of the robot
    rotate(PI);
    text("Left", 50, 0);
    
    // Rotate and translate back to the upper left corner of the screen
    rotate(-angle + PI/2);
    translate(-x, -y);
  }
  
  // toString - Used for printing the internal states of the robot
  public String toString() {
    return String.format("x=%f, y=%f, v=%f, a=%f, av=%f, aa=%f", x, y, speed, accel, angvel, angacc);
  }
} // End of Class Robot