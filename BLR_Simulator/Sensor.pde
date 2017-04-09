/*
 * This abstract class acts as an interface for the line and distance sensors.
 * 2017.04.09 - Kovacs Gyorgy
 */
abstract class Sensor extends Entity {
  protected float Px; // The horizontal position of the center of the sensor relative to the center of the robot
  protected float Py; // The vertical position of the center of the sensor relative to the center of the robot
  protected boolean on = false; // The sensor is detecting anything or not
  
  public Sensor(float Px, float Py) {
    this.Px = Px;
    this.Py = Py;
  } // End of Constructor
  
  // Read the value of the sensor, it either detects something or not
  public boolean read() {
    return on;
  }
  
  // Function that updates the on state of the sensor, given its position
  public abstract void update(float x, float y, float angle);
  
  // Function that draws the representation of the sensor to the screen
  public abstract void draw();
} // End of Class