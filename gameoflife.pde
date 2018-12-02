
final int fps = 60;              // fps
final int updateCount = 1;      // nb of sim.update() before a draw(). do not enter a too big number
final int spawnRate = 12;        // 1 = screen is filled by cells ; 10 = 1 out 10 cell is initially alive

final color bgColor = color(60 , 0 , 140);
final color cellColor = color (255, 255 , 255, 32);
final boolean cloudMode = true;

final int radius = 2;  // radius of a cell in pixels

int sizeX;      // number of cells on the X-axis
int sizeY;      // number of cells on the Y-axis

Map sim;        // contains the data of simulation


void setup() {
  fullScreen();
  frameRate(fps);
  
  sizeX = width/radius;
  sizeY = height/radius;
  
  background(bgColor);
  
  sim = new Map(sizeX, sizeY, width / sizeX, height / sizeY, spawnRate);
  sim.setCellColor(cellColor);
  sim.setBgColor(bgColor);
  sim.cloudMode(cloudMode);
}


void draw() {
  sim.drawMap();
  for (int i = 0 ; i < updateCount ; i++ ) sim.update();
}

/** When you drag the mouse, you give life to new cells */
void mouseDragged() {
  sim.setCell(mouseX/radius, mouseY/radius, true);
  sim.setPreviousCell(mouseX/radius, mouseY/radius);
}
