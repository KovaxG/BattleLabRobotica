/*
 * Here there are usefull functions that can be used anywhere in the program.
 * 2017.04.09 - Kovacs Gyorgy
 */

/* distance - Takes two points, and returns the euclidean distance between them.
 * Note - Includes scaling factor, refrain from implementing your own distance!
 */
float distance(float x1, float y1, float x2, float y2) {
  
  float scalingFactor = 2 / Const.scale;

  
  float normalDistance = sqrt(sqr(x1 - x2) + sqr(y1 - y2));
  
  return normalDistance * scalingFactor;
}

// sqr - Returns the square of a float
float sqr(float a) {return a * a;}

// A class used for handling points/coordinates
public class Point {
  public float x;
  public float y;
  
  public Point(float x, float y) {
    this.x = x;
    this.y = y;
  }
} // End of Class

// roatatePoint - rotates the point by a given angle
 Point rotatePoint(float x, float y, float angle) {
   float nx = x * cos(angle) + y * -sin(angle);
   float ny = x * sin(angle) + y *  cos(angle);
   
   return new Point(nx, ny);
 }