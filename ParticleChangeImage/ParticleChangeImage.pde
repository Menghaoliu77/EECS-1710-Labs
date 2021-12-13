 
import java.util.Collections;

class Particle
{
  PVector Pos;
  PVector Vel;
  PVector Target;
  float Lerp;
  
  color particleColor;
  color TargetColor;
  float LerpColor;
  
  float Scale;
  float VelS;
  float TargetS;
  float LerpS;
  
  boolean isCycleMode = false;
  boolean isCycleMode_init;
  float TargetR;
  float CurrentR;
  float CurrentTheta;
  float LerpR;
  float RotSp;
  int millis;
  int PreMillis = 0;
  int PreMillis2 = 0;
  int Timer = 0;
  int FrameTimer = 0;
  
  boolean isExplosion = false;
  PVector force;
  float k;
  float m;
  float divX = random(-4,4);
  float divY = random(-4,4);

  ArrayList<PVector> History = new ArrayList<PVector>();
  static final int MaxIndex = 1;
  static final int FrameSkipFPS = 50;
  
  Particle(PVector Pos, float Scale, float Lerp, float LerpS, float LerpR, 
  float ColorLerp, color particleColor, boolean isCycleMode, int millis)
  {
    this.Pos = Pos.copy();
    this.Target = Pos.copy();
    this.Vel = new PVector(0, 0);
    this.Scale = Scale;
    this.Lerp = Lerp;
    this.particleColor = particleColor;
    this.LerpColor = ColorLerp;
    this.TargetColor = particleColor;
    this.LerpS = LerpS;
    this.LerpR = LerpR;
    this.TargetS = Scale;
    this.isCycleMode_init = isCycleMode;
    this.millis = millis;
  }
  
  void setTarget(PVector Target)
  {
    this.Target = Target.copy();
  }
  
  void setTarget(PVector Target, float TargetR, float RotSp_Rad)
  {
    this.Target = Target.copy();
    this.isCycleMode = this.isCycleMode_init;
    this.Timer = 0;
    this.RotSp = RotSp_Rad;
    this.PreMillis = millis();
    
    this.TargetR = TargetR;
    this.CurrentR = dist(Target.x, Target.y, Pos.x, Pos.y);
    this.CurrentTheta = atan2(Pos.y - Target.y, Pos.x - Target.x);
    this.isExplosion = false;
  }

  void setColorTarget(color newColor)
  {
    this.TargetColor = newColor;
  }
  
  void setScaleTarget(float newScale)
  {
    this.TargetS = newScale;
  }
  
  void setMillis(int newMillis)
  {
    this.millis = newMillis;
  }
  
  void explosion(PVector force, float k, float m)
  {
    this.isExplosion = true;
    this.force = force.copy();
    this.k = k;
    this.m = m;
    this.Vel.add(this.force.copy().div(m));
  }
  
  void update()
  {
    this.FrameTimer += this.PreMillis2 == 0 
      ? 0 : millis() - this.PreMillis2; 
    this.PreMillis2 = millis();
    float FrameSkipMS = 100 / FrameSkipFPS;
    
    if (this.FrameTimer < FrameSkipMS)
      return;
    if (this.isCycleMode)
      this.Timer = millis() - this.PreMillis;
    
    int SkipLength = floor(this.FrameTimer / FrameSkipMS) + 1;  
    this.FrameTimer = 0;
    
    if (isExplosion)
    {
      PVector newPos = this.Pos.copy()
        .add(this.Vel.copy().mult(FrameSkipMS * 0.01));
      PVector springF = new PVector(
        -this.k * (newPos.x - this.Target.x),
        -this.k * (newPos.y - this.Target.y)
      );
      this.Vel.add(springF.div(this.m));
      this.Pos.add(this.Vel.copy().mult(FrameSkipMS * 0.1));
    }
    else if (isCycleMode)
    {
      this.CurrentTheta += this.RotSp;
      this.CurrentR += (this.TargetR - this.CurrentR) 
        * (1 - pow(this.LerpR - 1, SkipLength - 1) * pow(this.LerpR, 1 - SkipLength));
      this.Pos.set(
        this.Target.x + this.CurrentR * cos(this.CurrentTheta),
        this.Target.y + this.CurrentR * sin(this.CurrentTheta)
      );
      
      if (this.Timer >= this.millis)
        this.isCycleMode = false;
    }
    else
    {
      this.Vel = new PVector(
        (this.Target.x - this.Pos.x) 
        * (1 - pow(this.Lerp - 1, SkipLength - 1) * pow(this.Lerp, 1 - SkipLength)),
        (this.Target.y - this.Pos.y) 
        * (1 - pow(this.Lerp - 1, SkipLength - 1) * pow(this.Lerp, 1 - SkipLength))
      );
      this.Pos.add(this.Vel);
    }
    
    this.VelS = (this.TargetS - this.Scale) 
      * (1 - pow(this.LerpS - 1, SkipLength - 1) * pow(this.LerpS, 1 - SkipLength));
    this.Scale += this.VelS;
        
    this.particleColor = lerpColor(
      this.particleColor,
      this.TargetColor,
      this.LerpColor
    );
    
    this.History.add(this.Pos.copy());
      if (this.History.size() > MaxIndex)
        this.History.remove(0);
  }
  
