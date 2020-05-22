PImage [] eye_frames = new PImage[13];
int eye_clock = 1;
float scale =0.4;

void load_eye_frames (){
 for (int i=1;i<=13;i++){
   eye_frames[i-1] = loadImage("eye_animation/eye_frame_"+str(i)+".png");

 }
}

void eye(int frame,float x,float y){

  image(eye_frames[frame-1],x-eye_frames[frame-1].width/2,y-eye_frames[frame-1].height/2);
  
}

void update_eye_clock(){
  if ( eye_clock == 7*15) eye_clock = 1;
  else eye_clock +=1;
}
