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





3. Implement the collision between the ball and the paddle. You only need to test for the top side of the paddle and the bottom side of the square ball.

if(right side of square > left side of paddle && left side of square < right side of paddle) {

    if(bottom side of square > top side of paddle + 1/5 * height of paddle) quit the game.   // it is under the paddle and we have lost.
   else bounce by setting balls velocityy *= -1;

}
Test and make sure this works.

Save a copy and continue.





4. Add many rectangles to the screen to hit. Put these in an array. Just draw them to the screen and ignore collisions for now. Let all rectangles have the same witdth and height.

float rectx[]  // x position of the rectangles

float recty[]   // y position of the rectangles


Test, save a copy and continue



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
int answer = 1;
float size = 20;
float velx = -280.0; //velocity (hastighet) in the x-direction
float vely = -75;
float posx;
float posy;
boolean alive;
float paddleX;
float paddleY;
float paddleLeft;
float paddleRight;
float paddleWidth;
float paddleHeight;


void setup(){
  size(1200, 700);
  frameRate(60);
  posx = width/2 -size/2;  //Setting the x starting position of the ball
  posy = height - (size + paddleHeight);  // Setting the y starting position of the ball
  paddleX = width/2 -paddleWidth/2; ;  // Setting the starting position of the paddle
}


void draw(){
  t += 1.0/60.0;
  background(0);
  square(posx, posy, size); // Making the ball
  posx += velx * 1.0/60.0;  // Setting the x-direction and speed of the ball
  posy += vely * 1.0/60.0;  // Setting the y-direction and speed of the ball
  alive = true;             // The ball is active and showing
  ballLife();               // Call the ceiling and floor detection function
  ballBounceWalls();        // Call the wall-collision detection function
  paddle();                 // Call the paddle-function
  ballHitPaddle(); // Call the colllision between ball and paddle detection function
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
  paddleWidth = 75;
  
    // Moving the paddle left and right with keys, making sure it does not leave the window
    if(keyPressed)  {
      if(key == 'a' || key == 'A')  {
        if(paddleX -10 > 0) {
          paddleX += -10;
        }
      }  else if(key == 'd' || key == 'D')  {
           if(paddleX +10 < width -paddleWidth)  {
             paddleX += 10;
           }
      }
    }
  // Making the paddle
  rect(paddleX, paddleY, paddleWidth, paddleHeight);
}


/*
  Function to detect collosion between ball and paddle
  Not quite as suggested by Bernt, but it works
*/
void ballHitPaddle()  {
  
  paddleLeft = paddleX -paddleWidth/2;
  paddleRight = paddleX +paddleWidth/2;
  
  // Test if the ball is within the width of, and above the paddle
  if (posx > paddleLeft && posx < paddleRight && posy >= paddleY -paddleHeight){
      posy = paddleY -paddleHeight;
      vely = -vely;
  } else ballLife();
}


/*
  Making the game shut down if the ball falls out of the window
*/
void gameOver()  {
     exit();
}

/*
void draw() {

  if(answer == 1) draw1();
  else if(answer == 2) draw2();

}

void keyPressed() {
  if(keyCode == 32) {
    answer += 1;
    if(answer > 2) answer = 1;
  } 
}
*/
