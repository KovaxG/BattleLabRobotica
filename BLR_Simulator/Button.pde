public class Button {
  public float x;
  public float y;
  public float width;
  public float height;
  public String _text;
  
  public boolean active = false;
  
  public Button(float x, float y, float width, float height, String txt) {
    this.x = x;
    this.y = y;
    this.width = width;
    this.height = height;
    this._text = txt;
  }
  
  public void draw() {
    strokeWeight(2);
    stroke(255);
    
    if (active) {
      fill(150);
    }
    else {
      fill(0);
    }
    rect(x, y, width, height);
    fill(255);
    text(_text, x  + 3, y + 15);
  }
  
  public boolean mousedOver() {
    return (x < mouseX && mouseX < x + this.width) && (y < mouseY && mouseY < y + this.height);
  }
  
  public void checkIfClicked() {
    
    if (mousedOver()) {
      if (active) {
        active = false;
        memoriseTrajectory = false;
        trajectory.clear();
      }
      else {
        active = true;
        memoriseTrajectory = true;
      }
    }
  }
}