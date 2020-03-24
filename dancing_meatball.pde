import peasy.*;
import processing.sound.*;

Amplitude amp;
AudioIn in;
PeasyCam camera;
PVector[][] meatball;
int tot_num = 10;

void setup() {
  size(1000, 1000, P3D);
  colorMode(HSB);
  //100 to view inside of meatball
  camera = new PeasyCam(this, 500);
  meatball = new PVector[tot_num+1][tot_num+1];
  amp = new Amplitude(this);
  in = new AudioIn(this, 0);
  in.start(); 
  amp.input(in);
}

void draw() {
  background(0);
  frameRate(10);
  float a = ((amp.analyze()*4000) / (float) width) * 90f / 50;
  rotateZ(90);
  float x_rot = amp.analyze()*4000/4;
  rotateX(x_rot);
  scale(a);
  float r = 200;
  for (int i = 0; i < tot_num+1; i++) {
    float lat = map(i, 0, tot_num, 0, PI);
    for (int j = 0; j < tot_num+1; j++) {
      float lon = map(j, 0, tot_num, 0, TWO_PI);
      float x = r * sin(lat) * cos(lon);
      float y = r * sin(lat) * sin(lon);
      float z = r * cos(lat);
      meatball[i][j] = new PVector(x, y, z);
    }
  }

  for (int i = 0; i < tot_num; i++) {
    noFill();
    stroke(255);
    strokeWeight(2);
    beginShape(TRIANGLE_STRIP);
    for (int j = 0; j < tot_num+1; j++) {
      PVector v1 = meatball[i][j];
      stroke(0);
      vertex(v1.x, v1.y, v1.z);
      stroke(x_rot, 255, 255);
      PVector v2 = meatball[i+1][j];
      vertex(v2.x, v2.y, v2.z);
    }
    endShape();
  }
}
