/*
Kommentar:
I do believe that in the original breakout (which in part was developed by Steve Jobs, the former CEO of Apple, if I remember correctly) the "ball" was actually a small square.

I recommend that you do the same. Then you only need to consider collision between rectangles.

It is quite possible that araknoid also had square collision boxes, but I don't really know (I have played it though).



Here is what I suggest for how to approach the problem:



V    1.Start implementing the ball only. It should bounce off three of the edges of the window, and vanish at the bottom of the screen. The game should just quit if this happens.

V    Test and make sure this works before continuing.

V    Save a backup of your file before you continue, you might need to go back to it if you mess things up.





V    2. Implement the motion of the paddle at the bottom of the screen. Move left, right using the keys. Ignore collision with ball for now. Make sure the paddle doesn't leave the window.

V    Test and make sure this works before continuing.

      There is source code on capquiz (below this question) to help you get started with keys.

V    Save a backup of your file before you continue.





V 3. Implement the collision between the ball and the paddle. You only need to test for the top side of the paddle and the bottom side of the square ball.

if(right side of square > left side of paddle && left side of square < right side of paddle) {

    if(bottom side of square > top side of paddle + 1/5 * height of paddle) quit the game.   // it is under the paddle and we have lost.
   else bounce by setting balls velocityy *= -1;

}
V Test and make sure this works.

V Save a copy and continue.





V 4. Add many rectangles to the screen to hit. Put these in an array. Just draw them to the screen and ignore collisions for now. Let all rectangles have the same witdth and height.

  float rectx[]  // x position of the rectangles

  float recty[]   // y position of the rectangles


V Test, save a copy and continue



5. Implement collision detection between rectangles and the ball. For now, just make the rectangles vanish if the ball hits them.  You need a global variable

bool visible[]  - set all to be true in setup when you start. encodes if a rectangle is vanished or not.

when you draw them:

for(int i = 0; i < numRectangles; i++) {
   if(visible[i]) {
        // draw the rectangle
   }
}


when you test for collisions



for(int i = 0; i < numRectangles; i++) {
   if(visible[i]) {
        // check for collision between rectangle[i] and ball
      set visible[i] to be false if they collide.
   }
}


I think we are probably getting close to the right workload. Ok, not quite araknoid yet, but a common power-up/bonus level when playing these games.



6. 7. ...  I will leave this to you.....you will have ample time to discuss later if you are concerned about points. Try to get this far first.



In any case we can help if you want to complete the collision response for araknoid if that is what you want.

But there are other things to consider. How about a particle system when the rectangle vanishes? Or maybe they should fall down or vanish to the side using an interpolation. Or fade to black using a colour interpolation. Araknoid also had a power-up where you shoot rectangles, and so on and so on. Just some ideas, some are easier than others. But complete 1.2.3.4.5 first.


You might get some bugs. Are these bugs making the game unplayable? If not, then they could always be a feature and not a bug smiler
*/

float t = 0.0;
float size = 20;
float velx = -280.0;                       //velocity (hastighet) in the x-direction
float vely = -75;
float posx;
float posy;
boolean alive;
float paddleX;
float paddleY;
float paddleWidth;
float paddleHeight;
float[] rectX;
float[] rectY;
int numOfBricks;
float brickSize;
ArrayList<PVector> brickPosition;
boolean[] visible;

void setup(){
  size(1200, 700);
  frameRate(60);
  int numX = 30;
  int numY = 10;
  rectX = new float[numX];
  rectY = new float[numY];
  brickSize = 35;
  posx = width/2 -size/2;                 //Setting the x starting position of the ball
  posy = height - (size + paddleHeight);  // Setting the y starting position of the ball
  paddleWidth = 75;
  paddleX = width/2 -(paddleWidth/2);     // Setting the starting position of the paddle
  createBricks();
  visible = new boolean[numX * numY];
  for(int i = 0; i < visible.length; i++) visible[i] = true;
}

void draw(){
  t += 1.0/60.0;
  background(0);
  drawBricks();
  ball();
  ballLife();               // Call the ceiling and floor detection function
  ballBounceWalls();        // Call the wall-collision detection function
  paddle();                 // Call the paddle-function
  ballHitPaddle(); // Call the colllision between ball and paddle detection function
  ballHitBricks();
}

