/*
 * An implementation of the Line Sensor, a sensor that senses if the robot is touching the white line of the ring.
 * Note - The sensor is actually using the distance from the center of the ring, not the whiteness of edge of the ring to activate.
 * 2017.04.09 - Kovacs Gyorgy
 */

public class LineSensor extends Sensor {
  
  private float size = 2; // [cm] The size (width, length) of the sensor
  private Ring ring; // A refference of the ring, in order to determine the distance from the center
  
  public LineSensor(float Px, float Py, Ring r) {
    super(Px, Py);
    ring = r;
  }
  
  /* draw - draw the LineSensor to the screen
   * Note - the sensor is drawn considering the coordinate frame in the
   *        center of the screen, and in the correct orientation!!!
   */
  public void draw() {
    // Set the style of the drawing
    strokeWeight(1); // The width of the contour
    stroke(255); // The color of the contour
    // The fill of the sensor depends whether or not it is detecting someting
    if (on) fill(255, 0, 0); // Red if on
    else    fill(0, 255, 0); // Green if off
    
    // Perform position calculations
    float realSize = size * scale;
    float centerX = Px - realSize / 2;
    float centerY = Py - realSize / 2;
    
    // Draw the sensor
    rect(centerX, centerY, realSize, realSize);
  }
  
  /* update - update the state of the sensor
   * Note - the sensor has no internal absolute x and y, it takes them from the robot's state
   */
  public void update(float x, float y, float angle) {
    // Calculate absolute position of the sensor
    Point rotatedPosition = rotatePoint(Px, Py, angle);
    float sx = x + rotatedPosition.x;
    float sy = y + rotatedPosition.y;
    
    // Declare the condition for activation
    boolean condition =  distance(sx, sy, ring.x, ring.y) > 220;
            condition &= distance(sx, sy, ring.x, ring.y) < 230;
    
    if (condition) on = true;
    else on = false;
  }
} // End of Class