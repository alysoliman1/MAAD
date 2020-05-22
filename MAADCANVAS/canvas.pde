


void point (float x, float y, float rad , float fill_R, float fill_G, float fill_B , float stroke_R, float stroke_G, float stroke_B ) {
  stroke(stroke_R,stroke_G,stroke_B);
  fill (fill_R,fill_G,fill_B);
  ellipse(x,y,rad,rad);
}

void point (float x, float y, float rad , float fill_R, float fill_G, float fill_B ) {
  noStroke();
  fill (fill_R,fill_G,fill_B);
  ellipse(x,y,rad,rad);
}

void point (float x, float y, float rad , color c) {
  noStroke();
  fill (c);
  ellipse(x,y,rad,rad);
}