/*
  Function for making/drawing the ball
*/
void ball(){
  fill(255);
  square(posx, posy, size); // Making the ball
  posx += velx * 1.0/60.0;  // Setting the x-direction and speed of the ball
  posy += vely * 1.0/60.0;  // Setting the y-direction and speed of the ball
  alive = true;             // The ball is active and showing
}


/*
  Function for detecting collision between ball and ceiling
  And making the ball die and game shut down if the ball falls out of the window
*/
void ballLife()  {
  
  // Collision between the ball and the ceiling
  if (posy < 0)  {
    posy = 0;
    vely = -vely;
    
  // If the ball falls below the bottom of the window
  } else if(posy > height)  {
    alive = false;
    gameOver();
  }  
}

/*
  Function for detecting collision between ball and walls, and change direction of
  ball
*/
void ballBounceWalls(){
  
    // Collision between the ball and the left side of the window
  if (posx < 0) {
    posx = 0;
    velx = -velx;  //Change direction of the ball
    
  // Collision between the ball and the right side of the window
  } else if(posx > width -size)  { //size = size of ball
    posx = width -size;
    velx = -velx;
  }  
}


/*
  Function to make and move the paddle correctly
*/
void paddle() {

  paddleHeight = 20;
  paddleY = height -50;
  
    // Moving the paddle left and right with keys, making sure it does not leave the window
    if(keyPressed)  {
      if(key == 'a' || key == 'A')  {
        paddleX += -10;
        if(paddleX < 0) paddleX = 0;
      }
      if(key == 'd' || key == 'D')  {
         paddleX += 10;
         if(paddleX > width -paddleWidth)  {
           paddleX = width -paddleWidth;
         }
      }
    }
  // Making the paddle
  fill(255);
  rect(paddleX, paddleY, paddleWidth, paddleHeight);
}


/*
  Function to detect collosion between ball and paddle
  Not quite as suggested by Bernt, but it works
*/
void ballHitPaddle()  {
  
  float paddleLeft = paddleX -paddleWidth/2;
  float paddleRight = paddleX +paddleWidth/2;
  
  // Test if the ball is within the width of, and above, the paddle
  if (posx > paddleLeft && posx < paddleRight && posy >= paddleY -paddleHeight){
      posy = paddleY -paddleHeight;
      vely = -vely;
  }
}


/*
  Function tocreate the bricks
*/
void createBricks()  {
  for(int x = 0; x < rectX.length; x++)  {
    float offset = (width -(rectX.length * brickSize))/2;
    for(int y = 0; y < rectY.length; y++)  {
      
      // Set bricks positions in the grid
      rectX[x] = (x * brickSize) + offset;
      rectY[y] = (y * brickSize) + 75;
    }
  }
}


/*
  Function to draw the bricks
*/
void drawBricks()  {
  int brickCounter = 0;
  for(int x = 0; x < rectX.length; x++)  {
    for(int y = 0; y < rectY.length; y++)  {
      if(visible[brickCounter])  {
        // Draw bricks
        fill(100,100,255);
        square(rectX[x], rectY[y], brickSize);
      }
      brickCounter++;
    }
  }  
}


/*
  Function to 
  - detect collision between ball and bricks
  - remove bricks that are hit 
  - change the balls direction when it hits a ball
*/
void ballHitBricks()  {
  int brickCounter = 0;  // Counting each brick
    boolean switchedX = false;  // Making sure the ball only change direction once even if it hits more than one brick.
    boolean switchedY = false;  // Making sure the ball only change direction once even if it hits more than one brick.
    for(int x = 0; x < rectX.length; x++)  {  // Going through the x-array
      for(int y = 0; y < rectY.length; y++)  {  // Going through the y-array
        if(visible[brickCounter])  {  // if that given brick is visible, detect collision
          //check if the ball collides with any bricks
          if (posx + size > rectX[x] && posx < rectX[x] + brickSize && posy + size > rectY[y] && posy < rectY[y] + brickSize)  {
            if(posy + size > rectY[y] && posy <= rectY[y] + brickSize && switchedY != true)  {
              vely = -vely;
              switchedY = true;
            }
            if(posx + size > rectX[x] && posx <= rectX[x] + brickSize && switchedX != true)  {
              velx = -velx;       
              switchedX = true;
            } 
            visible[brickCounter] = false;
          }
        }
        brickCounter++;
      }
    }
}


/*
  Making the game shut down if the ball falls below the window
*/
void gameOver()  {
     exit();
}
