
PImage background,bread,smile,cry,normal,net;
Snake snake1 = new Snake();
Snake snake2 = new Snake();
boolean attract = true;
void setup(){
  size(1918,961);
  background = loadImage("background.jpg");
  bread = loadImage("bread.png");
  smile = loadImage("smile.png");
  cry = loadImage("cry.png");
  normal = loadImage("normal.png");
  net = loadImage("net.png");
}

void draw(){
  background(background);
  
  push();
  imageMode(CENTER);
  
  if(mousePressed){
    image(net,mouseX,mouseY,300,300);
  }else{
    image(bread,mouseX,mouseY,300,300);
  }
  
  snake1.show();
  snake1.update();
  snake2.show();
  snake2.update();
  
  pop();


}

class Snake{
  float x,y,len;
  PVector speed;
  
  
  Snake(){
   x = random(1)*width;
   y = random(1)*height;
   speed = new PVector(random(-2,2),random(-2,2));
   len = random(1,6);
   
  }
  
  void show(){
    if(mousePressed&&dist(x,y,mouseX,mouseY)<200){
      image(cry,x,y,250,250);   
      attract = false;
    }else if(dist(x,y,mouseX,mouseY)<300){
      image(smile,x,y,250,250);  
      attract = true;
    }else{
      image(normal,x,y,250,250); 
      attract = true;
    }
  
  
  }
  
  void update(){
    speed.x = (mouseX-x)/abs(mouseX-x)*len;
    speed.y = (mouseY-y)/abs(mouseY-y)*len;
    if(attract){
     x+=speed.x;
    y+=speed.y;
    } 
   
    if(x<0||x>width){
      speed.x*=-1;
    }
    if(y<0||y>height){
      speed.y*=-1;
    }
  
  
  }


}
