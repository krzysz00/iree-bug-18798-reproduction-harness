LLVM_BUILD_BIN_DIR ?= ${HOME}/llvm-project/build/bin
LLC := ${LLVM_BUILD_BIN_DIR}/llc
MC := ${LLVM_BUILD_BIN_DIR}/llvm-mc

ROCM_ROOT := $(shell hipconfig -R)
LLD := ${ROCM_ROOT}/llvm/bin/ld.lld
CXX := ${ROCM_ROOT}/llvm/bin/clang++

# Save you the bother of editing for your system
GPU := $(shell ${ROCM_ROOT}/bin/rocm_agent_enumerator | grep -v gfx000 | head -n 1)

# Common flags
LLCFLAGS ?= -mtriple=amdgcn-amd-amdhsa -mcpu=${GPU}
MCFLAGS ?= --triple=amdgcn-amd-amdhsa -mcpu=${GPU}

HIP_CXXFLAGS := $(shell hipconfig -C)
CXXFLAGS += -std=c++17 -Wall -Wextra -O2 -g ${HIP_CXXFLAGS}
LDFLAGS += -L${ROCM_ROOT}/lib -lamdhip64 -Wl,-rpath=${ROCM_ROOT}/lib

tests = O3.hsaco O3-no-assumes.hsaco O3-global-isel.hsaco

all: driver ${tests}

test: all
	./driver ./O3-global-isel.hsaco
	./driver ./O3-no-assumes.hsaco
	-./driver ./O3.hsaco

O3.s: original-ir.ll
	${LLC} ${LLCFLAGS} -O3 -o $@ $^
O3-no-assumes.s: reduced-input.ll
	${LLC} ${LLCFLAGS} -O3 -o $@ $^
O3-global-isel.s: original-ir.ll
	${LLC} ${LLCFLAGS} -global-isel=1 -O3 -o $@ $^


%.o: %.s
	${MC} ${MCFLAGS} --filetype=obj -o $@ $^
%.hsaco: %.o
	${LLD} -shared -o $@ $^

driver: driver.o
	${CXX} ${LDFLAGS} -o $@ $^
driver.o: driver.cpp
	${CXX} ${CXXFLAGS} -c -o $@ $^

clean:
	rm *.o *.s *.hsaco driver

.PHONY: all clean test
