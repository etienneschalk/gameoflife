
/** This class represents a cell in the game */
class Cell {
  private int x;
  private int y;
  private boolean alive;
  private boolean previous;  // previous state of a cell
  
  /** A cell is dead by default with this constructor */
  public Cell(int x, int y) {
    this(x, y, false);
  }
  
  /** General constructor */
  public Cell(int x, int y, boolean alive) {
    this.x = x;
    this.y = y;
    this.alive = alive;
    this.previous = alive;  // by default, previous is the exact copy of current (to initialize the simulation)
  }
  
  public int getX() {
    return x;
  }
  
  public int getY() {
    return y;
  }
  
  public boolean isAlive() {
    return alive;
  }
  
  public boolean wasAlive() {
    return previous;
  }
  
  public void setX(int x) {
    this.x = x;
  }
  
  public void setY(int y) {
    this.y = y;
  }
  
  public void setAlive(boolean alive) {
    this.alive = alive;
  }
  
  public void die() {
    this.alive = false;
  }
  
  public void born() {
    this.alive = true;
  }
  
  /** Copy the current state of alive into previous */
  public void setPrevious() {
    this.previous = alive;  
  }
  

  
}
