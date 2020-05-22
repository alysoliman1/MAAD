// Daniel Shiffman
// http://codingtra.in
// http://patreon.com/codingtrain
// Code for: https://youtu.be/17WoOqgXsRM

// I create an array named "stars",
// it will be filled with 800 elements made with the Star() class.


import codeanticode.tablet.*;
import processing.sound.*;

Star[] stars = new Star[800];

Tablet tablet;

int state = 1;

float pen_pressure, pre_pen_pressure, pressure_delta = 0;

boolean pen_on_tablet = false;

// I create a variable "speed", it'll be useful to control the speed of stars.
float speed;

// stage 1 variables 

boolean canvas_cleaned = false ;


//stage 3 variables 

float star_speed = 0;
float fade_away_gradiant = 255 ;
color brown = color(139,72,20);
color green = color(0,255,0);
color yellow = color(251,229,121);
color red = color(212,0,0);
color current_color = brown ;
int thickness = 50;

// stage 4 variables 

boolean register_point_1, register_point_2 = false;
int [] point_1 = new int[2];
int [] point_2 = new int[2];

//stage 5
int dir = 9;

ParticleSystem ps;
PImage sprite;  

void setup() {
  size(600, 600,P2D);
  
  tablet = new Tablet(this); 
  load_eye_frames();
  
  // I fill the array with a for loop;
  // running 800 times, it creates a new star using the Star() class.
  for (int i = 0; i < stars.length; i++) {
    stars[i] = new Star();
  }
  
    orientation(LANDSCAPE);
  sprite = loadImage("sprite.png");
  ps = new ParticleSystem(10000);

  // Writing to the depth buffer is disabled to avoid rendering
  // artifacts due to the fact that the particles are semi-transparent
  // but not z-sorted.
  hint(DISABLE_DEPTH_MASK);

}


void keyPressed(){
  
if (int(key) >= 48 && int(key) <= 57 ) state = int(key-48);

if (state == 3){
 switch (key){
        case 'r':
     current_color = red;
     print("red");
   break;
     case 'g':
   current_color = green;
   break;
      case 'b':
    current_color = brown;
   break;
      case 's':
    thickness = 10;
   break;
      case 'l':
    thickness = 50;
   break;
      case 'y':
     current_color = yellow;
   break;

   
 }
  
}

}



void draw() {
  

  
  pen_pressure = tablet.getPressure(); // update pen pressure input
  
  pen_on_tablet = (pen_pressure > 0.2 && keyPressed) || mousePressed ;
  println(pen_pressure);
  
  if (state != 1 ) canvas_cleaned = false;
  
  //println(pen_pressure);
 
  switch (state){
    
    case 1 :
    
    if (!canvas_cleaned) {
      
     background(255);
     
     canvas_cleaned = !canvas_cleaned;
     
    }
    
    if ( pen_on_tablet ) point (mouseX,mouseY,100*pen_pressure+100,pen_pressure,0,0,0,0,0);
    
    break;
    
    case 2:
    
    if ( pen_on_tablet ) {
      
     // background(0);
      
      //point (mouseX,mouseY,100*pen_pressure+100,255,255,255);
    
      ps.update();
      ps.display();
  
      ps.setEmitter(mouseX,mouseY);
      
    }
    
    
    break;
    
    case 3:
    
    //background(255*(1-pen_pressure),255*(1-pen_pressure),255*pen_pressure);
    
 
    if (fade_away_gradiant >0 ){
      background(0);
      fill(fade_away_gradiant);
      noStroke();
       rect(0,0,width,height);
       fade_away_gradiant -= 5;
    if ( fade_away_gradiant == 200 ) star_speed = 50;
    
    }
    
    if ( star_speed > 0 ) {
      noStroke();
      if (fade_away_gradiant == 0 ) background(0);
      star_speed -= 0.5;
     
     stars(star_speed);
    }
    
    

    
    if ( pen_on_tablet ) {
      stroke(current_color);
      strokeWeight(thickness);
      line (mouseX,mouseY,pmouseX,pmouseY);
      noStroke();
      
    }
    
    break;
    case 4 :
    current_color = color(0,0,0);
    thickness = 1;
        println(pen_on_tablet);
    if ( pen_on_tablet ) {
      stroke(current_color);
      strokeWeight(thickness);
      if (register_point_1==false){
        register_point_1=true;
        point_1[0] = mouseX;
        point_1[1] = mouseY;
      }
      line (mouseX,mouseY,pmouseX,pmouseY);
      noStroke();
       
     
    } else {
     if (register_point_1 == true && register_point_2 == false){
             point_2[0] = mouseX;
        point_2[1] = mouseY;
        
        scale = float(abs(point_2[0]-point_1[0])) / float(eye_frames[0].width);
        println(point_2[0]-point_1[0],scale,abs(point_2[0]-point_1[0]),eye_frames[0].width,abs(point_2[0]-point_1[0])/eye_frames[0].width);
         for (int i=1;i<=13;i++)eye_frames[i-1].resize(ceil(eye_frames[i-1].width*scale),ceil(eye_frames[i-1].height*scale));
 
       register_point_2 = true;
       }
      
    }
    if (register_point_1 && register_point_2 ){
        eye(floor(eye_clock/15)+1,point_1[0]/2+point_2[0]/2, point_1[1]/2+point_2[1]/2);
       update_eye_clock();
    }
  
    break;
    case 5:

      
      if (mouseX > width*2/3 && mouseY < height/2  ) dir = 9;
      if (mouseX < width/3 && mouseY < height/2 ) dir = 10;
      if (mouseX > width*2/3 && mouseY > height/2  ) dir = 13;
      if (mouseX < width/3 && mouseY > height/2 ) dir = 12;
      if (mouseX > width/3 && mouseX < width*2/3 && mouseY < height/2 ) dir = 5;
       if (mouseX > width/3 && mouseX < width*2/3 && mouseY > height/2 ) dir = 11;
          eye(dir,point_1[0]/2+point_2[0]/2, point_1[1]/2+point_2[1]/2);
    if (pen_on_tablet){
      
   
      stroke(255);
      strokeWeight(200*pen_pressure);
        line (mouseX,mouseY,pmouseX,pmouseY);
      noStroke();
    }
    
    break;
        case 6:

      
      if (mouseX > width*2/3 && mouseY < height/2  ) dir = 9;
      if (mouseX < width/3 && mouseY < height/2 ) dir = 10;
      if (mouseX > width*2/3 && mouseY > height/2  ) dir = 13;
      if (mouseX < width/3 && mouseY > height/2 ) dir = 12;
      if (mouseX > width/3 && mouseX < width*2/3 && mouseY < height/2 ) dir = 5;
       if (mouseX > width/3 && mouseX < width*2/3 && mouseY > height/2 ) dir = 11;
          eye(dir,point_1[0]/2+point_2[0]/2, point_1[1]/2+point_2[1]/2);
    if (pen_on_tablet){
       if (dir >= 9   )     eye(dir,mouseX,mouseY);
    }
    
    break;
    case 7:
    fill(100);
    noStroke();
rect(width*1/3,0,width*2/3-width/3,height/2);
      
    break;
    
  }
  
}
