color bgColor = color(204,229,255);
float circleSize= (random(4,8));

void setup() {
  size(800,950);
  fill(141, 208, 242);
  noStroke();
  rect(0, 0, 800, 150);
  fill(193, 233, 253);
  noStroke();
  rect(0, 150, 800, 140);
  fill(218, 193, 229);
  noStroke();
  rect(0, 290, 800, 135);
  fill(255, 204, 229);
  noStroke();
  rect(0, 425, 800, 128);
  fill(250, 222, 235);
  noStroke();
  rect(0, 553, 800, 112);
  fill(139, 127, 114);
  noStroke();
  rect(0, 665, 800, 95);
  fill(198, 185, 171);
  noStroke();
  rect(0, 760, 800, 85);
  fill(50, 50, 206);
  noStroke();
  rect(0, 845, 800, 65);
  fill(97, 71, 45);
  noStroke();
  rect(0, 910, 800, 40);
  fill(255, 255, 255);
  noStroke();
  rect(0, 570, 150, 340);
  rect(150, 710, 100, 200);
  rect(250, 360, 120, 550);
  rect(370, 630, 140, 280);
  rect(310, 280, 10, 100);
  rect(8, 520, 10, 50);
  rect(0, 545, 50, 10);
  frameRate(12);
}

void draw(){
  rectMode(CORNER);
  fill(bgColor, 5);

if(mousePressed)
  rectMode(CENTER);
  fill(255,255,255);
  noStroke();
  ellipse(mouseX,mouseY,circleSize,circleSize);
}
