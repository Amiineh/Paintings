RW rws[];
int numRws = 3;

void setup(){
  size(600, 600);
  background(20);
  rws = new RW[numRws];
  for (int i = 0; i < numRws; i++){
    float x = random(0, width);
    float y = random(0, height);
    color c = color(random(255), random(255), random(255), 200);
    rws[i] = new RW(x, y, c);
  }
}

void draw(){
  delay(100);
  for (int i = 0; i < numRws; i++){
    int dir = int(random(2));
    float len = random(10, 150);
    int weight = int(random(1, 5));
    rws[i].drawLine(dir, len, weight);
  }
}
