#include <stdio.h>
#include <stdint.h>

int is_big_endian(void) {
  union {
    uint32_t i;
    char c[4];
  } bint = {0x01020304};

  return bint.c[0] == 1;
}

int main(void) {
  if (is_big_endian()) {
    printf("Big-Endian\n");
  } else {
    printf("Little-Endian\n");
  }
  return 0;
}
