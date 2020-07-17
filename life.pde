/* life */

CellBoard cb;

void setup() {
  size(860, 640);
  //noLoop();
  frameRate(10);
  cb = new CellBoard();
}


void draw() {
  background(255);
  cb.drawStates();
  cb.update();
}


void keyPressed() {
  if ( key == 's' ) {
    saveFrame("lifegame"+frameCount+".png");
    //System.exit(0);
  } else if ( key == 'r' ) {
    redraw();
  }
}
