
couleur tCol;
ArrayList myBriques;
int bx,by,bw,bh;
boolean tempBrique;
int tick;
boolean randCol;

void setup() {
  
  size(displayWidth, displayHeight, P2D);
  noStroke();
  frameRate(10);
  tCol = new couleur(0,0,0,0);
  background(tCol.r, tCol.g, tCol.b, tCol.a);
  
  myBriques = new ArrayList<brique>();
  tempBrique = false;
  tick =0;
  randCol=false;
}


void draw() {
  
  fill(255);
  background(0);
  
  if(tempBrique) {
   rect(bx,by,mouseX-bx,mouseY-by); 
  }
  
  if(randCol) {
   tick++;
    if(tick==2) {
       tick =0;
    for(int i=0;i<myBriques.size();i++)
       ((brique)myBriques.get(i)).col = new couleur();
     
    } 
  }
  
  //Show the bricks
  for(int i=0;i<myBriques.size();i++)
     ((brique)myBriques.get(i)).drawMe();
     
}


void mousePressed() {
    bx = mouseX;
    by = mouseY;    
    tempBrique = true;
}

void mouseReleased() {  
    bw = mouseX-bx;
    bh = mouseY-by;
    tempBrique = false;
    myBriques.add(new brique(bx,by,bw,bh));
}

void keyPressed() {
 
  if(key == 's') {
    //SAUVEGARDE SOUS FORMAT XML ? plutot data pour l'instant
    
    PrintWriter output = createWriter("data.txt"); 
    for(int i=0;i<myBriques.size();i++) {
      brique tBri = (brique)myBriques.get(i);
      output.println(tBri.x + " " + tBri.y + " " + tBri.w + " " + tBri.h);
    }
    output.flush();
  }
  
  if(key == 'l') {
    
    myBriques.clear();
    String lines[] = loadStrings("data.txt"); 
    for (int i = 0 ; i < lines.length; i++) {
      int[] nums = int(split(lines[i], ' '));
      myBriques.add(new brique(nums[0],nums[1],nums[2],nums[3]));
    } 
    
  }
  
  if(key == 'd') {
      if(myBriques.size() > 0)
       myBriques.remove(myBriques.size()-1);
  }
  
  if(key == 'a') {
    
    for(int i=0;i<myBriques.size();i++)
       ((brique)myBriques.get(i)).col = new couleur();
    }
  
  if(key == 'q') {
    tick = 0;
    randCol = !randCol;
  }

}