  void render()
  {
    noStroke();
    fill(this.particleColor);
    ellipse(
      this.Pos.x+divX, this.Pos.y+divY, 
      this.Scale*1.5, this.Scale*1.5
    );
 
  }
}

class Particle2 {
  PVector loc;
  int radius;
  float theta = 0;
  float thetaScale;
  float dy;
  float driftX;
  PVector wind;
  color c;
  
  Particle2(PVector loc, color c, int radius, PVector wind) {
    this.loc = loc;
    this.c = c;
    this.radius = radius;    
    this.wind = wind;
    thetaScale = random(1, 4);
    dy = random(1, 4);
    driftX = random(-1.0, 1.0);
  }
  
  void update() {
    loc.x += driftX + cos(thetaScale*theta) + wind.x;
    theta += 0.1;
    loc.y -= dy + wind.y;
  }
  
  boolean isOffscreen() {
    return (loc.x < 0) || (loc.x >= width) || (loc.y < 0) || (loc.y >= height);
  }
  
  void draw() {
    if(!isOffscreen()) {
      for(int yOff = 0; yOff < radius; yOff++) {
        for(int xOff = 0; xOff < radius; xOff++) { 
          int i = ((int)loc.y+yOff)*width + (int)loc.x + xOff;
          if(i < pixels.length) {
            pixels[i] = c;
          }
        }
      }
    }
  }
  
 

}
  
class ParticleSystem
{
  PImage CurrentImage;
  ArrayList<Particle> ParticleList = new ArrayList<Particle>();
  ArrayList<Particle> Remain = new ArrayList<Particle>();
  int Interval;
  float Scale;
  float Lerp;
 
  
  static final float k = 2;
  static final float m = 1;
  static final float explosion = 500;
  static final float limit = 0.1;
  static final int range = 5;
  static final int bands = 512;
 
  static final int explosionDelay = 500;
  int explosionTimer = 0;
  int preTime = 0;
 
  
  ParticleSystem(PImage Image, int Interval, float Lerp, int width, int height)
  {
 
    
    this.CurrentImage = Image.copy();
    this.Interval = Interval;
    this.Scale = Interval;
    this.Lerp = Lerp;
    
    this.CurrentImage.loadPixels();

    for (int i=0; i < this.CurrentImage.height; i += Interval)
    {
      for (int j=0; j < this.CurrentImage.width; j += Interval)
      {
        int index = ((i - 1) 
          - (i - 1) % Interval) / Interval 
          + ((j - 1) 
          - (j - 1) % Interval) / Interval;
        color c = this.CurrentImage.get(j, i);
        Particle newParticle = new Particle(
          getSideVec(),
      
          this.Scale,
          Lerp, Lerp, 10, 0.15,
          color(255), true, index * 20 + 500
        );
        newParticle.setColorTarget(c);
        newParticle.setTarget(new PVector(
          j + width * 0.5 - this.CurrentImage.width * 0.5, 
          i + height * 0.5 - this.CurrentImage.height * 0.5
        ), 30, ((new float[] { -.15, .15 })[int(random(2))]));
        this.ParticleList.add(newParticle);
      }
    }
  }
  
