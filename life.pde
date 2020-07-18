/* lifegame */

CellBoard cb;

void setup() {
  size(860, 640);
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
    saveFrame("lifegame_"+frameCount+".png");
  } else if ( key == 'h' ) {
    noLoop();
  } else if ( key == 'r' ) {
    redraw();
  }
}
