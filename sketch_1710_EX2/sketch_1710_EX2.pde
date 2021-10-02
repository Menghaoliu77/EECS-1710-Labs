PImage sand, butter, monkey;
float x = 200, y = 200, s = 109, t = 133, z = 3, r = 1;

void setup() {
  size(780, 564, P2D);
  
  sand = loadImage("sandbeach.png");
  butter = loadImage("butterfly.png");
  monkey = loadImage("monkey.png");
  
}

void draw() {
  background(sand);
  
  imageMode(CENTER);
  image(butter, mouseX, mouseY, 30, 30);
  
  imageMode(CORNER);
  image(monkey, x, y, s, t);
  x += z;
  y += r;
  
  if (x > (width - s) || x < 0) {
    z *= -1;
  } 
  
  if (y > (height - t) || y < 0) {
    r *= -1;
  }
  
}
