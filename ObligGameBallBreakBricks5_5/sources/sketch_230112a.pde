
float t = 0.0; // time
float velx = -80.0; //velocity (hastighet) in the x-direction
float vely = -45;
float x = 250;
float y = 250;

//This function is run once
void setup() {
  size(500, 500);
  frameRate(60);
}

//  game loop (60 times per second - 60 frames per second):
//  updating the state of your "game"
//  dealing with events (keyboard, mouse ...)
//  render to screen

//This function is run 30/60 times per second
void draw() {
  t += 1.0/60.0;
  background(0); //clears window to black
  
  //this is physics (doing some maths)
  x += velx * 1.0/60.0;
  y += vely * 1.0/60.0;
  
  //lets do some more physics
  if (x < 50) {
    x = 50;
    velx = -velx;
  } else if(x > width -50) {
    x = width - 50;
    velx = -velx;
  }
  
  if(y < 50) {
    y = 50;
    vely = -vely;
  } else if(y > height -50) {
    y = height - 50;
    vely = -vely;
  }
    
  
  //(0.0) is upper left corner, positive y is downwards
  //you can change the location of the origin (0.0)
  
  circle(x, y, 100); //(x, y, diameter)
}
