

class ball extends objPhys {

  ball(int _type, int _x, int _y) {
    type = _type;
    w=15;     h=15;
    x = _x;  y = _y;
    vx=vy=5;
  }
  
  void updatePos() {
    
    //EGES
    //Murs
    if(up()   >= height) { y=height-h/2; vy=-abs(vy); }
    if(down() <=      0) { y=h/2;        vy= abs(vy); }
    
    if(x >= width) { gameState = 2;  vx=-abs(vx); }
    if(x <= 0)     { gameState = 3; vx= abs(vx); }    
    
    //COLLISION
    //Palettes
    reboundWith(palA);
    reboundWith(palB);    
    
    //Briques
    for(int i=0;i<myBriques.size();i++) {
      brique tBrique = (brique)myBriques.get(i);
      if (tBrique.type==3 || tBrique.type==type) {
        if (reboundWith(tBrique)) {
          tBrique.updateType(type);
        }
      }
    }
    
    //SPHERICAL COLLISIONS

    for(int i=0;i<myBalls.size();i++) {
      reboundWith((ball)myBalls.get(i));
    }

   
   x+=vx;
   y+=vy;
  }
  
}
