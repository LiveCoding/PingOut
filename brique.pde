

class brique extends objPhys {
  
  brique(int bx, int by, int bw, int bh) {
    x = bx; y = by;
    w = bw; h = bh; 
    type=3;
  }
  
  void updateType(int _type) {
   switch(_type) {
    case 0: break;
    case 1: if(type!=0 && type!=2) type--; break;
    case 2: if(type!=0 && type!=1) type-=2; break;
    case 3: type=0; break;
   }
  }
 
}
