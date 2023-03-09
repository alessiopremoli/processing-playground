PImage img; // Declare a variable of type PImage
int[] newPixels;
int count = 0;

void setup() {
  size(600,600);
  // Make a new instance of a PImage by loading an image file
  img = loadImage("t(1).jpg");
  newPixels = new int[600 * 600];
  noLoop();
}

void draw() {
  println(width, height);
  background(0);
  // Draw the image to the screen at coordinate (0,0)
  image(img,0,0);
  
  loadPixels();
  
  
  for(int y = 0; y < width; y++) {
    for(int x = 0; x < height; x++) {
      if(x % 2 == 0) {
        // println(x, y, (width - y - 1) * width + x);
        newPixels[x+y * width] = pixels[(width - y - 1) * width + x];
      } else {
        newPixels[x+y * width] = pixels[x+y * width];
      }
    }
  } 
  
  for (int i = 0; i < pixels.length; i++) {
    pixels[i] = newPixels[i];
  }
  
  // When we are finished dealing with pixels
  updatePixels();
}
