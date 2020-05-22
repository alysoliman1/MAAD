
import codeanticode.tablet.*;

import processing.sound.*;

Tablet tablet;

animation [] eyes = new animation [30];

float pen_pressure, pre_pen_pressure, pressure_delta = 0;

boolean pen_on_tablet = false;

boolean register_point_1, register_point_2 = false;
float scale;
int [] point_1 = new int[2];
int [] point_2 = new int[2];

void setup(){

  size(600, 600);
  
  for (int i = 0; i < eyes.length; i ++ ) eyes[i] = new animation("eye_animation");
  
  tablet = new Tablet(this); 
  
  imageMode(CENTER);
}

void draw (){
  
  background(255);
 
 pen_pressure = tablet.getPressure(); // update pen pressure input
 
 pen_on_tablet = pen_pressure>0.2;
 

  
    if ( pen_on_tablet ) {
      
      stroke(0);
      
      strokeWeight(2);
      
      if (register_point_1==false){
        
        register_point_1=true;
        
        point_1[0] = mouseX;
        
        point_1[1] = mouseY;
        
      }
      
      line (mouseX,mouseY,pmouseX,pmouseY);
      
      noStroke();
       
    } 
    
    else {
      
     if (register_point_1 == true && register_point_2 == false){
       
        point_2[0] = mouseX;
        
        point_2[1] = mouseY;
        
        scale = float(abs(point_2[0]-point_1[0])) / float(eyes[0].frames[0].width);
      
        eyes[0].rescale(scale);
 
       register_point_2 = true;
       }
      
    }
    if (register_point_1 && register_point_2 ){
      
      eyes[0].display(point_1[0]/2+point_2[0]/2, point_1[1]/2+point_2[1]/2);
      eyes[0].animate(1,8);
      
    }
   
}
