int cx = 250;
int cy = 250;
int r = 100;

void setup()
{
  size(500, 500);
  textFont(createFont("Arial", 30));
}

void draw()
{
  background(0);
  stroke(255);
  
  float t = millis()/1000.0f;
  int x = (int)(cx+r*cos(t));
  int y = (int)(cy+r*sin(t));

  text("Test", x, y);
}