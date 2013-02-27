
int[] px=new int[2];
int[] py=new int[2];
int[] vx=new int[2];
int[] vy=new int[2];

boolean paused = false;
boolean done = false;
int[] bricks; //Is brick still present
int[][] bricksCoord; //Coordinates for the bricks (array of x,y,widht,height arrays)

int W=1000;
int H=800;
int widthBrick;
int heightBrick;
int nbBricks;

int posXplayer1=H/2;
int posXplayer2=H/2;
float speedPal1=0;
float speedPal2=0;

boolean useFile=true;

int[] score=new int[2];

void loadBriques() {
  String lines[] = loadStrings("data.txt"); 
  nbBricks=lines.length;
  bricksCoord=new int[nbBricks][4]; 
  bricks = new int[nbBricks];
  for (int i = 0 ; i < lines.length; i++) {
    int[] nums = int(split(lines[i], ' '));
    bricks[i] = 3;
    bricksCoord[i][0]=nums[0];
    bricksCoord[i][1]=nums[1];
    bricksCoord[i][2]=nums[2];
    bricksCoord[i][3]=nums[3];
  }
}


void setup() {
  noCursor();
  size(W, H);
  smooth();
  px[0] = width/4;
  py[0] = height/2;
  px[1] = width/2+width/4;
  py[1] = height/2;

  vx[0] = -2;
  vy[0] = int(random( -8, 8 ));
  vx[1] = 2;
  vy[1] =int(random( -8, 8 ));

  score[0]=0;
  score[1]=0;
  

  if (!useFile) {
    nbBricks=28;
    bricks = new int[nbBricks];
    bricksCoord=new int[nbBricks][4];
    widthBrick=round(W/7) ;
    heightBrick=20;

    for ( int i = 0; i < nbBricks; i++) {
      bricks[i] = 3;
      bricksCoord[i][0]=(i%7)*widthBrick;
      bricksCoord[i][1]=round(i/7)*heightBrick+H/2-heightBrick*2;
      bricksCoord[i][2]=widthBrick;
      bricksCoord[i][3]=heightBrick;
    }
  }
  else {
    loadBriques();
  }
}

void draw() {
  background(50);
  stroke(255);
  strokeWeight(3);

  fill(255);
    textSize( 48 );
  pushMatrix();
    translate(10,20);
    rotate(PI/2);
    text("Score: "+score[0],0,0);
popMatrix();
  pushMatrix();
    translate(W-50,20);
    rotate(PI/2);
    text("Score "+score[1],0,0);
popMatrix();
  
  // update postion of the ball 
  if (!paused) update();

  // draw all stones that are not removed yet
  // check if all are gone
  done = true;
  for ( int i = 0; i < nbBricks; i++) {
    if ( bricks[i] > 0 ) {
      done = false;
      fill( (bricks[i]&1)*255, 0, (bricks[i]&2)*255 );
      rect(bricksCoord[i][0], bricksCoord[i][1], bricksCoord[i][2], bricksCoord[i][3] );
    }
  }

  // no stone remaining - display yippie message
  if ( done ) {
    paused = true;
    fill(255);
    textSize( 48 );
    text( "JIPPIE!", W/2-100, H/2 );
  }

  // display text if paused
  if ( paused ) {
    textSize( 16 );
    fill(128);
    text( "press mousebutton to continue", 10, 250 );
  }

  if (keyPressed) {
    if (key == 'w' ) {
      if (speedPal1==0) speedPal1=-3; 
      speedPal1--;
    }
    if (key == 'x' ) {
      if (speedPal1==0) speedPal1=3; 
      speedPal1++;
    }
    if (key == 'b' ) {
      if (speedPal2==0) speedPal2=-3; 
      speedPal2--;
    }
    if (key == 'n' ) {
      if (speedPal2==0) speedPal2=3; 
      speedPal2++;
    }
  }
  speedPal1=0.95*speedPal1;
  speedPal2=0.95*speedPal2;

  posXplayer1=posXplayer1+(int)speedPal1;
  posXplayer2=posXplayer2+(int)speedPal2;
  if (posXplayer1<35) {
    posXplayer1=35;
    speedPal1=-speedPal1;
  }
  if (posXplayer1>(H-35)) {
    posXplayer1=H-35;
    speedPal1=-speedPal1;
  }
  if (posXplayer2>(W-35)) {
    posXplayer2=W-35;
    speedPal2=-speedPal2;
  }
  if (posXplayer2<35) {
    posXplayer2=35;
    speedPal2=-speedPal2;
  }
  fill(255, 0, 0);
  ellipse(px[0], py[0], 20, 20);
  rect( 10, posXplayer1 - 35, 20, 70 );
  fill(0, 0, 255);
  ellipse(px[1], py[1], 20, 20);
  rect( W-30, posXplayer2 - 35, 20, 70 );
}

