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
  
  return normalDistance;
}
float distance(float x1, float y1, Point p2) {
  return distance(x1, y1, p2.x, p2.y);
}
float distance(Point a, Point b) {
  return distance(a.x, a.y, b.x, b.y);
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
  
  public boolean equals(Object obj) {
    if (!(obj instanceof Object)) return false;
    Point that = (Point)obj; 
    
    return (that.x == this.x) && (that.y == this.y);
  }
  
  public String toString() {
    return String.format("(%.4f, %.4f)", this.x, this.y);
  }
} // End of Class

// roatatePoint - rotates the point by a given angle
 Point rotatePoint(float x, float y, float angle) {
   float nx = x * cos(angle) + y * -sin(angle);
   float ny = x * sin(angle) + y *  cos(angle);
   
   return new Point(nx, ny);
 }
 Point rotatePoint(Point a, float angle) {
   return rotatePoint(a.x, a.y, angle);
 }
 
 // translatePoint - translates a point by a given offset in x and y
 Point translatePoint (Point a, float dx, float dy) {
   return new Point(a.x + dx, a.y + dy);
 }
 
 // Call draw Line one two points rather than four floats
 void line(Point a, Point b) {
   line(a.x, a.y, b.x, b.y);
 }
 
 // Call rect on a point rather than two floats
 void rect(Point a, float w, float h) {
   rect(a.x, a.y, w, h);
 }