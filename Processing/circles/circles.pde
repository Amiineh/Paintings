void setup(){
  size(700, 700);
  background(255);
  Indicate();
}

int r = 100;
int gs = 0; // grayscale
int op = 50; // opacity

void draw(){

}

void mouseDragged(){
  stroke(gs, op);
  fill(255, 0);
  circle(mouseX, mouseY, r);
}

void keyPressed(){
  switch (key){
    case('r'):  // reset
      background(255);
      Indicate();
      break;
      
    case('s'): // save
      resetIndicator();
      saveFrame("output-##.png");
      Indicate();
      break;
      
    case (CODED):
      resetIndicator();
      switch (keyCode){
        case(UP):
          r += 5;
          break;
          
        case(DOWN):
          r -= 5;
          if (r < 1) r = 1;
          break;
          
        case(LEFT):
          op -= 5;
          if (op < 1) op = 1;
          break;
          
        case(RIGHT):
          op = (op+5)%255;
          break;
      }
      Indicate();
      break;
    
  }
  
}

void resetIndicator(){
  noStroke();
  fill(255);
  circle(50, height - 50, r+4);
}

void Indicate(){
  stroke(0);
  fill(gs, op);
  circle(50, height - 50, r);
}
