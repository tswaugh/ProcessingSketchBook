import megamu.mesh.*;
import java.util.*;

public Random rn;
public float[][] points;
public static int rCount = 6000;

void setup() {
  rn = new Random();

  surface.setResizable(true);
  fullScreen();
  noLoop();
}

void mouseClicked() {
  redraw();
}

void draw() {
  Long start = System.currentTimeMillis();
  System.out.println("[" + System.currentTimeMillis() + "]: Starting draw().");

  points = new float[rCount][2];

  for (int i=0; i < rCount; i++) {
    points[i][0] = rn.nextFloat() * width;
    points[i][1] = rn.nextFloat() * height;
  }

  Voronoi myVoronoi = new Voronoi( points );

  MPolygon[] myRegions = myVoronoi.getRegions();

  stroke(200);
  strokeWeight(1.5);
  
  for (int i=0; i<myRegions.length; i++)
  {
    // an array of points
    fill(rn.nextInt(48)+180);
    myRegions[i].draw(this); // draw this shape
  }

  System.out.println("[" + System.currentTimeMillis() + "]: Redraw finished.");
  System.out.println("Time elapsed: " + (new Long(System.currentTimeMillis() - start)).toString() + " ms");
}