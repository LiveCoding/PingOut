
class couleur {
   int r, g, b, a;
   couleur() { r=int(random(0,255)); g=int(random(0,255)); b=int(random(0,255)); a =255;/*a=int(random(0,255));*/ }
   couleur(int _r, int _g, int _b, int _a) { r=_r; g=_g; b=_b; a=_a; }
   void addition(couleur _col1, couleur _col2) {
    r = _col1.r + _col2.r; if(r>255) r=255;
    g = _col1.g + _col2.g; if(g>255) g=255;
    b = _col1.b + _col2.b; if(b>255) b=255;
    a = (_col1.a + _col2.a)/2;
   }
}

