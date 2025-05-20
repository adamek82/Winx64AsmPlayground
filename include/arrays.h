#pragma once

/* Fixed matrix dimensions used in C */
#define NROWS 5
#define NCOLS 4

/*  Sums elements in the rectangle
 *      rows   0 … nrows-1   (≤ arrWidth)
 *      cols   0 … ncols-1   (≤ arrHeight)
 *  matrix     – pointer to [arrWidth][arrHeight] array (row-major)
 *  arrWidth   – physical row count  (usually NROWS)
 *  arrHeight  – physical col count  (usually NCOLS)
 */
int matrx_sum(const int matrix[][NCOLS],
              int arrWidth,  int arrHeight,
              int nrows,     int ncols);