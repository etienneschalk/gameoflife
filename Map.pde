
import java.util.concurrent.ThreadLocalRandom;  // for random numbers

/** Represents the environment of the game of life */
class Map {
  private Cell[][] area; // The main attribute : a 2D-array of Cells
  
  private int sizeX;
  private int sizeY;
  private int pixelX;  // nb of pixel per cell
  private int pixelY;  // nb of pixel per cell
  
  private int cellColor;
  private int bgColor;
  
  private boolean cloudMode;   // does not draw 
  
  public Map(int sizeX, int sizeY) {
    this(sizeX, sizeY, 1, 1);  
  }
  
  public Map(int sizeX, int sizeY, int pixelX, int pixelY) {
    this(sizeX, sizeY, pixelX, pixelY, 10);  // by default the spawn rate is 1 out 10
  }
  
  public Map(int sizeX, int sizeY, int pixelX, int pixelY, int spawnRate) {
    this.sizeX = sizeX;
    this.sizeY = sizeY;
    this.pixelX = pixelX;
    this.pixelY = pixelY;
    
    this.cellColor = color(255);  // by default a cell is white
    this.bgColor = color(0);      // by default the background is black
    this.cloudMode = false;           // by default the cloud mode is disabled
    
    this.area = new Cell[sizeX][sizeY];
    
    for (int x = 0 ; x < sizeX ; x++) {
      for (int y = 0 ; y < sizeY ; y++) {
        this.area[x][y] = new Cell(x,y);
        
        if (spawnProbability(spawnRate)) {
          this.area[x][y].born();
          this.area[x][y].setPrevious();
        }
      }
      
    }
    
  }
  
  public void setCellColor(color o) {
    this.cellColor = o;
  }
  
  public void setBgColor(color o) {
    this.bgColor = o;
  }
  
  public void setCell(int x, int y, boolean alive) {
    this.area[x][y].setAlive(alive);
  }
  
  public void setPreviousCell(int x, int y) {
    this.area[x][y].setPrevious();
  }
  
  public void cloudMode(boolean b) {
    this.cloudMode = b;
  }
  
  private boolean spawnProbability(int n) {
    // Probability is 1 out n
    // (min, max + 1) if we want to include max
    
    // (min, max) if we don't want to include max -> in our case, 1 cell out n will be alive
    int r = ThreadLocalRandom.current().nextInt(0, n);
    if (r==0) return true;
    return false;
  }
  
  private int countNeighboursAlive(int x, int y) {
    int count = 0;
    
    // Solution of facility : if a cell is at a border, we consider it has no neighbour
    if (x == 0 || x == sizeX-1 || y == 0 || y == sizeY-1) {
      return 0;
    }
    
    else {
      if (this.area[x-1][y-1].wasAlive()) count++;
      if (this.area[x]  [y-1].wasAlive()) count++;
      if (this.area[x+1][y-1].wasAlive()) count++;
      
      if (this.area[x-1][y].wasAlive()) count++;
      if (this.area[x+1][y].wasAlive()) count++;
      
      if (this.area[x-1][y+1].wasAlive()) count++;
      if (this.area[x]  [y+1].wasAlive()) count++;
      if (this.area[x+1][y+1].wasAlive()) count++;
    }
    return count;
  }
  
  /** Updates the state of one cell */
  private void updateCell(int x, int y) {
    int count = this.countNeighboursAlive(x, y);
    
    if (this.area[x][y].wasAlive()) {
      if ( ! (count == 2 || count == 3) ) 
        this.area[x][y].die();
    }
    
    else {
      if ( count == 3 ) 
        this.area[x][y].born();
    }
    
  }
  
  /** 
    Updates the state of all cells, using updateCell() 
    Then, it backup the current state in the attribute "previous" of Cell.
  */
  private void update() {
    // Updating each cell of the map
    for (int x = 0 ; x < sizeX ; x++) {
      for (int y = 0 ; y < sizeY ; y++) {
        this.updateCell(x, y);
      }
    }
    
    // Updating the previous states
    // This operation can only be made after the update of all the map
    for (int x = 0 ; x < sizeX ; x++) {
      for (int y = 0 ; y < sizeY ; y++) {
        this.area[x][y].setPrevious();
      }
    }
  } 
  
  /* Draw the map. This method is called in the main Processing's loop draw() */
  public void drawMap() {
    noStroke();
    
    for (int x = 0 ; x < sizeX ; x++) {
      for (int y = 0 ; y < sizeY ; y++) {
        
        if ((this.area[x][y].isAlive())) {
          fill( this.cellColor );
          rect(x * pixelX , y * pixelY , pixelX , pixelY);
        }
        
        else { 
          if (! cloudMode) {
            fill(bgColor); 
            rect(x * pixelX , y * pixelY , pixelX , pixelY); 
          }
        }      
        
      }
    }
  }
}
