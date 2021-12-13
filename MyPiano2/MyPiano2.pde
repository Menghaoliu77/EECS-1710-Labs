import ddf.minim.*;
AudioPlayer duo,re,mi,fa,sol,la,si,du;
Minim minim;
PImage background;
int[] alpha = new int[8];
AudioPlayer[] music = new AudioPlayer[8];
ArrayList<Integer> records = new ArrayList<Integer>();
String[] symbols = new String[8];
boolean play = false;
int index=0;
int button1,button2;
float x = 0;
AudioPlayer mySound;
void setup(){
  size(1920,1080);
  background = loadImage("piano.png");
  minim = new Minim(this);
  
  music[0]=duo = minim.loadFile("1.mp3");
  music[1]=re = minim.loadFile("2.mp3");
  music[2]=mi = minim.loadFile("3.mp3");
  music[3]=fa = minim.loadFile("4.mp3");
  music[4]=sol = minim.loadFile("5.mp3");
  music[5]=la = minim.loadFile("6.mp3");
  music[6]=si = minim.loadFile("7.mp3");
  music[7]=du = minim.loadFile("8.mp3");
  symbols[0] = "Do";
  symbols[1] = "Re";
  symbols[2] = "Mi";
  symbols[3] = "Fa";
  symbols[4] = "Sol";
  symbols[5] = "La";
  symbols[6] = "Si";
  symbols[7] = "Do";
  mySound = duo;
  button1 = 0;
  button2 = 0;
   
  for(int i= 0;i<8;i++){
    alpha[i] = 0;  
  }
  

}

void  draw(){
    int bufferSize = mySound.bufferSize();
  background(background);
  for(int i = 0;i<8;i++){
    fill(158,10,10,alpha[i]);
    rect(590+i*96,570,95,400);
  }
  //700，110
  for(int i = 0;i<records.size();i++){
    fill(158,10,10);
    textSize(40);
    int row = i/8;
    int col = i%8;
    text(symbols[records.get(i)],700+col*80,140+row*90);
  
  }
  noStroke();
fill(73,79,86);
rect(20,1020,1880,25);
  noStroke();
fill(108,229,232);
println(index+"-"+records.size());
if(records.size()>1&&play){
rect(20,1020,1880/records.size()*(index),25);
}
if(play&&records.size()>0){
  //println(frameCount);
  if(frameCount%60==0&&index<records.size()){
    
    music[records.get(index)].play();
    mySound = music[records.get(index)];
    music[records.get(index)].rewind();
         for(int i= 0;i<8;i++){
    alpha[i] = 0;  
  }
  alpha[records.get(index)] = 100;

      if(index<records.size()){
    index++;
  }else{
    play = false;
   
  
  }
  
  }

  


}
push();
noStroke();
fill(158,10,10,button1);
ellipse(1778,206,100,100);
pop();

push();
noStroke();
fill(158,10,10,100);
ellipse(1778,346,100,button2);
pop();


  
  stroke(255,0,0);
  strokeWeight(5);  
  for (int i=0; i<bufferSize-1; i=i+5)
  {  
   float x1 = map(i, 0, bufferSize, 0, width);
   float x2 = map(i, 0, bufferSize, 0, width);    
   line(x1, height - mySound.right.get(i)*800, x2, width - mySound.right.get(i)*800);
  }
   
  noStroke();
  translate(width/2, height/2); 
  //translate(mouseX, mouseY);
  fill(255,0,0);
  
  for(int i = 0; i < mySound.bufferSize() - 50; i=i+50)
  {          
    ellipse(0,0,mySound.left.get(i)*300,mySound.left.get(i)*300);    
  }

  fill(255,255,255);
  for(int i = 0; i < mySound.bufferSize() - 1; i=i+1) 
  {    
    rotate(x);    
    ellipse(i,i, mySound.left.get(i)*60,mySound.left.get(i)*60);
    x = x + 0.000001;    
  }



}

