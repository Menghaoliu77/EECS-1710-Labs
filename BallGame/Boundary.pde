class Boundary {

  // A boundary is a rectangle with x, y, width, and height
  float x;
  float y;
  float w;
  float h;
  // make a body for box2d
  Body b;
  BodyDef bd ;
  PolygonShape sd ;
  boolean destoried;
  color c;

 Boundary(float x_,float y_, float w_, float h_, float a,color c) {
    x = x_;
    y = y_;
    w = w_;
    h = h_;
    this.c =c;

    // Define the polygon
    sd = new PolygonShape();
    // Figure out the box2d coordinates
    float box2dW = box2d.scalarPixelsToWorld(w/2);
    float box2dH = box2d.scalarPixelsToWorld(h/2);
    // setting a box
    sd.setAsBox(box2dW, box2dH);


    // Create the body
    bd = new BodyDef();
    bd.type = BodyType.STATIC;
    bd.angle = a;
    bd.position.set(box2d.coordPixelsToWorld(x,y));
    b = box2d.createBody(bd);
    
    // Adding the shape to the body by using a Fixture
    b.createFixture(sd,1);
  }
  
  void destory(){
     box2d.destroyBody(b);
     destoried = true;
  }

  // Draw the boundary, if it were at an angle we'd have to do something fancier
  void display() {
 
    if(!destoried){
        noFill();
    stroke(0);
    strokeWeight(1);
    rectMode(CENTER);

    float a = b.getAngle();

    pushMatrix();
    translate(x,y);
    rotate(-a);
    fill(c);
    rect(0,0,w,h);
    popMatrix();
    }
  }

}
