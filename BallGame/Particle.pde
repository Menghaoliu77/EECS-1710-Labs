class Particle {

  // keep track the Body
  Body body;
 
  color c;
  float x,y;
  Vec2 pos ;
  // Constructor
  Particle(float x_, float y_) {
     x = x_;
     y = y_;
    c = color(random(255),random(255),random(255));
 

    // Add the box to the box2d world
    makeBody(new Vec2(x,y),10);
  }

  // removes the particle from the box2d world
  void killBody() {
    box2d.destroyBody(body);
  }

  boolean done() {
    // find the screen position of the particle
    pos = box2d.getBodyPixelCoord(body);
    if (pos.y > height+20) {
      killBody();
      return true;
    }
    return false;
  }

  // Drawing the box
  void display() {
    // Check each body and get its screen position
    pos = box2d.getBodyPixelCoord(body);
      fill(c);
      noStroke();
      ellipse(pos.x,pos.y,20,20);
   
  }

  // add the rectangle to the box2d world
  void makeBody(Vec2 center, float r) {
    // Define and create the body
    BodyDef bd = new BodyDef();
        bd.type = BodyType.DYNAMIC;

    bd.position.set(box2d.coordPixelsToWorld(center));
    body = box2d.createBody(bd);

    // Give it some initial random velocity
    body.setLinearVelocity(new Vec2(random(-1,1),random(-1,1)));

    // Make the body's shape to a circle
    CircleShape cs = new CircleShape();
    cs.m_radius = box2d.scalarPixelsToWorld(r);
    
    FixtureDef fd = new FixtureDef();
    fd.shape = cs;
  
    fd.density = 1;
    fd.friction = 0;  
    fd.restitution = 0.5;

    body.createFixture(fd);

  }

}
