import peasy.*;

String[][] data;
float[][] pos;
float[][] cpos;
float[] offset;
String[] lines;
float[] camPos;

String[][] data3;
float[][] bd1;
String[] lines3;

float scale = 600;
float frames = 0;
float bd_frames = 0;
boolean reset = false;
float beta = 0;
float beta_bd = 0;
boolean boundaries = false;
boolean visuals = true;

int lenX = 0, lenY = 0, lenZ = 0;
int res = 10;
int[][][] colorData;
int maxColor = 0;
float vth = 20;
boolean heatmap = false;

ArrayList<PVector> vectors = new ArrayList<PVector>();
ArrayList<PVector> vectors_bd = new ArrayList<PVector>();

PeasyCam cam;
 
void setup(){  //add data normalization for fit to window
  size(1500,1000,P3D);

  cam = new PeasyCam(this, 0, 0, 0, 500);

  cam.setMinimumDistance(100);
  cam.setMaximumDistance(1000); 

  lines = loadStrings("positionDataTest.csv");
  
  data = new String[lines.length][3];
  pos = new float[lines.length][3];
  cpos = new float[lines.length][3];
  offset = new float[3];
  
  for(int i = 0; i < lines.length; i++){
    data[i] = split(lines[i], ',');
  }
  
  offset[0] = -float(data[int(0)][0])*scale;
  offset[1] = -float(data[int(0)][1])*scale;
  offset[2] = -float(data[int(0)][2])*scale;
  
  for(int i = 0; i < data.length; i += 1){
    for(int j = 0; j < 3; j++){
      pos[i][j] = float(data[int(i)][j])*scale + offset[j];
    }
  }
  
  for(int i = 0; i < data3.length; i += 1){
    for(int j = 0; j < 3; j++){
      bd1[i][j] = float(data3[int(i)][j])*scale;
    }
  }
}

void draw(){ 
  background(255);
  
  if(reset){
    reset = false;
    frames = 0;
    bd_frames = 0;
    beta = 0;
    beta_bd = 0;
    int size = vectors.size();
    for(int i = size - 1; i > 0; i--){
      vectors.remove(i);
    }
  }
  
  drawVisuals(visuals);
  drawBoundary(boundaries);
  
  camPos = cam.getPosition();
  
  cam.beginHUD();
  textSize(20);
  fill(0, 200);
  text("Iteration: " + int(frames), 50, 50);
  text("CoorX: " + int(camPos[0]), 50, 100);
  text("CoorY " + int(camPos[1]), 50, 150);
  text("CoorZ: " + int(camPos[2]), 50, 200);
  text("Visuals: " + visuals, 50, 250);
  text("Boundary: " + boundaries, 50, 300);
  text("HeatMap: " + heatmap, 50, 350);
  
  textSize(15);
  fill(255, 0, 0, 200);
  text("X---", width - 50, height - 90); 
  fill(0, 255, 0, 200);
  text("Y---", width - 50, height - 60); 
  fill(0, 0, 255, 200);
  text("Z---", width - 50, height - 30); 
  cam.endHUD();
  
  if(frames < lines.length){
    frames += 1;
  }
  
  if(bd_frames < lines3.length - 1){
    bd_frames += 1;
  }
}

float[] limits(String[][] arr, int index){
  float arr_max = -1000;
  float arr_min = 1000; 
  float[] temp1 = new float[arr.length];
  
  for(int i = 0; i < arr.length; i++){
    temp1[i] = float(arr[i][index]);
  }
  
  for(int i = 0; i < arr.length; i++){
    if(temp1[i] > arr_max){
      arr_max = temp1[i];
    }
    if(temp1[i] < arr_min){
      arr_min = temp1[i];
    }
  }
  
  float[] temp = new float[2];
  temp[0] = arr_min;
  temp[1] = arr_max;
  
  println(temp);
  
  return temp;
}

void keyPressed(){
  if(key == 'r'){
    reset = true;
  }
  if(key == 'b'){
    if(!boundaries){
      boundaries = true;
    } else{
      boundaries = false;
    }
  }
  if(key == 'u'){
    vth += 0.05;
  }
  if(key == 'd'){
    vth -= 0.05;
  }
  if(key == 'v'){
    if(!visuals){
      visuals = true;
    } else{
      visuals = false;
    }
  }
}
