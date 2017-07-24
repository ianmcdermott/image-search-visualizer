class ThirdRect extends Rectangle {
  color c1, c2, c3;
  float radiusGoal;
  float rHeight = 0;
  float xGoal1, xGoal3;
  float xRect1, xRect3;
  float offset;
  int index =0;
  float padding;
  float easing = .1;
  String urlString;
  boolean loaded = false;
  float squareX, squareY;
  Table colorValues;
  int[] rgb = {};
  int[] rgb2;
  color[] c;

  int num;

ThirdRect(Table cv, float rad, float x_, float y_, float p, String u, int rowNum, int numBars, int rc) {
    super(rad, x_, y_);
    colorValues = cv;
    x = x_;
    y = y_;
    radiusGoal = rad;
    c1 = color(colorValues.getInt(rowNum, 0), colorValues.getInt(rowNum, 1), colorValues.getInt(rowNum, 2));
    c2 = color(colorValues.getInt(rowNum, 3), colorValues.getInt(rowNum, 4), colorValues.getInt(rowNum, 5));
    c3 = color(colorValues.getInt(rowNum, 6), colorValues.getInt(rowNum, 7), colorValues.getInt(rowNum, 8));
    padding = p;
    
    num = numBars;

    xGoal1 = x+radiusGoal/3-padding*.9;
    xGoal3 = x+radiusGoal*2/3-padding;

    xRect1 = x+radiusGoal/3-padding;
    xRect3 = x+radiusGoal/3+padding;

    offset = width-radiusGoal*2;
    urlString = u;

    squareX = xGoal1-offset*index;
    squareY = y-offset*index+padding;
    
    rgb2= expand(rgb, rc*num);
    int RGBoffset = 0;
    for(int i = 0; i < num; i++){
      for(int j = 0; j < 3; j++){
        j+=RGBoffset;
        rgb2[j] = colorValues.getInt(rowNum, j);
      }
      RGBoffset += num;
    }
    
    c = new int[num];
    //rgb3 = expand(rgb2, rgb2.length/num);
    for(int i = 0; i < num; i++){
         c[i] = color(rgb2[num*i], rgb2[num*i+1], rgb2[num*i+2]);
    }
    

  }

  void display() {
    //println(radius);
    noStroke();

    //index will affect offset, each time index increases by one, multiply by offset so that rect will be in right loc of new row
    if (x >= width-radiusGoal) {
      y+= radiusGoal+padding*3;
      x-= (width - radiusGoal*2);
      index++;
    }


    rectMode(CENTER);

    if (export) {
      fill(c1);
      rect(xGoal1-offset*index, y, radiusGoal/3-padding, radiusGoal-padding);
      fill(c2);
      rect(x+radiusGoal/3-padding, y, radiusGoal/3-padding, radiusGoal-padding);
      fill(c3);
      rect(xGoal3-offset*index-padding*2, y, radiusGoal/3-padding, radiusGoal-padding);
    } else {
      fill(c1);
      rect(xRect1-offset*index, y, radiusGoal/3-padding, rHeight-padding);
      fill(c3);
      rect(xRect3-offset*index-padding*2, y, radiusGoal/3-padding, rHeight-padding);
      //draw center rect last so other two emerge from behind
      fill(c2);
      rect(x+radiusGoal/3-padding, y, radiusGoal/3-padding, rHeight-padding);
    }

    updateHeight();
    if (rHeight == radiusGoal) {
      updateWidth();
    }
  }

  void updateHeight() {
    float dR = radiusGoal - rHeight;

    rHeight+= dR*easing;

    if (rHeight >= radiusGoal-easing) {
      rHeight = radiusGoal;
    }
  }
  void updateWidth() {

    float xG1 = xRect1- xGoal1 + radiusGoal/3  ;
    float xG3 = xGoal3 - xRect3 ;

    //  println(xG);
    xRect1-= xG1*easing/3;
    xRect3+= xG3*easing/3;

    if (xRect1 <= xGoal1-radiusGoal/3+padding) {
      xRect1 = xGoal1-radiusGoal/3+padding;
      loaded = true;
    }
    if (xRect3 >= xGoal3) {
      xRect3 = xGoal3;
    }
      
    
  }

  void showUrl(float mx, float my) {
    if (loaded) {      
      if (mx > xRect1-offset*index && mx < xRect1-offset*index+radiusGoal && my > y-radiusGoal/2 && my < y+radiusGoal*1/2) {
        fill(0);
        textAlign(CENTER);
        text(urlString, width/2, height-50);
        fill(255, 120);

        rect(x+radiusGoal/3-padding, y, radiusGoal-padding*3, radiusGoal-padding);
      }
    }
  }
}