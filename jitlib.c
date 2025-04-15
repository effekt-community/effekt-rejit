#include "./effekt-types.h"
#include <sys/mman.h>

void c_jit_erase(void *envPtr){}

struct Pos c_jit_allocate_buffer(const Int size) {
  uint8_t* data = mmap(0, size, PROT_WRITE, MAP_ANON | MAP_PRIVATE, -1, 0);
  uint64_t data_i = (uint64_t)data;
  return (struct Pos) {
    .tag = data_i,
    .obj = 0
  };
}

struct Pos c_jit_free_buffer(struct Pos buffer, const Int size) {
  uint8_t* data = (uint8_t*)buffer.tag;
  munmap(data, size);
  return (struct Pos) {
    .tag = 0, .obj = 0
  };
}

struct Pos c_jit_make_writable(struct Pos buffer, const Int size) {
  uint8_t* data = (uint8_t*)buffer.tag;
  mprotect(data, size, PROT_WRITE | PROT_READ);
  return buffer;
}

struct Pos c_jit_make_executable(struct Pos buffer, const Int size) {
  uint8_t* data = (uint8_t*)buffer.tag;
  mprotect(data, size, PROT_EXEC);
  return buffer;
}

struct Pos c_jit_write(struct Pos buffer, const Int offset, const Byte value) {
  uint8_t* data = (uint8_t*)buffer.tag;
  data[offset] = value;
  return buffer;
}

const Int c_jit_callI_I(struct Pos buffer, const Int offset, const Int arg) {
  uint8_t* data = (uint8_t*)buffer.tag;
  Int(*fn)(Int) = (Int(*)(Int))(data + offset);
  return fn(arg);
}

const Int c_jit_callI_PI(struct Pos buffer, const Int offset, struct Pos arg1, const Int arg2) {
  uint8_t* data = (uint8_t*)buffer.tag;
  Int(*fn)(struct Pos, Int) = (Int(*)(struct Pos, Int))(data + offset);
  return fn(arg1, arg2);
}

struct Pos c_jit_callP_P(struct Pos buffer, const Int offset, struct Pos arg) {
  uint8_t* data = (uint8_t*)buffer.tag;
  struct Pos(*fn)(struct Pos) = (struct Pos(*)(struct Pos))(data + offset);
  return fn(arg);
}
struct Pos c_jit_callP_PP(struct Pos buffer, const Int offset, struct Pos arg1, struct Pos arg2) {
  uint8_t* data = (uint8_t*)buffer.tag;
  struct Pos(*fn)(struct Pos,struct Pos) = (struct Pos(*)(struct Pos,struct Pos))(data + offset);
  return fn(arg1, arg2);
}