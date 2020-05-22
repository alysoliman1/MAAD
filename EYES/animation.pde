class animation {

public int frame_count;  
  
public PImage [] frames ;

private int [] mouse_track_frames;

private boolean mouse_tracking = false;

private float current_frame = 1;
  
animation(String frames_folder_name){
   
  frame_count = listFiles(sketchPath ("data/"+frames_folder_name)).length;

  frames = new PImage[frame_count];

  for (int i = 1; i <= frame_count; i++){
    
    frames[i-1] = loadImage(frames_folder_name+"/"+str(i)+".png");
  
  }

}

void set_mouse_tracking (int [] frames ){ mouse_track_frames = frames; }

void display (float x, float y){ image (frames[floor(current_frame)-1],x,y); }

void rescale (float scale) {
  
    for (int i=1;i<=frame_count;i++) frames[i-1].resize(ceil(frames[i-1].width*scale),ceil(frames[i-1].height*scale));
    
}
  
void animate (int start_frame, int end_frame){
  
  if ( current_frame  >= end_frame ) current_frame = start_frame;
  
  current_frame += 0.1; 
}
  
  
  
}
