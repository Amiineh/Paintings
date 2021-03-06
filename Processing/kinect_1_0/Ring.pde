class Ring {
  float x, y;          // X-coordinate, y-coordinate
  float diameter;      // Diameter of the ring
  boolean on = false;  // Turns the display on and off

  void start(float xpos, float ypos) {
    x = xpos;
    y = ypos; 

    diameter = 1;
    on = true;
  }
  
  void grow() {
    if (on == true) {
      diameter += 3;
      if (diameter > 400) {
        on = false;
        diameter = 1;
      }
    }
  }

  void display() {
    if (on == true) {
      noFill();
      strokeWeight(2);
      stroke(40, 153);
      ellipse(x, y, diameter, diameter);
    }
  }
}