void update() {
  if ( px[0] + vx[0] <10 ) {
    px[0] = width/4;
    py[0] = height/2;
    vx[0] = -2;
    vy[0] = int(random( -8, 8 ));
    score[0]-=100;
  }
  if ( px[1] + vx[1] >W-10 ) {
    px[1] = width/2+width/4;
    py[1] = height/2;
    vx[1] = 2;
    vy[1] = int(random( -8, 8 ));
    score[1]-=100;
    //paused = true;
  }


  for (int player=0; player<2; player++) {


    // check if the ball hits a block
    for ( int i=0; i < nbBricks; i++) {

      if ( (bricks[i]&(player+1)) > 0 ) {
        if ( px[player] + vx[player]  >  bricksCoord[i][0]-10 && px[player] + vx[player]  <  bricksCoord[i][0]+bricksCoord[i][2]+10 &&
          py[player] + vy[player]  >  bricksCoord[i][1]-10 && py[player] + vy[player]  <  10+bricksCoord[i][1]+bricksCoord[i][3]) {
          println(bricks[i]+" "+player);
          score[player]+=50;
          bricks[i] = bricks[i]-(bricks[i]& (player+1));
          println(bricks[i]);
          // change the velocity in y direction if the block has been hit 
          // on the bottom or on the top 
          if ( px[player]  >  bricksCoord[i][0]-10 && px[player]  <  bricksCoord[i][0]+bricksCoord[i][2]+10 ) vy[player] = -vy[player];
          // change the velocity in the x direction if the block has been hit on the side
          if ( py[player]   >  bricksCoord[i][1]-10 && py[player]   <  bricksCoord[i][1]+bricksCoord[i][3]+10 ) vx[player] = -vx[player];
        }
      }
    }

    // change the direction if the ball hits a wall
    if (px[player] + vx[player]  < 10 || px[player] + vx[player] > W - 10) {
      vx[player] = -vx[player];
    }

    if (py[player] + vy[player]  < 10 || py[player] + vy[player] > H - 10) {
      vy[player] = -vy[player];
    }

    // check if the paddle was hit
    if ( px[player] + vx[player]+10 >= (W-30)  && py[player]+vy[player]+10 >= posXplayer2 - 35 && py[player]+vy[player]-10 <= posXplayer2 +35 ) {
      if ( py[player]+10  >  posXplayer2 - 35 && py[player]-10  <   posXplayer2 +35 ) {
        vx[player] = -vx[player];
        vy[player] = int(map( py[player] - posXplayer2, -35, 35, -8, 8 ));
      }
      else  vy[player] = -vy[player];
    }  
    if ( px[player] + vx[player]-10 <= (30)  && py[player]+vy[player]+10 >= posXplayer1 - 35 && py[player]+vy[player]-10 <= posXplayer1 +35 ) {
      if ( py[player]+10  >  posXplayer1 - 35 && py[player]-10  <   posXplayer1 +35 ) {
        vx[player] = -vx[player];
        vy[player] = int(map( py[player] - posXplayer1, -35, 35, -8, 8 ));
      }
      else vy[player] = -vy[player];
    }  

    // calculate new postion
    px[player] += vx[player];
    py[player] += vy[player];
  }
}

