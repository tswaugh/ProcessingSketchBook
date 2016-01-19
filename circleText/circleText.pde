import java.util.*;

float [][] objs;

void setup()
{
  size(500, 500);
  textFont(createFont("Arial", 30));

  objs = new float[10][4];

  Random r = new Random();

  for (int i=0; i < objs.length; i ++) {
    objs[i][0] = r.nextInt(501);
    objs[i][1] = r.nextInt(501);
    objs[i][2] = r.nextInt(150);
    objs[i][3] = r.nextFloat() * 500 + 100;
  }

  frameRate(120);
}

void draw()
{
  background(0);
  stroke(255);
  strokeWeight(6);

  for (int i=0; i < objs.length; i++) {

    int cx = (int) objs[i][0];
    int cy = (int) objs[i][1];
    int r = (int) objs[i][2];
    float tFact = (float) objs[i][3];

    float t = millis()/tFact;
    int x = (int)(cx+r*cos(t));
    int y = (int)(cy+r*sin(t));

    point(x, y);
  }
}