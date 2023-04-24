
float t = 0.0;
float tRed = 0.0;
float tGreen = 0.0;
float tBlue = 0.0;
float tColor = 0.0;
float tSize = 0.0;
float delay;
float direction;
float directionRed = 1;
float directionGreen = 1;
float directionBlue = 1;
float directionColor = 1;
float directionSize = 1;
float y;
float diameter;
float answer = 1;

float myLerp(float x, float x2, float t)  {
  return x * (1 - t) + x2 * t;
}

//sstep3
float mySstep3(float x, float x2, float t) {   
  return lerp(x, x2, t * t * (3 - 2 * t));
}

//cos. Function received from Bjørn Tore
float myCos(float x, float x2, float t)  {
  return (x + x2 * (cos(t * PI - PI) + 1.0) / 2.0 );
}


void setup() {
  size(1800,800);
  t = 0.0;
  delay = 1.0;
  direction = 1;
}

void draw1() {
  background(0);
  t += 1.0/60 * direction * delay;
  diameter = 40;
  
  if (t < 0 || t > 1)  {
  direction = -direction;
  }
  
  //small red ball using lerp
  y = 100;
  fill(255,0,0);
  circle(myLerp(width/3, width/3 * 2, t), y, diameter);
    
  //small green ball using sstep3
  y += diameter;    
  fill(0,255,0);
  circle(mySstep3(width/3, width/3 * 2, t), y, diameter);
 
  //small blue ball using cos
  y += diameter;
  fill(0,0,255);
  circle((myCos(width/3, width/3, t)), y, diameter);
 
  //big color-changing ball using sstep (and lerp)
  y += diameter + 150;    
  diameter = 200;
  fill(mySstep3(255,0,t), mySstep3(0,255,t),0);
  circle(width/2,y, diameter);
  
  //size-changing ball using cos
  y += diameter + 35;
  diameter = 100;
  fill(0,0,255);
  circle(width/2, y, (diameter + diameter * ((cos(t*PI - PI))+1)/2));
}



void draw2() {

  // 5 * tid, 5* direction
  background(0);
  tRed += 0.5/60 * directionRed * delay; //new time spent to get back to original state
  diameter = 40;
   
  if (tRed < 0 || tRed > 1)  {
    directionRed = -directionRed;
  }
  
  //small red ball using lerp
  y = 100;
  fill(255,0,0);
  circle(myLerp(width/3, width/3 * 2, tRed), y, diameter);
   
    
  //small green ball using sstep3
  y += diameter;
  
  tGreen += 0.25/60 * directionGreen * delay;
  
  if (tGreen < 0 || tGreen > 1)  {
    directionGreen = -directionGreen;
  }
  
  fill(0,255,0);
  circle(mySstep3(width/3, width/3 * 2, tGreen), y, diameter);
 
 
  //small blue ball using cos
  y += diameter;
  
  tBlue += 0.75/60 * directionBlue * delay;
  
  if (tBlue < 0 || tBlue > 1)  {
    directionBlue = -directionBlue;
  }
  
  fill(0,0,255);
  circle((myCos(width/3, width/3, tBlue)), y, diameter);
 
 
  //big color-changing ball using sstep (and lerp)
  y += diameter + 150;
  
  tColor += 0.30/60 * directionColor * delay;
  
  if (tColor < 0 || tColor > 1)  {
    directionColor = -directionColor;
  }
  
  diameter = 200;
  fill(mySstep3(255,0,tColor), mySstep3(0,255,tColor),0);
  circle(width/2,y, diameter);
  
  
  //size-changing ball using cos
  y += diameter + 35;
  
  tSize += 0.2/60 * directionSize * delay;
  
  if (tSize < 0 || tSize > 1)  {
    directionSize = -directionSize;
  }
  
  diameter = 100;
  fill(0,0,255);
  circle(width/2, y, (diameter + diameter * ((cos(tSize*PI - PI))+1)/2));
  
}

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
