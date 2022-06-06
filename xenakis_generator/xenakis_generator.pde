float l = 0;
float step;

void setup() {
   size(1500, 500);
   step = round(width / 24);
   println("Step: " + step);
   background(25, 25, 25);
}

void draw() {
  line(0, height/2, width, height / 2);
  stroke(255);
}

void generateAndDraw() {
   while (l <= width / 3) {
     // TODO: better box shaping: bigger at start, smaller at end
     float upper = height / 2 - (l/3);
     float lower = height / 2 + (l/3);
     float x_rand = random(upper,lower);
     println(l + " ~ " + upper + " - " + lower + " : " + x_rand);
     line(l, height / 2, width / 3, x_rand);
     stroke(255);
     line(width / 3, x_rand, 2 * width / 3, x_rand);
     stroke(255);
     line(2 * width / 3, x_rand, width - l, height / 2);
     stroke(255);
     l += random(step / 2, step);
   }
}

void mouseClicked() {
  l = 0;
  background(25, 25, 25);
  generateAndDraw();  
}
