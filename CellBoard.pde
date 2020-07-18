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
        cs[r][c] = new Cell(c*CELLSIZE, r*CELLSIZE, CELLSIZE, randomInit());
        //cs[r][c] = new Cell(c*CELLSIZE, r*CELLSIZE, CELLSIZE, gliderInit(r, c));
        //cs[r][c] = new Cell(c*CELLSIZE, r*CELLSIZE, CELLSIZE, gliderGunInit(r, c));
        //cs[r][c] = new Cell(c*CELLSIZE, r*CELLSIZE, CELLSIZE, dieHardInit(r, c));
      }
    }
  }


  private boolean randomInit() {
    return ( random(2) < 1 )? ALIVE : DEAD;
  }

  private boolean gliderInit(int r, int c) {

    final int[][] initCellPlace = {{4, 2}, {2, 3}, {4, 3}, {3, 4}, {4, 4}};

    for ( int[] i : initCellPlace ) {
      if ( i[0] == r && i[1] == c ) {
        return true;
      }
    }

    return false;
  }

  private boolean gliderGunInit(int r, int c) {

    final int[][] initCellPlace = {
      { 6,  2}, { 7,  2}, { 6,  3}, { 7,  3}, { 6, 12}, { 7, 12}, { 8, 12}, { 5, 13}, { 9, 13}, { 4, 14}, {10, 14}, { 4, 15}, 
      {10, 15}, { 7, 16}, { 5, 17}, { 9, 17}, { 6, 18}, { 7, 18}, { 8, 18}, { 7, 19}, { 4, 22}, { 5, 22}, { 6, 22}, { 4, 23}, 
      { 5, 23}, { 6, 23}, { 3, 24}, { 7, 24}, { 2, 26}, { 3, 26}, { 7, 26}, { 8, 26}, { 4, 36}, { 5, 36}, { 4, 37}, { 5, 37}
    };

    for ( int[] i : initCellPlace ) {
      if ( i[0] == r && i[1] == c ) {
        return true;
      }
    }

    return false;
  }

  private boolean dieHardInit(int r, int c) {

    final int[][] initCellPlace = {{6, 7}, {6, 8}, {7, 8}, {7, 12}, {5, 13}, {7, 13}, {7, 14}};

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
      nextState = ( aliveCell == 2 || aliveCell == 3 )? ALIVE : DEAD;
    } else {
      nextState = ( aliveCell == 3 )? ALIVE : DEAD;
    }

    return nextState;
  }


  private PVector[] getNeighborCellsIndexes(int r, int c) {

    PVector[] neighborCellsIndexes = {
      new PVector(r-1, c-1), new PVector(r-1, c), new PVector(r-1, c+1), 
      new PVector(r  , c-1),                      new PVector(  r, c+1), 
      new PVector(r+1, c-1), new PVector(r+1, c), new PVector(r+1, c+1)
    };

    for ( int k = 0; k < neighborCellsIndexes.length; k++ ) {
      neighborCellsIndexes[k].x = (neighborCellsIndexes[k].x + cs.length) % cs.length;
      neighborCellsIndexes[k].y = (neighborCellsIndexes[k].y + cs[0].length) % cs[0].length;
    }

    return neighborCellsIndexes;
  }
}
