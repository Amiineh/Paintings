class Line {
  float x1, x2, y1, y2;
  
  void start(float x1, float x2, float y1, float y2){
    this.x1 = x1;
    this.x2 = x2;
    this.y1 = y1;
    this.y2 = y2;
    display();
  }
  
  void display() {
    strokeWeight(1);
    stroke(36, 130, 87, 153);
    line(x1, y1, x2, y2);
  }
}
