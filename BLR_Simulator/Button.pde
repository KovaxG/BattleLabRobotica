public class Button {
  private float x;
  private float y;
  private float width;
  private float height;
  private String _text;
  private Behavior behavior;
  
  private boolean active = false;
  
  public Button(float x, float y, float width, float height, String txt, Behavior beh) {
    this.x = x;
    this.y = y;
    this.width = width;
    this.height = height;
    this._text = txt;
    this.behavior = beh;
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
        behavior.deActive();
      }
      else {
        active = true;
        behavior.onActive();
      }
    }
  }
}

public interface Behavior {
  void onActive();
  void deActive();
}