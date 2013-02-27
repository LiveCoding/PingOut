
ArrayList<brique> myBriques;
boolean randCol;
palette palA, palB;
ArrayList<ball> myBalls;
couleur[] colT;
int gameState; // 0: playing, 1: pause, 2: playA Score, 3: playB Score, 4: playA Win, 5: playB Win, 6: exit
int scoreA, scoreB, scoreVictory;
PFont myFont;
int tick;

void setup() {
  
  //Set up
  size(displayWidth, displayHeight);
  frameRate(30);
  strokeWeight(3);
  noStroke();
  noCursor();
  strokeCap(SQUARE);
  rectMode(CENTER);
  tick = 0;
  myFont = createFont("Georgia", 32);
  textFont(myFont);
  
  palA = new palette(1);
  palB = new palette(2);
  
  myBalls = new ArrayList<ball>();
  myBalls.add(new ball(1,width/2 -270, height/2) );
  myBalls.add(new ball(2,width/2 +270, height/2) );
  
  myBriques = new ArrayList<brique>();
  loadBriques();
  
  gameState = 0;
  scoreA = 0; scoreB = 0; scoreVictory = 2;
    
}


//Collide, fonction in "objPhys"



void draw() {
  fill(255);
  background(0);

  //UPDATE
    //Balls
  if(gameState==0) {
    boolean oneMoreBlue = true, oneMoreRed = true;
    for(int i=0;i<myBalls.size();i++) {
      ((ball)myBalls.get(i)).updatePos();
      if(myBalls.get(i).type == 1 && myBalls.get(i).x < width/2)
        oneMoreRed = false;
      if(myBalls.get(i).type == 2 && myBalls.get(i).x > width/2)
        oneMoreBlue = false;
    }
    
    if(oneMoreRed)
      myBalls.add(new ball(1,width/2 -270, height/2) );
    if(oneMoreBlue)
      myBalls.add(new ball(2,width/2 +270, height/2) );
    
  
  
  }
  

  
    //Palettes
  palA.updatePos();
  palB.updatePos();
  
  
  /*
    //Game
  if(gameState==1 || gameState==2) {
    if(gameState==1) scoreA++;
    if(gameState==2) scoreB++;
    
    loadGame();
      
    if(scoreA==scoreVictory) { gameState = 4; }
    if(scoreB==scoreVictory) { gameState = 5; }

  }
  */
  //DRAW
    if(true) {
   tick++;
    if(tick==10) {
       tick =0;
    for(int i=0;i<myBriques.size();i++)
       myBriques.get(i).randColor();
     
    } 
  }
  
    //Briques
  for(int i=0;i<myBriques.size();i++)
    if(myBriques.get(i).type != 0)
      myBriques.get(i).drawMe();
    //Balls
  for(int i=0;i<myBalls.size();i++)
     ((ball)myBalls.get(i)).drawMe();
    //Palettes
  palA.drawMe();
  palB.drawMe();
  
  
    //Cadre
  stroke(255);
  line(0, 1, width, 1); line(0, height-1, width, height-1);
  noStroke();
  
  fill(255);
  text(scoreA, 100, 60);
  text(scoreB, width - 200, 60);      
  
  /*
    if(gameState == 4) { text ("Player 1 a perdu, trou du cul", 100, height/2-50); }
    if(gameState == 5) { text ("Player 2 l'a dans l'os, bolosse", 100, height/2-50); }
    */
}

void keyPressed() {
  
  if(key == 'l') {
    loadBriques();
  }
  if (key == CODED) {
    if (keyCode == UP)         { palA.pressUp   = true; }
    else if (keyCode == RIGHT) { palB.pressUp   = true; }
    else if (keyCode == DOWN)  { palA.pressDown = true; }
    else if (keyCode == LEFT)  { palB.pressDown = true; } 
  }
  
  if (key == ' ') { loadGame(); }
  if (key == 'z') { palA.pressUp   = true; }
  if (key == 'q') { palB.pressUp   = true; }
  if (key == 's') { palA.pressDown = true; }
  if (key == 'd') { palB.pressDown = true; } 
}

void keyReleased() {
  
  if (key == CODED) {
    if (keyCode == UP)         { palA.pressUp   = false; }
    else if (keyCode == RIGHT) { palB.pressUp   = false; }
    else if (keyCode == DOWN)  { palA.pressDown = false; }
    else if (keyCode == LEFT)  { palB.pressDown = false; } 
  }
  if (key == 'z') { palA.pressUp   = false; }
  if (key == 'q') { palB.pressUp   = false; }
  if (key == 's') { palA.pressDown = false; }
  if (key == 'd') { palB.pressDown = false; } 
  
}


void loadBriques() {
    myBriques.clear();
    String lines[] = loadStrings("data.txt"); 
    for (int i = 0 ; i < lines.length; i++) {
      int[] nums = int(split(lines[i], ' '));
      myBriques.add(new brique(nums[0],nums[1],nums[2],nums[3]));
    }   
}

void loadMyBriques() {
    myBriques.clear();
    int wB = 60, hB = 25, eB = 5;
    for(int i = width/4; i < 3*width/4; i+= hB+2*eB)
    for(int j = 0+wB/2; j < height; j+= wB+eB)
      myBriques.add(new brique(i, j, hB, wB));
  
}

void loadBalls() {
    myBalls.clear();
    myBalls.add(new ball(1,width/2 -270, height/2) );
    myBalls.add(new ball(2,width/2 +270, height/2) );
}

void loadGame() {
      loadBriques();
      gameState = 0; 
  
}
