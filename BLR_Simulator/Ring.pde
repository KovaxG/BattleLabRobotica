public class Ring extends Entity {
  
  private int x;
  private int y;
  private int size = 150;
  
  public Ring(int x, int y) {
    this.x = x;
    this.y = y;
  } // End of Constructor
  
  public void draw() {
    
    strokeWeight(10);
    stroke(255);
    fill(0);
    
    float realSize = size * scale;
    
    ellipse(x, y, realSize, realSize);
  } // End of draw()
} // End of Class Ring