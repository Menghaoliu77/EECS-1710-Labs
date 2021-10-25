PImage bellhouse;
float rotSeconds = 0;
float rotMinutes = 0;
float rotHours = 0;
int lastSecond = 0;
int lastMinute = 0;
int lastHour = 0;

float faceSize = 500;
float lengthSecondHand = 220;
float lengthMinuteHand = 200;
float lengthHourHand = 100;

color outlineCol = color(153, 204, 255);
color secondCol = color(255, 153, 153);
color faceCol = color(255, 255, 204);

void setup() {
  size(1080, 608, P2D);
  
  bellhouse = loadImage("bellhouse.png");
  strokeWeight(2);
}

void draw() {
  background(bellhouse);
  
  int s = second();
  int m = minute();
  int h = hour();
  
  if(s != lastSecond){
    rotSeconds = ((float) s / 60) * TWO_PI;
    lastSecond = s;
  }
  
  if(s != lastMinute){
      rotMinutes = ((float) h / 60) * TWO_PI;
      lastMinute = m;
  }
  if(s != lastHour){
      rotHours = ((float) s / 12) * TWO_PI;
      println(h);
      lastHour = h;
  }
  
  fill(faceCol);
  stroke(outlineCol);
  ellipse(width/2, height/2, faceSize, faceSize);
  
  stroke(0, 127, 255, 44);
  for(int i=0; i<12; i++) {
    float rot = ((float) i/12) * TWO_PI;
    pushMatrix();
    translate(width/2, height/2);
    rotate(rot);
    line(0, faceSize/5, 0, faceSize/2);
    popMatrix();
  }
  
  pushMatrix();
  translate(width/2, height/2);
  rotate(rotSeconds);
  fill(secondCol);
  stroke(secondCol);
  line(0, 0, 0, -lengthSecondHand);
  ellipse(0, -lengthSecondHand, 10, 10);
  popMatrix();
  
  pushMatrix();
  translate(width/2, height/2);
  rotate(rotMinutes);
  fill(0);
  stroke(outlineCol);
  line(0, 0, 0, -lengthMinuteHand);
  ellipse(0, -lengthMinuteHand, 10, 10);
  popMatrix();
  
  pushMatrix();
  translate(width/2, height/2);
  rotate(rotHours);
  line(0, 0, 0, -lengthSecondHand);
  ellipse(0, -lengthHourHand, 10, 10);
  popMatrix();
  
  fill(faceCol);
  ellipse(width/2, height/2, 10, 10);
}