  PVector getSideVec()
  {
    int[][] side = {
      { width + 100, height + 100 },
      { -100, -100 }
    };
    int randomize1 = int(random(2));
    int randomize2 = int(random(2));
    
    PVector newPos = randomize1 == 0 
      ? new PVector(
        random(width),
        side[randomize2][1 - randomize1]
      )
      : new PVector(
        side[randomize2][1 - randomize1],
        random(height)
      );
      
    return newPos;
  }
  
  void changeImage(PImage newImage)
  {
    this.CurrentImage = newImage.copy();
    this.CurrentImage.loadPixels();
    
    int w = ((this.CurrentImage.width - 1) 
      - (this.CurrentImage.width - 1) % Interval) / Interval;
    int h = ((this.CurrentImage.height - 1) 
      - (this.CurrentImage.height - 1) % Interval) / Interval;
    int Length = (w + 1) * (h + 1);  
    int diff = Length - this.ParticleList.size();
    int Remain = this.Remain.size();

    for (int i=0; i < abs(diff); i++)
    {
      if (diff > 0)
      {
        if (Remain > i)
        {
          this.ParticleList.add(this.Remain.get(0));
          this.Remain.remove(0);
        }
        else
        {
          Particle newParticle = new Particle(
            getSideVec().copy(),
            this.Scale,
            this.Lerp, this.Lerp, 10, 0.15,
            color(255), true, 0
          );
          this.ParticleList.add(newParticle);
        }
      }
      else
      {
        this.ParticleList.get(0).setColorTarget(color(255));
        this.ParticleList.get(0).setTarget(getSideVec());
        this.Remain.add(this.ParticleList.get(0));
        this.ParticleList.remove(0);
      }
    }

    Collections.shuffle(this.ParticleList);
    
    int k = 0;
    for (int i=0; i < this.CurrentImage.height; i += Interval)
    {
      for (int j=0; j < this.CurrentImage.width; j += Interval)
      {
        int index = ((i - 1) 
          - (i - 1) % Interval) / Interval 
          + ((j - 1) 
          - (j - 1) % Interval) / Interval;
        color c = this.CurrentImage.get(j, i);
        this.ParticleList.get(k).setMillis(index * 20 + 500);
        this.ParticleList.get(k).setColorTarget(c);
        this.ParticleList.get(k).setTarget(new PVector(
          j + width * 0.5 - this.CurrentImage.width * 0.5, 
          i + height * 0.5 - this.CurrentImage.height * 0.5
        ), 30, (new float[] { -.15, .15 })[int(random(2))]);
        this.ParticleList.get(k).setScaleTarget(this.Scale);
        k++;
      }
    }
  }
  
  void explosion()
  {
    //println("explosion");
    int newRange = int(random(1, range + 1));
    int currentX = int(random(
      newRange, 
      round(this.CurrentImage.width / this.Interval) - newRange + 1
    ));
    int currentY = int(random(
      newRange, 
      round(this.CurrentImage.height  / this.Interval) - newRange + 1
    ));
    
    for (float i=-90; i < 180; i += 10)
    {
      float rad = radians(i);
      
      int right_x = round(currentX + newRange * cos(rad));
      int left_x = round(currentX + newRange * -cos(rad));
      int y = round(currentY + newRange * sin(rad));

      for (int j=0; j < abs(right_x - left_x); j++)
      {
        float a = 2 * rad * (j / abs(right_x - left_x));
        PVector force = new PVector(
          random(explosion) * cos(abs(a - rad)) 
            * (a - rad == 0 ? 1 : (a - rad) / abs(a - rad)),
          random(explosion) * sin(abs(a - rad)) 
              * (a - rad == 0 ? 1 : (a - rad) / abs(a - rad))
        );

        ParticleList.get(
          round(y * floor(this.CurrentImage.width / this.Interval) 
           + currentX + j - abs(right_x - left_x) / 2)
        ).explosion(force, k, m);
      }
    }
  }
  
