

class brique {
  int x,y;
  int w,h;
  couleur col;
  
  brique() {
   x = 130; y = 130;
   w = 20; h = 20;
   col = new couleur(); 
  }
  
  brique(int bx, int by, int bw, int bh) {
    x = bx; y = by;
    w = bw; h = bh; 
   col = new couleur();
  }
  
  void drawMe() {
    fill(col.r, col.g, col.b, col.a);
    rect(x,y,w,h);
  }
}
