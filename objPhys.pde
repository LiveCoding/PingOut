
class objPhys {
  
  float x,y;
  float vx,vy;
  float w,h;
  int type; //0 void, 1 red, 2 blue, 3 both
  couleur col;
 
  float up()    {return y+h/2;}
  float down()  {return y-h/2;}
  float right() {return x+w/2;}
  float left()  {return x-w/2;}
  boolean isInside(float _x, float _y) { if( left() < _x && _x < right()   &&   up() > _y && _y > down() ) return true; return false; }
  //int toUp() (int y) {  }
  
  void drawMe() {
    fill(col.r, col.g, col.b, col.a);
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
      case 1: //1) We are 1 dot insizde
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
 
    if (vx<0) {
      if (vy<0) {

        if ((left()+vx > _obj.left()) & (left()+vx < _obj.right()) & (down()+vy < _obj.up()) & (down()+vy > _obj.down())) {
          if (left()>=_obj.right()) vx=-vx;
          if (down()<=_obj.up()) vy=-vy;
          return true;
        }
      }
      else //vy>0
      {
        if ((left()+vx > _obj.left()) & (left()+vx < _obj.right()) & (up()+vy < _obj.up()) & (up()+vy > _obj.down())) {
          if (left()>=_obj.right()) vx=-vx;
          if (up()<=_obj.down()) vy=-vy;
          return true;
        }
      }
    }// vx>0
    else 
    {
      if (vy<0) {

        if ((right()+vx > _obj.left()) & (right()+vx < _obj.right()) & (down()+vy < _obj.up()) & (down()+vy > _obj.down())) {
          if (right()<=_obj.left()) vx=-vx;
          if (down()>=_obj.up()) vy=-vy;
          return true;
        }
      }
      else //vy>0
      {
        
        if ((right()+vx > _obj.left()) & (right()+vx < _obj.right()) & (up()+vy < _obj.up()) & (up()+vy > _obj.down())) {
          if (right()<=_obj.left()) vx=-vx;
          if (up()<=_obj.down()) vy=-vy;
          return true;
        }
      }
    }
          return false;

  }

  
}
