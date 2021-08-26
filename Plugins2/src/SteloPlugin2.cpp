#include <stdio.h>
#include <string.h>
#include <cstdlib>
#include <cmath>
#include "debug.h"
#include "SDiffuser.h"

char errorMessage[1024] = "";

void info(const char *str)
{
  printf("info: %s\n", str);
}

void error(const char *str)
{
  printf("error=%s\n", str);
  strcpy(errorMessage, str);
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

extern "C" {
  char *getError();
  void clearError();
  void nsum4(const float *src, float *dst, int cols, int rows);
  void nsum8(const float *src, float *dst, int cols, int rows);
  void diffuse4(float *dst, float percent, int cols, int rows);
  void diffuse8(float *dst, float percent, int cols, int rows);
};

char *getError()
{
  return errorMessage;
}

void clearError()
{
  *errorMessage = '\0';
}

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
