#include "hip/hip_fp16.h"
#include "hip/hip_runtime.h"

#include <iostream>
#include <vector>

using std::vector;

#define HIP_CHECK(func)                                                        \
  do {                                                                         \
    hipError_t status = func;                                                  \
    if (status != hipSuccess) {                                                \
      std::cerr << "HIP error: " << hipGetErrorString(status)                  \
                << " calling " #func "at Line: " << __LINE__ << "\n";          \
      exit(1);                                                                 \
    }                                                                          \
  } while (0)

static constexpr uint32_t numWorkgroups = 1;
static constexpr uint32_t lanesPerWorkgroup = 32;

template <typename T>
void fillArray(vector<T> &buffer, T value) {
  for (size_t i = 0, e = buffer.size(); i < e; ++i) {
    buffer[i] = value;
  }
}
template <typename T>
void fillArray(vector<T> &buffer, const vector<T>& pattern) {
  for (size_t i = 0, e = buffer.size(); i < e; ++i) {
    buffer[i] = pattern[i % pattern.size()];
  }
}


void runKernel(void *aDevice, void *bDevice, void *cDevice, const char *filename) {
  hipModule_t Module;
  hipFunction_t Function;
  HIP_CHECK(hipModuleLoad(&Module, filename));
  HIP_CHECK(hipModuleGetFunction(
      &Function, Module,
      "test_dispatch_0_conv_2d_ngchw_gfchw_q_1x2x1x1x1x8x3x3_i8xi8xi32xi32xi32"));

  struct {
    void *a;
    void *b;
    void *c;
  } args;

  args.a = aDevice;
  args.b = bDevice;
  args.c = cDevice;

  size_t size = sizeof(args);
  void *config[] = {HIP_LAUNCH_PARAM_BUFFER_POINTER, &args,
                    HIP_LAUNCH_PARAM_BUFFER_SIZE, &size, HIP_LAUNCH_PARAM_END};

  HIP_CHECK(hipModuleLaunchKernel(Function, numWorkgroups, 1, 1,
                                  lanesPerWorkgroup, 1, 1, 0, 0, NULL,
                                  (void **)&config));
}

template <typename T>
void *pushToDevice(const vector<T> &hostVal) {
  void *ret = nullptr;
  size_t nBytes = hostVal.size() * sizeof(T);
  HIP_CHECK(hipMalloc((void **)&ret, nBytes));
  HIP_CHECK(hipMemcpyHtoD(ret, (void *)hostVal.data(), nBytes));
  return ret;
}

template <typename T>
vector<T> slurpFromDevice(void *deviceBuf, size_t length) {
  vector<T> ret(length, 0);
  HIP_CHECK(hipMemcpyDtoH(ret.data(), deviceBuf, length * sizeof(T)));
  return ret;
}

bool isCorrect(const vector<int32_t>& c) {
  return std::all_of(c.begin(), c.end(), [](int32_t e) { return e == (1 + 2 + 1) * 3 * 8 ; });
}

bool test(const char *filename) {
  constexpr uint32_t aSize = 2 * 8 * 3 * 3;
  constexpr uint32_t bSize = 2 * 8 * 3 * 3;
  constexpr uint32_t cSize = 2;

  vector<int8_t> a(aSize, 0);
  vector<int8_t> b(bSize, 0);
  vector<int32_t> c(cSize, 0);

  vector<int8_t> bPattern = {1, 2, 1};

  fillArray(a, (int8_t)1);
  fillArray(b, {(int8_t)1, (int8_t)2, (int8_t)1});

  void *aDevice = pushToDevice(a);
  void *bDevice = pushToDevice(b);
  void *cDevice = pushToDevice(c);

  runKernel(aDevice, bDevice, cDevice, filename);
  vector<int32_t> cGpu = slurpFromDevice<int32_t>(cDevice, cSize);
  HIP_CHECK(hipFree(aDevice));
  HIP_CHECK(hipFree(bDevice));
  HIP_CHECK(hipFree(cDevice));

  return isCorrect(cGpu);
}

int main(int argc, const char **argv) {
  if (argc != 2) {
    std::cerr << "Usage: " << argv[0] << " path_to_assembled_module.hsaco\n";
    return 1;
  }
  const char *filename = argv[1];
  std::cout << filename << " ... ";
  bool ret = test(filename);
  std::cout << (ret ? "pass\n" : "FAIL!\n");
  return !ret;
}
