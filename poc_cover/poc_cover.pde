float linesHeight;
float linesWidth;
float linesPerRow = 368;
float lines = 4;

public void settings() {
  size(1840, 1840);
}

void setup() {
  surface.setResizable(true);
  noLoop();
  
  //background(255,0,0);
}

void draw() {
  linesHeight = height / lines;
  linesWidth = width / linesPerRow;
  noStroke();
  
  println(linesHeight, linesWidth, linesPerRow);
  for(int y = 0; y <= lines - 1; y++) {
    
     for(int x = 0; x <= linesPerRow; x++) {
       
       fill(x % 255);
       rect(float(x) * linesWidth, float(y) * linesHeight, linesWidth, linesHeight);
     }
  }
}
