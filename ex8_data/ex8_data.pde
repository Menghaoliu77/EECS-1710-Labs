int[] lines;

void setup(){
  lines = new int[8];
  lines[0] = 53;
  lines[1] = 32;
  lines[2] = 88;
  lines[3] = 14 + 32 + 100;
  lines[4] = 26 + 45;
  lines[5] = 21 + 31 + 15 + 19;
  lines[6] = 45;
  lines[7] = 27;
 
  size(1400,1000);
  background(0, 0, 0);
}

void draw(){
  clear();
  for(int i = 0; i<lines.length; i++){
    rect((width/16)*(i*2-1) + width/16+width/36, height-(height/16)-lines[i], width/16, lines[i]);
    textSize(25);
    text("Exercise:"+(i+1)+"\nLines of\ncode:"+lines[i],
    (width/16)*(i*2-1)+width/16+width/36,
    height-(height/8)-(height/32)-lines[i]);
  }
}
