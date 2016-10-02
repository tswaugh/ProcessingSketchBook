int cx, cy;
int radius;
float secondsRadius;
float minutesRadius;
float hoursRadius;
float clockDiameter;

void setup() {
  size(1024,1024);
  stroke(255);

  radius = min(width, height) / 2;
  // secondsRadius = radius * 0.85;
  minutesRadius = radius * 0.85;
  hoursRadius = radius * 0.3;
  clockDiameter = radius * 1.8;

  cx = width / 2;
  cy = height / 2;
}

void draw() {
  background(0);

  // Draw the clock background
  fill(80);
  noStroke();
  ellipse(cx, cy, clockDiameter, clockDiameter);

  // Angles for sin() and cos() start at 3 o'clock;
  // subtract HALF_PI to make them start at the top
  float s = map(second(), 0, 60, 0, TWO_PI) - HALF_PI;
  float m = map(minute() + norm(second(), 0, 60), 0, 60, 0, TWO_PI) - HALF_PI;
  float h = map(hour() + norm(minute(), 0, 60), 0, 24, 0, TWO_PI * 2) - HALF_PI;

  /* Speed it up!
  h = map(m,0,60,0,12);
  m = s;
  //*/

  // Draw the hands of the clock
  stroke(255);
  //strokeWeight(1);
  //line(cx, cy, cx + cos(s) * secondsRadius, cy + sin(s) * secondsRadius);
  strokeWeight(2);
  line(cx, cy, cx + cos(m) * (minutesRadius - 15), cy + sin(m) * (minutesRadius - 15));


  // Draw the minute ticks
  strokeWeight(2);
  beginShape(POINTS);
  for (int a = 0; a < 360; a+=6) {
    float angle = radians(a) - HALF_PI;
    if ((a%30) == 0 && a%60 != 0) {
      strokeWeight(10);
      fill(256,256,256);
      textSize(32);
      float x = cx - 20 + cos(angle) * minutesRadius;
      float y = cy + 10 + sin(angle) * minutesRadius;
      int minnum = (int) map(a,0,360,0,60);
      text(((minnum == 5) ? " 5" : Integer.toString(minnum)),x, y);
    } else if (a%60 == 0) {
      strokeWeight(5);
      fill(80);
      ellipse(cx + cos(angle) * minutesRadius, cy + sin(angle) * minutesRadius, 30, 30);
    } else {
      strokeWeight(2);
      float x = cx + cos(angle) * minutesRadius;
      float y = cy + sin(angle) * minutesRadius;
      vertex(x, y);
    }
  }
  endShape();

  // Draw the hours complication
  float cxh = cx - cos(m) * (radius * .425);
  float cyh = cy - sin(m) * (radius * .425);

  ellipse(cxh, cyh, 5, 5);

  strokeWeight(4);
  line(cxh, cyh, cxh + cos(h) * 135, cyh + sin(h) * 125);

  strokeWeight(8);
  beginShape(POINTS);
  for (int a= 0; a<360; a += 30){
    float angle = radians(a) - HALF_PI;

    float x1 = cxh + cos(angle) * 150;
    float y1 = cyh + sin(angle) * 150;
    float x2 = cxh + cos(angle) * 140;
    float y2 = cyh + sin(angle) * 140;
    line(x1, y1, x2, y2);;
    strokeWeight(2);
  }

  float cxc1 = cx - cos(m + HALF_PI) * (radius * .425);
  float cyc1 = cy - sin(m + HALF_PI) * (radius * .425);

  ellipse(cxc1, cyc1, 5, 5);

  float cxc2 = cx - cos(m - HALF_PI) * (radius * .425);
  float cyc2 = cy - sin(m - HALF_PI) * (radius * .425);

  ellipse(cxc2, cyc2, 5, 5);
}
