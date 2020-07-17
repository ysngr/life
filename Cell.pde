class Cell {

  private final boolean ALIVE = true, DEAD = false;
  final color STRCOL = color(240);

  int cellRow, cellCol;
  float cellX, cellY, cellL;
  private boolean cellState;


  Cell(float x, float y, float l) {
    cellX = x;
    cellY = y;
    cellL = l;
    cellState = ( random(2) < 1 )? ALIVE : DEAD;
  }
  Cell(float x, float y, float l, boolean s) {
    cellX = x;
    cellY = y;
    cellL = l;
    cellState = s;
  }


  public boolean getCellState() {
    return cellState;
  }

  public void setCellState(boolean cellState) {
    this.cellState = cellState;
  }


  public void drawCell() {

    strokeWeight(1);
    stroke(STRCOL);
    fill(getStateColor());
    square(cellX, cellY, cellL);

    return ;
  }


  private color getStateColor() {
    return ( cellState )? color(240) : color(40);
  }
}
