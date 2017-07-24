Rectangle[] rectangle;
ThirdRect[] thirdrectangle;
Table colorVals, urls;
int rowCount;
float radius = 50;
float startX = radius;
float startY = radius;
float pad = 1;
//String urls[];
color avecolor;
int numColorBar = 3;

String obamaURL = "urlCsvobama.csv";
String trumpURL = "urlCsvtrump.csv";
String obamaDom = "dominantcolorsobama.csv";
String trumpDom = "dominantcolorstrump.csv";

import processing.pdf.*;
boolean export = false;
void setup() {
  /*if (export) {
   size(1000, 1000, PDF, "filename.pdf");
   } else {
   size(1000, 1000);
   }*/

  size(1000, 1000);
  urls =   new Table(trumpURL);
  colorVals = new Table(trumpDom);
  
  rowCount = colorVals.getRowCount();

  //rectangle = new Rectangle[rowCount]; 
  thirdrectangle = new ThirdRect[rowCount]; 
/*  for (int row = 0; row < rowCount; row++) {b
    thirdrectangle[row] = new ThirdRect(colorVals.getInt(row, 0), 
      colorVals.getInt(row, 1), 
      colorVals.getInt(row, 2), 
      colorVals.getInt(row, 3), 
      colorVals.getInt(row, 4), 
      colorVals.getInt(row, 5), 
      colorVals.getInt(row, 6), 
      colorVals.getInt(row, 7), 
      colorVals.getInt(row, 8), 
      radius, startX+row*radius, 
      startY, pad, urls.getString(row, 0));
    println(urls.getString(row, 0));
  }*/
  
    for (int row = 0; row < rowCount; row++) {
    thirdrectangle[row] = new ThirdRect(colorVals, radius, startX+row*radius, 
                                        startY, pad, urls.getString(row, 0), row, numColorBar, rowCount);
  }

  int r=0;
  int g=0;
  int b=0;
  for (int row = 0; row < rowCount; row++) {

    r+= colorVals.getInt(row, 0)+ colorVals.getInt(row, 3)+colorVals.getInt(row, 6); 
    g+=  colorVals.getInt(row, 1)+colorVals.getInt(row, 4)+ colorVals.getInt(row, 7); 
    b+=  colorVals.getInt(row, 2)+colorVals.getInt(row, 5)+ colorVals.getInt(row, 8);
  }
  avecolor = color(r/rowCount, b/rowCount, rowCount/rowCount);

}

void draw() {
  background(255); 
  for (int row = 0; row < rowCount; row++) {
    thirdrectangle[row].display(); 
    thirdrectangle[row].showUrl(mouseX, mouseY);
  }
  if (keyPressed) {
    exit();
  }
  fill(avecolor); 
 // rect(width-radius, height-radius, radius, radius);
}