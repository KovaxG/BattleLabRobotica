/*
 * The representation of the ring. This is drawn first and everything else is drawn ontop of it.
 * 2017.04.09 - Kovacs Gyorgy
 */

public class Ring extends Entity {
  
  private float x; // The center coordinates of the ring (horizontal)
  private float y; // The center coordinates of the ring (verical)
  private float diameter = 150; // [cm] The diameter of the ring
  
  public Ring(int x, int y) {
    this.x = x;
    this.y = y;
  }
  
  // draw - draw the ring to the screen
  // Note - scaling included
  public void draw() {
    // Set the style of the circle
    strokeWeight(10); // Set the width of the circle line
    stroke(255); // Set the color of the circle line (255 == white)
    fill(0); // Set the fill of the circle (0 == black)
    
    // Calculate the actual size after scaling
    float realSize = diameter * scale;
    
    // Draw the ellipse
    ellipse(x, y, realSize, realSize);
  }
  
  // Getter for the x position of the ring (in order to make x read-only)
  public float x() {return x;}
  
  // Getter for the y position of the ring (in order to make y read-only)
  public float y() {return y;}
} // End of Class