  void update()
  {
    for (Particle p : ParticleList)
      p.update();
      
    for (Particle p : Remain)
      p.update();
      
 
    if (this.explosionTimer < explosionDelay)
      this.explosionTimer += this.preTime == 0 
        ? 0: millis() - this.preTime;
    this.preTime = millis();
 
  }
  
  void render()
  {
    for (Particle p : ParticleList)
      p.render();
      
    for (Particle p : Remain)
      p.render();
  }
}
void reset() {   
    img = loadImage("3.jpg");
    img.loadPixels();      
    //println("img height: "+img.height+" img width: "+img.width+" tot pixels: "+img.width * img.height);
    
    xOffset = max(0, (width - img.width)/2);
    yOffset = max(0, (height - img.height)/2);
    radius = 4;
    //println("xoffset: "+xOffset+" yoffset: "+yOffset +" radius: "+radius);
        
    pixelsToRemove = new IntList();
    for(int y=0; y < img.height; y += radius) {
      for(int x=0; x < img.width; x += radius) {
        pixelsToRemove.append(y*img.width + x);        
      }
    }    
    //println("num pixels to remove: "+pixelsToRemove.size());      
    pixelsToRemove.shuffle();  
}
ParticleSystem p;
String[] Photos = {
  "1.jpg",
  "2.jpg",
  "3.jpg"
 
};
int index = 0;
int MaxFrame = 50;
int Frame = MaxFrame;
PImage image0;
boolean change;
PImage img;
ArrayList<Particle2> particles2;
ArrayList<Particle2> newParticles;
IntList pixelsToRemove;
int xOffset = 144;
int yOffset = 22;
int maxParticles = 50000;
int radius;

void setup()
{
  size(1000, 1000);
  image0 = loadImage(Photos[0]);
  frameRate(30);
 
      particles2 = new ArrayList<Particle2>();
    newParticles = new ArrayList<Particle2>();
    reset(); 
  p = new ParticleSystem(
    loadImage(Photos[0]),
    16, 6,
    width, height
    
  );
}

void draw()
{
  //clear();
  
  background(0);
  
  
if(index<=2){
if(change){
  if (MaxFrame > Frame)
    Frame++;
  
  p.update();
  p.render();
}else{
image(image0,144,22);}
}

if(index==3){
    
    //if(particles2.size() == 0 && pixelsToRemove.size() == 0) {
    //  reset();
      
    //}
    //println(particles2.size() );
    while(pixelsToRemove.size() > 0 && (particles2.size() < maxParticles)) {
      int i = pixelsToRemove.get(0);
      pixelsToRemove.remove(0);
      
      int y = (i / img.width);
      int x = (i - y * img.width) + xOffset;
      y += yOffset;
      
      color origColor = img.pixels[i];
      
      for(int yOff = 0; yOff < radius; yOff++) {
        for(int xOff = 0; xOff < radius; xOff++) { 
          i = (y + yOff - yOffset) * img.width + x + xOff - xOffset;
          if(i < img.pixels.length) {            
            img.pixels[i] = color(0, 0, 0);
          }
        }
      }
      Particle2 p = new Particle2(new PVector(x, y), origColor, radius, new PVector(-2.8, 0.0));
      particles2.add(p);  
      
    }
        
    img.updatePixels();
    loadPixels();    
  
    newParticles.clear();
    for(Particle2 p : particles2) {
      p.update();
      p.draw();
      if(!p.isOffscreen()) {
        newParticles.add(p);
      }            
    }  
    
    ArrayList<Particle2> tmp = particles2;
    particles2 = newParticles;        
    newParticles = tmp;
    updatePixels(); 
    fill(255);
   
}
}

void mouseClicked()
{
  
 
  change = true;
  if (MaxFrame <= Frame)
    Frame = 0;
  else 
    return;
    
  index = index + 1;
 if(index<=2){
 p.changeImage(loadImage(Photos[index]));
 }
  
}
