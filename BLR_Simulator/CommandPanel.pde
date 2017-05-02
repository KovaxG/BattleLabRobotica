public class CommandPanel {
  public float x;
  public float y;
  public float width;
  public float height;
  
  public ArrayList<Button> buttons = new ArrayList<Button>();
  
  public CommandPanel(float x, float y, float width, float height) {
    this.x = x;
    this.y = y;
    this.width = width;
    this.height = height;
    
    // Button that draws the trajectory of the robot
    Button drawTrajectory = new Button(x + 10, y + 20, width - 10, height / 20, "Draw Trajectory", new Behavior() {
      public void onActive() {
        memoriseTrajectory = true;
      }
      
      public void deActive() {
        memoriseTrajectory = false;
        trajectory.clear();
      }
    });
    
    // Button that sets the enemy at the mouse cursor
    Button addEnemy = new Button(x + 10, y + 60, width - 10, height / 20, "Enemy", new Behavior() {
      public void onActive() {
        System.out.println("MouseFollower Clicked");
        dummy.mouseFollower = true;
      }
      
      public void deActive() {
        dummy.mouseFollower = false;
        dummy.x = 1000;
        dummy.y = 1000;
      }
    });
    
    // Button that starts and stops the switch
    Button killSwitch = new Button(x + 10, y + 100, width - 10, height / 20, "Switch", new Behavior() {
      public void onActive() {
        SWITCH = true;
      }
      
      public void deActive() {
        SWITCH = false;
      }
    });
    
    buttons.add(drawTrajectory);
    buttons.add(addEnemy);
    buttons.add(killSwitch);
  }
  
  public void draw() {
    strokeWeight(2);
    stroke(255);
    fill(0);
    rect(x, y, width, height);
    
    for (Button button : buttons) button.draw();
  }
  
  public void click() {
    for (Button button : buttons) button.checkIfClicked();
  }
}