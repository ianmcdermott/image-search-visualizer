
class Rectangle {
  float x, y;
  float radius;
  color c;

  Rectangle(float r, float g, float b) {
    c = color(r, g, b);
  }

  Rectangle(float r, float g, float b, float rad, float x_, float y_) {
    c = color(r, g, b);
    x = x_;
    y = y_;
    radius = rad;
  }

  //draw rectangle based on its place in the csv
  void display() {
    fill(c);
    noStroke();
    if (x >= width-radius) {
      y+= radius;
      x-= (width - radius*2);
    }
    rect(x, y, radius, radius);
  }
}