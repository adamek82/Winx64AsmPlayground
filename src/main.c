#include <stdio.h>
#include "hello.h"
#include "dynamic.h"

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

int main(void) {
    hello_message();
    fibonacci_tests();
    return 0;
}