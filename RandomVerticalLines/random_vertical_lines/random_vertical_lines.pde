class Line{
  float x, time;
  Line() {
    x = random(width / 2 - 100, width / 2 + 100);
    time = random(0, 2000);
  }
  
  void draw() {
    print(millis() % time);
    print("\n");
    if(millis() % time > 100 & millis() % time < 100) {
      stroke(255);
      line(x, 0, x, height);
    } else {
      stroke(0);
      line(x, 0, x, height);
      
    }
  }
};

Line[] lines = new Line[100];

void setup(){
  //size(1920,1080);
  fullScreen();
  background(0);
  smooth();
  strokeWeight(0.5);
  frameRate(30);
  
  for(int i = 0; i < 100; i++) {
    Line line = new Line();
    lines[i] = line;
  }
}

void draw(){
  float x = random(width / 2 - 100, width / 2 + 100);
  stroke(255);
  strokeWeight(random(1, 2.2));
  line(x, 0, x, height);
  delay(int(random(600, 1000)));
  if(random(0,1) > 0.7) {
      background(0);
  }
}
