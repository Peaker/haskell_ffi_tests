#include "Test_stub.h"
#include <stdio.h>

int main(int argc, char *argv[]) {
    hs_init(&argc, &argv);
    printf("from Haskell: %ld\n", hsfun(5));
    return 0;
}
