public class CommandPanel {
  public float x;
  public float y;
  public float width;
  public float height;
  
  public Button drawTrajectory;
  
  public CommandPanel(float x, float y, float width, float height) {
    this.x = x;
    this.y = y;
    this.width = width;
    this.height = height;
    
    drawTrajectory = new Button(x + 10, y + 20, width - 10, height / 20, "Draw Trajectory");
  }
  
  public void draw() {
    strokeWeight(2);
    stroke(255);
    fill(0);
    rect(x, y, width, height);
    
    drawTrajectory.draw();
  }
  
  public void click() {
    drawTrajectory.checkIfClicked();
  }
}