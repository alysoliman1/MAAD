class animation { // animation object 

public int frame_count;  
  
public PImage [] frames ;

private int [] mouse_track_frames;

public boolean mouse_tracking = false;

public float x,y,w,h;

private float current_frame = 1;
  
animation(String frames_folder_name){
   
  frame_count = listFiles(sketchPath ("data/"+frames_folder_name)).length; // get number of frames

  frames = new PImage[frame_count]; 

  for (int i = 1; i <= frame_count; i++) frames[i-1] = loadImage(frames_folder_name+"/"+str(i)+".png"); // load frames

}

void set_mouse_tracking (int [] frames ){ mouse_track_frames = frames; } // get frames to be used when mouse tracking 

void display (float x, float y,float w,float h){ // display animation
  
  // update current position and size 
  
  this.x = x;
  this.y = y;
  this.w = w;
  this.h = h;

  if (mouseX > x - w && mouseX < x+w && mouseY > y - h && mouseY < y+h ) mouse_tracking = true; // if the mouse is close enough to the frame go into mousetracking mode
  
  else mouse_tracking = false; // otherwise go back to normal animation

  image (frames[floor(current_frame)-1],x,y,w,h);

}
  
void animate (int start_frame, int end_frame){
  
  if( mouse_tracking == false ){
  
    if ( current_frame  >= end_frame ) current_frame = start_frame;
  
    current_frame += 0.1; 
    
  } else {
  
      if ( mouseX > this.x-this.w/6 && mouseX < this.x + this.w/6 && mouseY < this.y )  current_frame = mouse_track_frames[0];
      
      if ( mouseX > this.x+this.w/6 && mouseY < this.y ) current_frame = mouse_track_frames[1];
     
      if ( mouseX < this.x-this.w/6 && mouseY < this.y )  current_frame = mouse_track_frames[2];
      
      if ( mouseX > this.x-this.w/6 && mouseX < this.x + this.w/6 && mouseY > this.y ) current_frame = mouse_track_frames[3];
      
      if ( mouseX < this.x-this.w/6 && mouseY > this.y )  current_frame = mouse_track_frames[4];
      
      if ( mouseX > this.x+this.w/6 && mouseY > this.y )  current_frame = mouse_track_frames[5];
      
        }
  }
 
}
