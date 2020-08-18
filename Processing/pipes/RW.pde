class RW{
  float x, y;
  int last;
  color c;
  
  RW(float x, float y, color c){
    this.x  = x;
    this.y =  y;
    this.last = int(random(2));
    this.c = c;
  }
  
  void drawLine(int dir, float len, int weight){
    float[][][] endP = {{{0, len}, {0, -len}}, {{len, 0}, {-len, 0}}}; 
    strokeWeight(weight);
    stroke(c);
    line(x, y, x+endP[last][dir][0], y+endP[last][dir][1]);
    x = (x + endP[last][dir][0] + width) % width;
    y = (y + endP[last][dir][1] + height) % height;
    last = (last+1)%2;
  }
}
