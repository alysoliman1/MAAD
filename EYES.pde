
import codeanticode.tablet.*;

import processing.sound.*;

Tablet tablet;

animation [] eyes = new animation [20];

boolean [] register_points_1 = new boolean[20];

boolean [] register_points_2 = new boolean[20];

float[] scales = new float[20];

float[][] point_1 = new float[20][2];

float[][] point_2 = new float[20][2];

int index = 0;

float pen_pressure, pre_pen_pressure, pressure_delta = 0;

boolean pen_on_tablet = false;

int buffer = 0;

int [] mouse_tracking_frames = {4,9,10,11,12,13};

void setup(){

  size(600, 600);
  
  for (int i = 0; i < eyes.length; i ++ ) { 
    
    eyes[i] = new animation("eye_animation");
    eyes[i].set_mouse_tracking(mouse_tracking_frames);
    
  }
  
  tablet = new Tablet(this); 
  
  imageMode(CENTER);
}

void draw (){
  
  background(255*pen_pressure,255,255);
 
  pen_pressure = tablet.getPressure(); // update pen pressure input
 
  pen_on_tablet = pen_pressure>0.2 || mousePressed;
  
  if ( register_points_1 [index] == true && register_points_2 [index] == true && index < 19){
    buffer += 1 ; 
    
    if (buffer == 10){
    index +=1;
    buffer =0;
    }
  }
  
  
 
  if ( pen_on_tablet ) {
      
      stroke(0);
      
      strokeWeight(2);
      
      if ( register_points_1 [index] == false ){
        
        register_points_1 [index] = true;
        
        point_1[index][0] = mouseX;
        
        point_1[index][1] = mouseY;
        
         println("p1");
        
      }
      
      line (mouseX,mouseY,pmouseX,pmouseY);
      
    } 
    
    else {
      
     if ( register_points_1 [index] == true && register_points_2[index] == false){
       
        point_2[index][0] = mouseX;
        
        point_2[index][1] = mouseY;
        
        scales [index] = (float)abs(  point_2[index][0] - point_1[index][0] ) / float(eyes[index].frames[0].width);
 
       register_points_2 [index] = true;
       
       }
      
    }
    
     
    
    for (int i =0; i <= index ; i ++){
      println(i);
    if (register_points_1 [i] && register_points_2 [i]){
      
      eyes[i].display(point_1[i][0]/2+point_2[i][0]/2, point_1[i][1]/2+point_2[i][1]/2,ceil(eyes[i].frames[0].width*scales[i]),ceil(eyes[i].frames[0].height*scales[i]));
     eyes[i].animate(1,8);
    }
    }
   
}
