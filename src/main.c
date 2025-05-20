#include <stdio.h>
#include "hello.h"
#include "dynamic.h"
#include "arrays.h"

void fibonacci_tests(void) {
    struct { int n, expect; } tests[] = {
        { -100,  0 },
        {    0,  0 },
        {    1,  1 },
        {    3,  2 },
        {    7, 13 },
    };

    int count = sizeof(tests)/sizeof(tests[0]);
    printf("Running fib(n) tests:\n");

    for (int i = 0; i < count; ++i) {
        int n = tests[i].n;
        int got = fib(n);
        int ok = (got == tests[i].expect);
        printf("  fib(%4d) = %d; expected %3d -> %s\n",
               n, got, tests[i].expect,
               ok ? "PASS" : "FAIL");
    }
}

static void array_sum_tests(void) {
    /* Example matrix 1: 1..20 */
    int m1[NROWS][NCOLS] = {
        {  1,  2,  3,  4 },
        {  5,  6,  7,  8 },
        {  9, 10, 11, 12 },
        { 13, 14, 15, 16 },
        { 17, 18, 19, 20 }
    };
    /* Example matrix 2: all ones */
    int m2[NROWS][NCOLS] = {
        { 1, 1, 1, 1 },
        { 1, 1, 1, 1 },
        { 1, 1, 1, 1 },
        { 1, 1, 1, 1 },
        { 1, 1, 1, 1 }
    };
    /* Example matrix 3: all zeros */
    int m3[NROWS][NCOLS] = { 0 };

    struct { int (*mat)[NCOLS]; int expect; } cases[] = {
        { m1, 210 },   /* sum 1..20 */
        { m2,  20 },   /* 5×4 ones  */
        { m3,   0 }    /* zeros     */
    };

    printf("\nRunning matrix-sum tests:\n");
    for (int i = 0; i < 3; ++i) {
        int got = matrx_sum(cases[i].mat,
                            NROWS, NCOLS,          /* physical size   */
                            NROWS, NCOLS);         /* sub-matrix size */
        printf("  test %d -> sum = %d  (%s)\n",
               i + 1, got, got == cases[i].expect ? "PASS" : "FAIL");
    }
}

int main(void) {
    hello_message();
    fibonacci_tests();
    array_sum_tests();
    return 0;
}