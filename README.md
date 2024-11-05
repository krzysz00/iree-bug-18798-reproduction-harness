# IREE 18798 reproduction harness

This is a simple driver program to explore what's almost certainly a backend
bug in LLVM that's triggered by some IREE convolutions.

## BUilding

Edit `Makefile` to change `LLVM_BUILD_BIN_DIR` to your choice of LLVM
build (I've been using the tip of upstream's main).

```
make test
```

will run the tests

## Files

- `original-ir.ll` is the IR from the LLVM ticket
- `reduced-input.ll` is an attempt to remove "unneeded" (the assume_alignment stuff and workitems y and z) code from the IR that makes it work by some miracle
- `reduced-input-with-adds.ll` is the original IR without the `memref.assume` stuff
but with adding workitem IDs y and z. It also fails.
- `driver.cpp` is the test program
- `anonymize-regs.pl` is a script that might make it easier to read `.s` diffs by erasing register numbers

## Expected results

`./O3.hsaco` should fail, all other tests should pass.

## Context

https://github.com/iree-org/iree/issues/18798

https://github.com/llvm/llvm-project/issues/112941
