class CellBoard {

  private final boolean ALIVE = true, DEAD = false;
  private final float CELLSIZE = 20;

  private Cell[][] cs;
  private boolean[][] pcss;


  CellBoard() {

    cs = new Cell[(int)(height/CELLSIZE)][(int)(width/CELLSIZE)];
    pcss = new boolean[(int)(height/CELLSIZE)][(int)(width/CELLSIZE)];

    for ( int r = 0; r < cs.length; r++ ) {
      for ( int c = 0; c < cs[r].length; c++ ) {
        cs[r][c] = new Cell(c*CELLSIZE, r*CELLSIZE, CELLSIZE);
        //cs[r][c] = new Cell(c*CELLSIZE, r*CELLSIZE, CELLSIZE, glider(r, c));
      }
    }
  }


  private boolean glider(int r, int c) {

    final int[][] initCellPlace = {
      {4, 2}, {2, 3}, {4, 3}, {3, 4}, {4, 4}
    };

    for ( int[] i : initCellPlace ) {
      if ( i[0] == r && i[1] == c ) {
        return true;
      }
    }

    return false;
  }


  public void drawStates() {

    for ( int r = 0; r < cs.length; r++ ) {
      for ( int c = 0; c < cs[r].length; c++ ) {
        cs[r][c].drawCell();
      }
    }

    return ;
  }


  public void update() {

    // copy current state of cells
    for ( int r = 0; r < cs.length; r++ ) {
      for ( int c = 0; c < cs[r].length; c++ ) {
        pcss[r][c] = cs[r][c].getCellState();
      }
    }

    // update
    for ( int r = 0; r < cs.length; r++ ) {
      for ( int c = 0; c < cs[r].length; c++ ) {
        cs[r][c].setCellState(calcNextCellStateAt(r, c));
      }
    }

    return ;
  }


  private boolean calcNextCellStateAt(int r, int c) {

    boolean nextState;
    int aliveCell;
    PVector[] neighborCellsIndexes = getNeighborCellsIndexes(r, c);

    aliveCell = 0;
    for ( PVector idx : neighborCellsIndexes ) {
      if ( pcss[(int)idx.x][(int)idx.y] ) {
        aliveCell++;
      }
    }

    if ( cs[r][c].getCellState() ) {
      if ( aliveCell == 2 || aliveCell == 3 ) {
        nextState = ALIVE;
      } else {
        nextState = DEAD;
      }
    } else {
      if ( aliveCell == 3 ) {
        nextState = ALIVE;
      } else {
        nextState = DEAD;
      }
    }

    return nextState;
  }


  private PVector[] getNeighborCellsIndexes(int r, int c) {

    PVector[] neighborCellsIndexes = {
      new PVector(r-1, c-1), new PVector(r-1, c), new PVector(r-1, c+1), 
      new PVector(r, c-1), /*                  */ new PVector(r, c+1), 
      new PVector(r+1, c-1), new PVector(r+1, c), new PVector(r+1, c+1)
    };

    for ( int k = 0; k < neighborCellsIndexes.length; k++ ) {
      neighborCellsIndexes[k].x = (neighborCellsIndexes[k].x + cs.length) % cs.length;
      neighborCellsIndexes[k].y = (neighborCellsIndexes[k].y + cs[0].length) % cs[0].length;
    }

    return neighborCellsIndexes;
  }
}
