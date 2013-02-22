

class palette extends objPhys {
  
  boolean pressUp, pressDown;
  
  palette(int _type) {
    type = _type;
    w=20;  h=80;
    y=height/2;
    if(type==1) x = 50;
    else        x = width - 50;
  }
  

  
  void updatePos() {
   
   //Friction when no command are given
   if(!pressUp && !pressDown) {
    vy=int(0.99*int(vy));
   }
  
   //Speed
   if(pressUp)   { if(vy==0) vy=-3; vy--; }
   if(pressDown) { if(vy==0) vy= 3; vy++; }
    
   //Position
   y+=vy;
   
   //Rebounds on the edge
   if(y - h/2 < 0)     { vy=-vy; y = h/2; }
   if(y + h/2 >height) { vy=-vy; y = height - h/2; }
  }
  
}
