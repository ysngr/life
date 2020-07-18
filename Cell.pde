class Cell {

  final color STROKECOL = color(240);
  final color ALIVECELLCOLOR = color(240);
  final color DEADCELLCOLOR = color(40);

  private float cellX, cellY, cellL;
  private boolean cellState;


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
    stroke(STROKECOL);
    fill(cellState? ALIVECELLCOLOR : DEADCELLCOLOR);
    square(cellX, cellY, cellL);

    return ;
  }
}
