import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;

PImage background,wait,win,fail,start,tip1,tip2,gotit;
boolean gameover;
// A reference to our box2d world
Box2DProcessing box2d;
int count=0;
// A list we use to track fixed objects
ArrayList<Boundary> boundaries;
int sceneIndex = 0;
// A list for all particle systems
ArrayList<ParticleSystem> systems;
ParticleSystem system;
color c1,c2;
int startTime;

void setup() {
  size(1007,1000);
  smooth();
  background = loadImage("background.jpg");
  wait = loadImage("wait.png");
  win = loadImage("win.png");
  fail = loadImage("fail.png");
  start = loadImage("start.jpg");
  tip1 = loadImage("tip1.png");
  tip2 = loadImage("tip2.png");
  gotit = loadImage("gotit.png");
  // Initialize box2d physics and create the world
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  

  // Setting a customize gravity
  box2d.setGravity(0, -20);
   system = new ParticleSystem(400, new PVector(270,40));
  // Create ArrayLists	
  systems = new ArrayList<ParticleSystem>();
  boundaries = new ArrayList<Boundary>();
  c1 = color(255);
  c2 = color(255,0,0);
  // Add a bunch of fixed boundaries
  boundaries.add(new Boundary(50,50,1550,5,-0.3,c1));
  boundaries.add(new Boundary(860,280,200,5,0,c2));
  boundaries.add(new Boundary(960,150,5,300,PI,c1));
  boundaries.add(new Boundary(600,400,300,5,0,c2));
  boundaries.add(new Boundary(780,500,300,5,0,c2));
  //bottom
  boundaries.add(new Boundary(width/2,height-10,width,5,0,c1));
  boundaries.add(new Boundary(0,height-50,5,100,PI,c1));
  boundaries.add(new Boundary(width,height-50,5,100,PI,c1));

}

void draw() {
  if(sceneIndex==0){
  seceneStart();
  }else{
  sceneMain();
  }

}
void seceneStart(){
  image(start,0,0);
  image(gotit,width-300,height-200,200,200);

}

void sceneMain(){
  image(background,0,0);
  textSize(20);
  fill(158,10,10);
  text("Balls:(>200):"+system.particles.size(),800,30);
 
  
  box2d.step();
 
    system.run();
     

  // Display all boundaries
  for (Boundary wall: boundaries) {
    wall.display();
  }
  if(millis()-startTime<5000){
  image(tip1,550,20,400,200);
  }
    if(millis()-startTime<10000){
  image(tip2,550,320,400,200);
  }
  
  
  if(gameover){
    if(system.particles.size()>200){
    image(win,400,700,300,300);
    }else{
    image(fail,400,700,300,150);
    }
  
  }else{
  image(wait,400,700,300,300);
  }
}


void mouseClicked(){
  if(dist(mouseX,mouseY,866,289)<50){
    boundaries.get(1).destory();
    boundaries.add(new Boundary(870,280,200,5,1,c2));  
  }
    if(dist(mouseX,mouseY,600,407)<50){
    boundaries.get(3).destory();
    boundaries.add(new Boundary(600,400,300,5,-1,c2));  
  }
    if(dist(mouseX,mouseY,790,510)<50){
    boundaries.get(4).destory();
    boundaries.add(new Boundary(780,600,300,5,0.5,c2));
  }
     if(dist(mouseX,mouseY,814,900)<100&&sceneIndex==0){
    sceneIndex++;
    startTime = millis();
  }

}
