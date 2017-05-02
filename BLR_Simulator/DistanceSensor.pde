/*
 * An implementation of the Distance Sensor. Not yet implemented.
 */

public class DistanceSensor extends Sensor {

  private float range = 50; // [cm] The sensor can only see the enemy robot when is closer than this distance (scaled)
  private Robot robot; // The enemy robot
  private float angle;
  
  public int value = 1023; // The value read by the sensor
  
  public DistanceSensor(float Px, float Py, float angle, Robot robot) {
    super(Px, Py);
    this.robot = robot;
    this.angle = angle;
  }
  
  // setRobot - Provide reference of the enemy robot, so that the sensor may detect it
  public void setRobot(Robot robot) {
    this.robot = robot;
  }
  
  /* draw - draw the LineSensor to the screen
   * Note - the sensor is drawn considering the coordinate frame in the
   *        center of the screen, and in the correct orientation!!!
   */
  public void draw() {
    // Set the style of the line
    strokeWeight(2); // Width of the line
    if (on) stroke(255, 0, 0); // Red if detected
    else    stroke(0, 255, 0); // Green if not
    
    // Scale the range, then draw the line
    float actualRange = range * scale; 
    rotate(angle);
    line(Px, Py, Px + actualRange, Py);
    rotate(-angle);
  }
  
  /* update - update the state of the sensor
   * Note - the sensor has no internal absolute x and y, it takes them from the robot's state
   */
  public void update(float x, float y, float angle) {
    // If there is no ref to the enemy robot, the sensor will always be off
    if (robot == null) {
      on = false;
      return;
    }
    
    // If there is a ref, check if it is in front of the sensor
    float actualRange = range * scale; 
    Point rotatedPosition = rotatePoint(Px, Py, angle + this.angle);
    float sx = x + rotatedPosition.x;
    float sy = y + rotatedPosition.y;
    
    Point rotatedEndPoint = rotatePoint(Px + actualRange, Py, angle + this.angle);
    float bx = x + rotatedEndPoint.x;
    float by = y + rotatedEndPoint.y;
    
    Point robotPos = new Point(robot.x, robot.y);
    Point A = new Point(sx, sy);
    Point B = new Point(bx, by);
    Point C = robotPos;
    
    float a = distance(B, C);
    float b = distance(C, A);
    float c = distance(B, A);
    
    float p = (a + b + c) / 2;
    float T = sqrt(p * (p - a) * (p - b) * (p - c));
    float h = 2 * T / c;
    
    float distanceFromSensor = distance(C, A);
    float sideDistance = h;
    
    if (distanceFromSensor <= actualRange + 10 * scale && sideDistance <= 10 * scale && distance(B, C) <= c) {
      on = true;
      value = (int)map(0, 1023, 0, actualRange, distanceFromSensor);
    }
    else{
      on = false;
      value = 1023;
    }
  }
} // End of Class