void mouseClicked(){
  if(dist(mouseX,mouseY,1780,205)<50){
    records.clear();  
    button1 = 100;
    button2 = 0;
    play = false;
    }
    
      if(dist(mouseX,mouseY,1780,345)<50){
    play = true;   
    index = 0;    
     button2 = 100;
    button1 = 0;
    }
    
    if(records.size()<40){
         
  //do
  if(abs(mouseX-637)<45&&abs(mouseY-750)<200){
    duo.play();  
    mySound = duo;
    duo.rewind();
     for(int i= 0;i<8;i++){
    alpha[i] = 0;  
  }
  alpha[0] = 100;
  records.add(0);
  }
  
    //re
  if(abs(mouseX-738)<45&&abs(mouseY-750)<200){
    re.play();  
     mySound = re;
    re.rewind();
     for(int i= 0;i<8;i++){
    alpha[i] = 0;  
  }
  alpha[1] = 100;
  records.add(1);
  }
  
      //mi
  if(abs(mouseX-832)<45&&abs(mouseY-750)<200){
    mi.play();  
    mySound = mi;
    mi.rewind();
     for(int i= 0;i<8;i++){
    alpha[i] = 0;
    
  }
  alpha[2] = 100;
  records.add(2);
  }
  
        //fa
  if(abs(mouseX-932)<45&&abs(mouseY-750)<200){
    fa.play(); 
    mySound = fa;
    fa.rewind();
     for(int i= 0;i<8;i++){
    alpha[i] = 0;  
  }
  alpha[3] = 100;
  records.add(3);
  }
          //sol
  if(abs(mouseX-1028)<45&&abs(mouseY-750)<200){
    sol.play();  
    mySound = sol;
    sol.rewind();
     for(int i= 0;i<8;i++){
    alpha[i] = 0;  
  }
  alpha[4] = 100;
  records.add(4);
  }
  
            //la
  if(abs(mouseX-1122)<45&&abs(mouseY-750)<200){
    la.play(); 
    mySound = la;
    la.rewind();
     for(int i= 0;i<8;i++){
    alpha[i] = 0;  
  }
  alpha[5] = 100;
  records.add(5);
  }
              //si
  if(abs(mouseX-1214)<45&&abs(mouseY-750)<200){
    si.play();  
    mySound = si;
    si.rewind();
     for(int i= 0;i<8;i++){
    alpha[i] = 0;  
  }
  alpha[6] = 100;
  records.add(6);
  }
                //do
  if(abs(mouseX-1316)<45&&abs(mouseY-750)<200){
    du.play();
    mySound = du;
    du.rewind();
     for(int i= 0;i<8;i++){
    alpha[i] = 0;  
  }
  alpha[7] = 100;
  records.add(7);
  }

    
    }
 
}

void keyPressed(){
  if(records.size()<40){
      //do
  if(key == 'S'||key == 's'){
    duo.play();  
    mySound = duo;
    duo.rewind();
     for(int i= 0;i<8;i++){
    alpha[i] = 0;  
  }
  alpha[0] = 100;
  records.add(0);
  }
  
    //re
  if(key == 'D'||key == 'd'){
    re.play();  
    mySound = re;
    re.rewind();
     for(int i= 0;i<8;i++){
    alpha[i] = 0;  
  }
  alpha[1] = 100;
  records.add(1);
  }
  
      //mi
  if(key == 'F'||key == 'f'){
    mi.play(); 
    mySound = mi;
    mi.rewind();
     for(int i= 0;i<8;i++){
    alpha[i] = 0;
    
  }
  alpha[2] = 100;
  records.add(2);
  }
  
        //fa
  if(key == 'G'||key == 'g'){
    fa.play();  
    mySound = fa;
    fa.rewind();
     for(int i= 0;i<8;i++){
    alpha[i] = 0;  
  }
  alpha[3] = 100;
  records.add(3);
  }
          //sol
  if(key == 'H'||key == 'h'){
    sol.play();  
    mySound = sol;
    sol.rewind();
     for(int i= 0;i<8;i++){
    alpha[i] = 0;  
  }
  alpha[4] = 100;
  records.add(4);
  }
  
            //la
  if(key == 'J'||key == 'j'){
    la.play();  
    mySound = la;
    la.rewind();
     for(int i= 0;i<8;i++){
    alpha[i] = 0;  
  }
  alpha[5] = 100;
  records.add(5);
  }
              //si
  if(key == 'K'||key == 'k'){
    si.play();  
    mySound = si;
    si.rewind();
     for(int i= 0;i<8;i++){
    alpha[i] = 0;  
  }
  alpha[6] = 100;
  records.add(6);
  }
                //do
  if(key == 'L'||key == 'l'){
    du.play(); 
    mySound = du;
    du.rewind();
     for(int i= 0;i<8;i++){
    alpha[i] = 0;  
  }
  alpha[7] = 100;
  records.add(7);
  }
}
}
