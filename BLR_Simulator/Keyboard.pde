public class Keyboard {
  boolean aPressed = false;
  boolean dPressed = false;
  boolean wPressed = false;
  boolean sPressed = false;
  
  public boolean isPressed(char c) {
    switch(c){
    case 'a': return aPressed;
    case 'd': return dPressed;
    case 'w': return wPressed;
    case 's': return sPressed;
    }
    
    return false;
  }
}