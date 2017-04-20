/*
 * An implementation of the Distance Sensor. Not yet implemented.
 */

public class DistanceSensor extends Sensor {

  private float range = 50; // [cm] The sensor can only see the enemy robot when is closer than this distance (scaled)
  private Robot robot; // The enemy robot
  
  public DistanceSensor(float Px, float Py, Robot robot) {
    super(Px, Py);
    this.robot = robot;
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
    //System.out.println(distance(Px, Py, Px + actualRange, Py) + " " + actualRange);
    line(Px, Py, Px + actualRange, Py);
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
    // TODO implement
    float actualRange = range * scale; 
    System.out.println(distance(x, y, robot.x, robot.y) + " " + actualRange + " " + distance(Px, Py, Px + actualRange, Py));
    if (distance(x, y, robot.x, robot.y) <= actualRange) on = true;
    else on = false;
  }
} // End of Class