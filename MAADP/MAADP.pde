
import codeanticode.tablet.*;

import processing.sound.*;

Sound s;

Tablet tablet; 

float pen_pressure, pre_pen_pressure, pressure_delta = 0; // tablet input info

color point_color_1 , point_color_2 , stroke_color ;

TriOsc sin ;

void setup(){
  
  size(600,600);
  
  background(100);
  
  tablet = new Tablet(this); 
  
  sin = new TriOsc(this);
  
}

void keyPressed(){

  if (key == 'q') sin.play(0,1); // set volume to 0
  
}

void point (float x, float y, float rad , color point_color , color stroke_color) {
  
  stroke(stroke_color);
  
  fill (point_color);
  
  ellipse(x,y,rad,rad);
  
}

void draw (){
  
  cursor(CROSS);
  
  pen_pressure = tablet.getPressure(); // update pen pressure input
  
  if ( pen_pressure > 0 ){ // if the pen is touching the pad
  
   pressure_delta = abs(pen_pressure-pre_pen_pressure); // update change in pressure
   
   if ( pressure_delta > 0.05 ){ // if change in pressure is significant 
    
      background(255*(1-pen_pressure),255*(1-pen_pressure),255*pen_pressure); // update background only when change in pressure is detected
      
      sin.play(200*pen_pressure+50*(1-pen_pressure),1); // update sound frequency and volume
      
      pre_pen_pressure = pen_pressure;
      
    } 
    
    // update colors
    
    point_color_1 = color (255*pen_pressure,255*(1-pen_pressure),pen_pressure);
    
    point_color_2 = color (255*pen_pressure,255*(1-pen_pressure),pen_pressure);
    
    // update stroke colors
    
    stroke_color = color(255*(1-pen_pressure),255,2);
    
    
    //draw points and update their radius 
    
    point ( mouseX, mouseY, 20 * pen_pressure + 10 , point_color_1 , stroke_color );
    
    point ( mouseY, mouseX, 20 * ( 1 - pen_pressure ) + 10 , point_color_2 , stroke_color );
    
  }
  
}
