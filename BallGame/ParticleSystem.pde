class ParticleSystem  {

  ArrayList<Particle> particles;    
  PVector origin;         
  // An origin point for where particles are birthed

  ParticleSystem(int num, PVector v) {
    particles = new ArrayList<Particle>();             
    // Initialize the ArrayList
    origin = v.get();                        
    // Store the origin point
//println(num);
      for (int i = 0; i < num; i++) {
      particles.add(new Particle(origin.x,origin.y));    
      // Add "num" amount of particles to the ArrayList
    }
  }

  void run() {
    // Display all the particles
    for (Particle p: particles) {
      p.display();
    }

    gameover = true;
    for (int i = particles.size()-1; i >= 0; i--) {
      Particle p = particles.get(i);
        if(p.pos.y<height/2){
          gameover = false;
        }
      if (p.done()) {
      
        particles.remove(i);
      }
    }
  }

  void addParticles(int n) {
    for (int i = 0; i < n; i++) {
      particles.add(new Particle(origin.x,origin.y));
    }
  }

  boolean dead() {
    if (particles.isEmpty()) {
      return true;
    } 
    else {
      return false;
    }
  }

}
