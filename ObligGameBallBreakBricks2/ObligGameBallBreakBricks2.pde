/*
Kommentar:
I do believe that in the original breakout (which in part was developed by Steve Jobs, the former CEO of Apple, if I remember correctly) the "ball" was actually a small square.

I recommend that you do the same. Then you only need to consider collision between rectangles.

It is quite possible that araknoid also had square collision boxes, but I don't really know (I have played it though).



Here is what I suggest for how to approach the problem:



V    1.Start implementing the ball only. It should bounce off three of the edges of the window, and vanish at the bottom of the screen. The game should just quit if this happens.

V    Test and make sure this works before continuing.

V    Save a backup of your file before you continue, you might need to go back to it if you mess things up.





2. Implement the motion of the paddle at the bottom of the screen. Move left, right using the keys. Ignore collision with ball for now. Make sure the paddle doesn't leave the window.

Test and make sure this works before continuing.

There is source code on capquiz (below this question) to help you get started with keys.

Save a backup of your file before you continue.





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



void setup(){
  size(1200, 700);
  frameRate(60);
  posx = width/2 -size/2;
  posy = height - (size + 25);
  paddleX = width/2 -75/2;
}

void draw(){
  t += 1.0/60.0;
  background(0);
  posx += velx * 1.0/60.0;
  posy += vely * 1.0/60.0;
  alive = true;
  ballLife();
}

void ballLife()  {
  if (posx < 0) {
    posx = 0;
    velx = -velx;
  } else if(posx > width -20)  {
    posx = width -20;
    velx = -velx;
  }

  if (posy < 0)  {
    posy = 0;
    vely = -vely;
  } else if(posy > height)  {
    alive = false;
    gameOver();
  }
  square(posx, posy, size);
  paddle();
}


void paddle() {
  float paddleWidth = 75;
  float paddleHeight = 20;
  float paddleY = height -50;
  
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

  rect(paddleX, paddleY, paddleWidth, paddleHeight);

}


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
/*
void drawSquare()  {
  beginShape(SQUARE);
    fill(255);
    vertex(-1.0, 0.0);
    vertex(1.0,0.0);
    vertex(0.0,1.0);
  endShape();
}
*/
