/**
 * A specific status of the game field
 */
class Grid {
    rows: [GridRow];
    constructor(rowCount: Number, colCount: Number) {
        
    }
}

/**
 * A row in the grid
 */
class GridRow {
    rowNumber: Number;
    columns: [GridColumn];

    constructor() {

    }
}

/**
 * A column in a row. It represents a single cell.
 */
class GridColumn {
    colNumber: Number;
    alive : boolean;
    constructor() {

    }
}

let gridHistory: [Grid];
