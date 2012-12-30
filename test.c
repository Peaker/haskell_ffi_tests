#include <stdio.h>
#include <dlfcn.h>
#include <string.h>
#include <stdlib.h>
#include <assert.h>
#include <HsFFI.h>

int main(int argc, char *argv[]) {
    hs_init(&argc, &argv);
    void *dl = dlopen("./libtest.so", RTLD_LAZY);
    if(dl != NULL) {
        int (*func)(int) = dlsym(dl, "hsfun");
        printf("Haskell returned: %d\n", func(5));
        dlclose(dl);
    } else {
        printf("Could not load shared object:\n%s\n", dlerror());
    }
    return 0;
}
