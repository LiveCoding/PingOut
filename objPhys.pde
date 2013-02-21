
class objPhys {
  
  float x,y;
  float vx,vy;
  float w,h;
  int type; //0 void, 1 red, 2 blue, 3 both
 
  float up()    {return y+h/2;}
  float down()  {return y-h/2;}
  float right() {return x+w/2;}
  float left()  {return x-w/2;}
  boolean isInside(float _x, float _y) { if( left() < _x && _x < right()   &&   up() > _y && _y > down() ) return true; return false; }
  //int toUp() (int y) {  }
  
  void drawMe() {
    fill(colT[type].r, colT[type].g, colT[type].b, colT[type].a);
    rect(x, y, w, h, 3);
  }
  
  int collideWith(objPhys _obj) {
    int way =0; //1 up 2 down 2 gauche 4 droite
    //A-----B
    //|     |
    //D-----C
    
    boolean Ain, Bin, Cin, Din;
    Ain = _obj.isInside(left() , up()  );
    Bin = _obj.isInside(right(), up()  );
    Cin = _obj.isInside(right(), down());
    Din = _obj.isInside(left() , down());
    int count = int(Ain) + int(Bin) + int(Cin) + int(Din);
    
    switch(count) { //3 versions
      case 0: break;
      case 1: //1) We are 1 dot inside
        break;
      case 2: //2) We are 2 dots inside
        if(Ain && Bin) way = 1;
        if(Din && Cin) way = 2;
        if(Ain && Din) way = 3;
        if(Bin && Cin) way = 4;
        break;
      case 3: case 4:  //3) We are completely inside (3 or 4 dots is the same)
        break;
    }
    
    return way;
  }
  
  boolean reboundWith(objPhys _obj) {
    int way = collideWith(_obj);
    
    if(way==0) { return false; }
      
    switch(way) { 
        case 1: vy=-abs(vy); break;
        case 2: vy= abs(vy); break;
        case 3: vx= abs(vx); break;
        case 4: vx=-abs(vx); break;
      }
      
    return true;
  }
  
}
