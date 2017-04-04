/*
 * Note - All distances are in cm.
 */

public class Robot extends Entity {
  
  private int size = 20; // cm
  private float x;
  private float y;
  
  private float mass = 3;  // Kg
  
  private float speed = 0; // m/s
  private float accel = 0; // (m/s)/s
  
  private float angle = -PI/2;  // rad
  private float angvel = 0; // rad/s
  private float angacc = 0; // (rad/s)/s
  
  
  public Robot(float x, float y) {
    this.x = x;
    this.y = y;
    
  } // End of Constructor
  
  public void update() {
    if (accel == 0) speed *= 0.9;
    if (angacc == 0) angvel *= 0.9;
    
    speed += accel * Const.Ts;
    angvel += angacc * Const.Ts;
    angle += angvel * Const.Ts;
    
    x += speed * cos(angle);
    y += speed * sin(angle);
  } // End of update()
  
  public void draw() {
    
    
    float realSize = size * scale;
    float offset = - realSize/2;
    
    translate(x, y);
    rotate(angle);
    strokeWeight(1);
    stroke(255);
    fill(0);
    rect(offset, offset, realSize, realSize);
    fill(255);
    text("Front", 50, 0);
    rotate(PI/2);
    text("Right", 50, 0);
    rotate(PI);
    text("Left", 50, 0);
    //System.out.println(this.toString() + " Ts=" + Const.Ts + " accel=" + accel);
    rotate(-angle + PI/2);
    translate(-x, -y);
  } // End of draw()
  
  public String toString() {
    return String.format("x=%f, y=%f, v=%f, a=%f, av=%f, aa=%f", x, y, speed, accel, angvel, angacc);
  }
  
} // End of Class Robot