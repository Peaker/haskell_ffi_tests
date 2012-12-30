INCLUDEDIRS=-I/usr/local/lib/ghc-7.4.1/include/
GHC=/usr/local/lib/ghc-7.4.1/
RTS=-Wl,-rpath=${GHC} -L${GHC} -lHSrts-ghc7.4.1
BASE=-Wl,-rpath=${GHC}/base-4.5.0.0/ -L${GHC}/base-4.5.0.0/ -lHSbase-4.5.0.0-ghc7.4.1
PRIM=-Wl,-rpath=${GHC}/ghc-prim-0.2.0.0 -L${GHC}/ghc-prim-0.2.0.0 -lHSghc-prim-0.2.0.0-ghc7.4.1
INTEGERGMP=-Wl,-rpath=${GHC}/integer-gmp-0.4.0.0 -L${GHC}/integer-gmp-0.4.0.0 -lHSinteger-gmp-0.4.0.0-ghc7.4.1

all: run_directcall run_test

run_test: test libtest.so
	./$<

run_directcall: directcall
	./$<

test: test.c
	gcc $< -o $@ -Wall -Wextra -g -ldl -lffi ${INCLUDEDIRS} ${RTS} ${BASE} ${PRIM} ${INTEGERGMP}

directcall: directcall.c Test_stub.h libtest.so
	gcc $< -o $@ -Wall -Wextra -g ${INCLUDEDIRS} -L. -Wl,-rpath=. -ltest ${RTS}

Test_stub.h: libtest.so

libtest.so: Test.hs
	ghc $< -o$@ -Wall --make -dynamic -shared -Wl,-soname=libtest.so -fPIC -lm -lrt

clean:
	-rm test Test.hi Test.o Test_stub.h libtest.so directcall
