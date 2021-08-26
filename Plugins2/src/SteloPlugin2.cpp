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
  u_int8_t scale(float value, float from, float to, u_int8_t color);
  void scaleColor(const float *src, u_int8_t *dst, int size, float from, float to, u_int8_t baseColor);
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

/*
 * ScaleColor
 */
const static u_int8_t Black = 0;
const static u_int8_t White = 9;

u_int8_t scale(float value, float from, float to, u_int8_t color)
{
  if (from < to && value < from) {
    return Black;
  } else if (from < to && value > to) {
    return White;
  } else if (from > to && value > from) {
    return Black;
  } else if (from > to && value < to) {
    return White;
  }
  float param = (value - from) / (to - from);
  return ((color - 5) * (1 - param)) + ((color + 4) * param);
}

void scaleColor(const float *src, u_int8_t *dst, int size, float from, float to, u_int8_t baseColor)
{
  for (int i = 0; i < size; i ++) {
    float value = *src++;
    u_int8_t color = scale(value, from, to, baseColor);
    *dst++ = color;
  }
}

