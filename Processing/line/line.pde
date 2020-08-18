import processing.pdf.*;

  void setup() {
     size(700, 700);//, PDF, "output.pdf");
     
     background(#F2BCD0);
   }
    
    int frame = 0;
    color myColor = #59FF2C; 
    int x = 200;
    int y = 20;
    
   void draw() {
     beginRecord(PDF, "lines.pdf");
     
     stroke(myColor);
     line(x, y, mouseX, mouseY);
     //line(mouseX, mouseY, mouseX, height);
     //saveFrame("output-#.png");
     frame++;
     //if (frame % 100 == 0){
     //  x = (x+50)% width;
     //  y = (y+20)% height;
     //}
     if (frame > 500){
       frame = 0;
       myColor += 100;
       
     }
   }
   
   void mousePressed() {
     //background(#A24343);
      x = mouseX;
      y = mouseY;
   }
