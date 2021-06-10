void drawVisuals(boolean on){
  if(on){
    strokeWeight(2);
    stroke(255, 0, 0, 100);
    line(0, 0, 0, 100, 0, 0);
    stroke(0, 255, 0, 100);
    line(0, 0, 0, 0, 100, 0);
    stroke(0, 0, 255, 100);
    line(0, 0, 0, 0, 0, 100);
    
    strokeWeight(5);
    stroke(0);
    
    for(int i = 0; i < frames; i += 1){
      stroke(0, 255);
      point(pos[i][0], pos[i][1], pos[i][2]);
    }
  
    vectors.add(new PVector(float(data[int(beta)][0])*scale + offset[0], float(data[int(beta)][1])*scale + offset[1], float(data[int(beta)][2])*scale + offset[2]));
    
    if(beta < lines.length - 1){
      beta += 1;
    }
    
    noFill();
    stroke(0, 100);
    strokeWeight(1);
    beginShape();
    
    for(PVector v : vectors){
      curveVertex(v.x, v.y, v.z);
    }
    
    endShape();
  }
}

void drawBoundary(boolean on){
  if(on){
    for(int i = -200; i < -40; i += 5){
      pushMatrix();
      fill(255, 0, 0, 30);
      noStroke();
      
      int posX = 0;
      int posY = 0;
      int posZ = i;
      
      translate(posX, posY, posZ);
      sphere(25);
      popMatrix();
    }
    for(int i = 40; i < 200; i += 5){
      pushMatrix();
      fill(255, 0, 0, 30);
      noStroke();
      
      int posX = 0;
      int posY = 0;
      int posZ = i;
      
      translate(posX, posY, posZ);
      sphere(25);
      popMatrix();
    }
  }
}

void drawCam(){
  cam.beginHUD();
  stroke(0, 100); 
  strokeWeight(1);
  line(50, height - 50, 0, 150, height - 50, 0);
  line(50, height - 50, 0, 50, height - 150, 0);
  line(150, height - 50, 0, 150, height - 150, 0);
  line(50, height - 150, 0, 150, height - 150, 0);
  
  line(100, height - 100, -50, 200, height - 100, -50);
  line(100, height - 100, -50, 100, height - 200, -50);
  line(200, height - 100, -50, 200, height - 200, -50);
  line(100, height - 200, -50, 200, height - 200, -50);
  
  line(50, height - 50, 0, 100, height - 100, -50);
  line(50, height - 150, 0, 100, height - 200, -50);
  line(150, height - 50, 0, 200, height - 100, -50);
  line(150, height - 150, 0, 200, height - 200, -50);
  
  pushMatrix();
  fill(255, 0, 0, 100);
  noStroke();
  
  int posX = int(map(camPos[0], -1000, 1000, -50, 50)); 
  int posY = int(map(camPos[1], -1000, 1000, -50, 50)); 
  int posZ = int(map(camPos[2], -1000, 1000, -50, 50)); 
  
  translate(125 + posX, height - 100 + posY, -50 + posZ);
  sphere(10);
  popMatrix();
  cam.endHUD();
}
