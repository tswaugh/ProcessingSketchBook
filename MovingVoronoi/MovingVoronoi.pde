import megamu.mesh.*;
import java.util.*;

public Random rn;
public static int PCOUNT = 20;
public MovingPoints mPoints;

void setup() {
  rn = new Random();
  size(500, 500);
  surface.setResizable(true);
  
  //fullScreen();
  //noLoop();
  frameRate(60);
  mPoints = new MovingPoints(PCOUNT);
}

void draw() {
  Long start = System.currentTimeMillis();
  System.out.println("[" + System.currentTimeMillis() + "]: Starting draw().");
  //System.out.println("Getting current position.");
  float[][] points = mPoints.getCurrPost();
  //System.out.println(points.length);
  //System.out.println(Arrays.toString(points));
  
  Voronoi myVoronoi = new Voronoi(points);

  MPolygon[] myRegions = myVoronoi.getRegions();

  stroke(200);
  strokeWeight(1.5);

  for (int i=0; i<myRegions.length; i++)
  {
    // an array of points
    fill(points[i][2]);
    myRegions[i].draw(this); // draw this shape
  }

  System.out.println("[" + System.currentTimeMillis() + "]: Redraw finished.");
  System.out.println("Time elapsed: " + (new Long(System.currentTimeMillis() - start)).toString() + " ms");
  System.out.println("Current FPS: " + frameRate);
}

private class MovingPoints {
  public Random rn;
  public float[][] points;
  public int pCount;

  public MovingPoints(int rCount) {
    this.rn = new Random();
    this.points = new float[rCount][5];
    this.pCount = rCount;

    for (int i = 0; i < rCount; i++) {
      this.points[i][0] = rn.nextInt(width); // xcenter pos
      this.points[i][1] = rn.nextInt(height); // ycenter pos
      this.points[i][2] = rn.nextInt(150); // radius
      this.points[i][3] = rn.nextFloat() * 1000 + 2000; //time factor changes speed
      this.points[i][4] = rn.nextInt(60)+180; // region color

      //System.out.println(this.points[i][0] + ", " + this.points[i][1] + ", " + this.points[i][2] + ", " + this.points[i][3] + ", " + this.points[i][4]);
    }
  }

  public float[][] getCurrPost() {
    float[][] positions = new float[pCount][3];

    float cMills = millis();

    for (int i = 0; i < pCount; i++) {
      int cx = (int) points[i][0];
      int cy = (int) points[i][1];
      int r = (int) points[i][2];
      float tFact = (float) points[i][3];
      float t = cMills/tFact;

      positions[i][0] = (int)(cx+r*cos(t));
      positions[i][1] = (int)(cy+r*sin(t));
      positions[i][2] = points[i][4];

      //System.out.println(positions[i][0] + ", " + positions[i][1] + ", " + positions[i][2]);
    }

    return positions;
  }
}