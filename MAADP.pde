import codeanticode.tablet.*;
import processing.sound.*;
Sound s;

Tablet tablet;



float pen_pressure, pre_pen_pressure, pressure_delta = 0;

TriOsc sin ;

void setup(){
  size(600,600);
  background(100);
  tablet = new Tablet(this); 
  sin = new TriOsc(this);


}

void draw (){
  
  cursor(CROSS);
  
  pen_pressure = tablet.getPressure(); // update pen pressure input
  
  if ( pen_pressure > 0 ){ // if the pen is touching the pad
  
   pressure_delta = abs(pen_pressure-pre_pen_pressure); // update change in pressure
   
   if ( pressure_delta > 0.05 ){ // if change in pressure is significant 
    
      background(255*(1-pen_pressure),255*(1-pen_pressure),255*pen_pressure);
      
      sin.play(200*pen_pressure+50*(1-pen_pressure),1);
      
      pre_pen_pressure = pen_pressure;
      
    } 
    
    point (mouseX, mouseY, 20* pen_pressure + 10, 255*pen_pressure,255*(1-pen_pressure),pen_pressure,255*(1-pen_pressure),255,2);
    point (mouseY, mouseX, 20* (1-pen_pressure) + 10, 255*pen_pressure,255*(1-pen_pressure),pen_pressure,255*(1-pen_pressure),255,2);
    
  }
  
  

  
  //w.display();
  //w.wiggle();
  
}

void point (float x, float y, float rad , float fill_R, float fill_G, float fill_B , float stroke_R, float stroke_G, float stroke_B ) {
  stroke(stroke_R,stroke_G,stroke_B);
  fill (fill_R,fill_G,fill_B);
  ellipse(x,y,rad,rad);
}

void keyPressed(){
  
    if (key == 'q'){
   sin.play(0,1);
  }
}
