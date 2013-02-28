

class ball extends objPhys {

  ball(int _type) {
    type = _type;
    w=15;     h=15;
    
    float  a = random(-1,1); a /= abs(a);
    vy=int(a)*4;
    
    if(type==1) { col = new couleur(255,0,0, 200); y = int(random(height)); x = width/4;  vx = -4;}
    else        { col = new couleur(0,0,255, 200); y = int(random(height)); x = 3*width/4; vx =4;}
  }
  
  void updatePos() {
    
    //EGES
    //Murs
    if(up()+vy   > height) { vy=-vy; }
    if(down()+vy <      0) { vy=-vy; }
    
    if(right()+vx > width) { gameState = 1; }
    if(left()+vx < 0)     { gameState = 2; }    
    
    //COLLISION
    //Palettes
    reboundWith(palA);
    reboundWith(palB);    
    
    //Briques
   
   for(int i=0;i<myBriques.size();i++) {
      brique tBrique = (brique)myBriques.get(i);
      //if (tBrique.type==3 || tBrique.type==type)
      //  if (reboundWith(tBrique))
      //    tBrique.updateType(type);
      if (tBrique.type!=0)
        if (reboundWith(tBrique)) {
          tBrique.type = 0;
          if(type==1)
            scoreA++;
          else
            scoreB++;
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
