#include <stdio.h>
#include <string.h>
#include <cstdlib>
#include <cmath>
#include "debug.h"
#include "SDiffuser.h"

void info(const char *str)
{
  printf("info: %s\n", str);
}

void error(const char *str)
{
  printf("error=%s\n", str);
}

void printString(const char *str)
{
  printf("%s", str);
}

void printHex(int num)
{
  printf("%2x", num);
}

void printInteger(int num)
{
  printf("%d", num);
}

void printFloat(float num)
{
  printf("%.2f", num);
}

void printSpaces(int num)
{
  printf("%*s", num, "");
}

/* --------- */

SDiffuser diffuser;

void nsum4(const float *src, float *dst, int cols, int rows)
{
  debug("nsum4(cols=%d rows=%d)\n", cols, rows);
  diffuser.nsum4(src, dst, cols, rows);
}

void nsum8(const float *src, float *dst, int cols, int rows)
{
  debug("nsum8(cols=%d rows=%d)\n", cols, rows);
  diffuser.nsum8(src, dst, cols, rows);
}

void diffuse4(float *buf, float percent, int cols, int rows)
{
  debug("diffuse4(percent=%f cols=%d rows=%d)\n", percent, cols, rows);
  diffuser.diffuse4(buf, cols, rows, percent);
}

void diffuse8(float *buf, float percent, int cols, int rows)
{
  debug("diffuse8(percent=%f cols=%d rows=%d)\n", percent, cols, rows);
  diffuser.diffuse8(buf, cols, rows, percent);
}

/* --------- */

void clearFloatArray(float *buf, int cols, int rows)
{
  for (int i = 0; i < rows * cols; i ++) {
    *buf++ = 0.0;
  }
}

void printFloatArray(const float *buf, int cols, int rows)
{
  for (int i = 0; i < rows; i ++) {
    printf("  [");
    for (int j = 0; j < cols; j ++) {
      printf(" %.1f", *buf++);
    }
    printf("]\n");
  }
}

float sumFloatArray(const float *buf, int cols, int rows)
{
  float result = 0;
  for (int i = 0; i < rows * cols; i ++) {
    result += *buf++;
  }
  return result;
}

/* --------- */

void testNSum4()
{
  printString("--- testNSum4 ---\n");
  const int cols = 5;
  const int rows = 4;
  float src[cols*rows];
  float dst[cols*rows];
  clearFloatArray(src, cols, rows);
  src[6]=1;
  src[7]=2;
  src[8]=3;
  src[11]=4;
  src[12]=5;
  src[13]=6;
  src[16]=7;
  src[17]=8;
  src[18]=9;
  clearFloatArray(dst, cols, rows);
  printf("src=\n");
  printFloatArray(src, cols, rows);
  nsum4(src, dst, cols, rows);
  printf("dst=\n");
  printFloatArray(dst, cols, rows);
}

void testNSum8()
{
  printString("--- testNSum8 ---\n");
  const int cols = 5;
  const int rows = 4;
  float src[cols*rows];
  float dst[cols*rows];
  clearFloatArray(src, cols, rows);
  src[6]=1;
  src[7]=2;
  src[8]=3;
  src[11]=4;
  src[12]=5;
  src[13]=6;
  src[16]=7;
  src[17]=8;
  src[18]=9;
  clearFloatArray(dst, cols, rows);
  printf("src=\n");
  printFloatArray(src, cols, rows);
  nsum8(src, dst, cols, rows);
  printf("dst=\n");
  printFloatArray(dst, cols, rows);
}

void testDiffuse4()
{
  printString("--- testDiffuse4 ---\n");
  const int cols = 5;
  const int rows = 4;
  float buf[cols*rows];
  clearFloatArray(buf, cols, rows);
  buf[6]=1;
  buf[7]=2;
  buf[8]=3;
  buf[11]=4;
  buf[12]=5;
  buf[13]=6;
  buf[16]=7;
  buf[17]=8;
  buf[18]=9;
  printFloatArray(buf, cols, rows);
  printf("sum=%f\n", sumFloatArray(buf, cols, rows));
  diffuse4(buf, 90, cols, rows);
  printFloatArray(buf, cols, rows);
  printf("sum=%f\n", sumFloatArray(buf, cols, rows));
}

void testDiffuse8()
{
  printString("--- testDiffuse8 ---\n");
  const int cols = 5;
  const int rows = 4;
  float buf[cols*rows];
  clearFloatArray(buf, cols, rows);
  buf[6]=1;
  buf[7]=2;
  buf[8]=3;
  buf[11]=4;
  buf[12]=5;
  buf[13]=6;
  buf[16]=7;
  buf[17]=8;
  buf[18]=9;
  printFloatArray(buf, cols, rows);
  printf("sum=%f\n", sumFloatArray(buf, cols, rows));
  diffuse8(buf, 90, cols, rows);
  printFloatArray(buf, cols, rows);
  printf("sum=%f\n", sumFloatArray(buf, cols, rows));
  diffuse8(buf, 90, cols, rows);
  printFloatArray(buf, cols, rows);
  printf("sum=%f\n", sumFloatArray(buf, cols, rows));
}

int main()
{
  testNSum4();
  testNSum8();
  testDiffuse4();
  testDiffuse8();
  printf("\nall tests done\n");
  return 0;
}
