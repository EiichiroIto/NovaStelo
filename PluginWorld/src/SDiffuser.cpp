#include <stdio.h>
#include <string.h>
#include "debug.h"
#include "SDiffuser.h"

/*
 * SDiffuser
 */

void SDiffuser::rolledUp(const float *src, float *dst, int cols, int count)
{
  memcpy(dst, &src[cols], (count - cols) * sizeof (float));
  memcpy(&dst[count - cols], src, cols * sizeof (float));
}

void SDiffuser::rolledDown(const float *src, float *dst, int cols, int count)
{
  memcpy(&dst[cols], src, (count - cols) * sizeof (float));
  memcpy(dst, &src[count - cols], cols * sizeof (float));
}

void SDiffuser::rolledLeft(const float *src, float *dst, int cols, int count)
{
  memcpy(dst, &src[1], (count - 1) * sizeof (float));
  float *p = &dst[cols - 1];
  for (int i = 0; i < count / cols; i ++) {
    *p = *src;
    src += cols;
    p += cols;
  }
}

void SDiffuser::rolledRight(const float *src, float *dst, int cols, int count)
{
  memcpy(&dst[1], src, (count - 1) * sizeof (float));
  const float *p = &src[cols - 1];
  for (int i = 0; i < count / cols; i ++) {
    *dst = *p;
    p += cols;
    dst += cols;
  }
}

void SDiffuser::addTo(const float *src, float *dst, int count)
{
  for (int i = 0; i < count; i ++) {
    dst[i] += src[i];
  }
}

void SDiffuser::nsum4(const float *src, float *dst, int cols, int rows)
{
  int count = cols * rows;
  float *tmp = new float[count];

  rolledLeft(src, dst, cols, count);
  rolledRight(src, tmp, cols, count);
  addTo(tmp, dst, count);
  rolledUp(src, tmp, cols, count);
  addTo(tmp, dst, count);
  rolledDown(src, tmp, cols, count);
  addTo(tmp, dst, count);

  delete[] tmp;
}

void SDiffuser::nsum8(const float *src, float *dst, int cols, int rows)
{
  int count = cols * rows;
  float *tmp = new float[count];
  float *tmp2 = new float[count];

  rolledLeft(src, dst, cols, count);
  rolledUp(dst, tmp, cols, count);
  addTo(tmp, dst, count);
  rolledUp(src, tmp, cols, count);
  addTo(tmp, dst, count);
  rolledRight(tmp, tmp2, cols, count);
  addTo(tmp2, dst, count);
  rolledRight(src, tmp, cols, count);
  addTo(tmp, dst, count);
  rolledDown(tmp, tmp2, cols, count);
  addTo(tmp2, dst, count);
  rolledDown(src, tmp, cols, count);
  addTo(tmp, dst, count);
  rolledLeft(tmp, tmp2, cols, count);
  addTo(tmp2, dst, count);
  
  delete[] tmp2;
  delete[] tmp;
}

void SDiffuser::copyFloatArray(const float *src, float *dst, int count)
{
  memcpy(dst, src, count * sizeof (float));
}

void SDiffuser::mulScalar(float *dst, float scalar, int count)
{
  for (int i = 0; i < count; i ++) {
    dst[i] *= scalar;
  }
}

void SDiffuser::diffuse4(float *buf, int cols, int rows, float percent)
{
  int count = cols * rows;
  float *tmp = new float[count];
  float *tmp2 = new float[count];

  copyFloatArray(buf, tmp2, count);
  mulScalar(tmp2, percent / 400.0, count);
  mulScalar(buf, (100 - percent) / 100, count);
  rolledLeft(tmp2, tmp, cols, count);
  addTo(tmp, buf, count);
  rolledRight(tmp2, tmp, cols, count);
  addTo(tmp, buf, count);
  rolledUp(tmp2, tmp, cols, count);
  addTo(tmp, buf, count);
  rolledDown(tmp2, tmp, cols, count);
  addTo(tmp, buf, count);

  delete[] tmp2;
  delete[] tmp;
}

void SDiffuser::diffuse8(float *buf, int cols, int rows, float percent)
{
  int count = cols * rows;
  float *tmp = new float[count];
  float *tmp2 = new float[count];
  float *tmp3 = new float[count];

  copyFloatArray(buf, tmp2, count);
  mulScalar(tmp2, percent / 800.0, count);
  mulScalar(buf, (100 - percent) / 100, count);
  rolledLeft(tmp2, tmp, cols, count);
  addTo(tmp, buf, count);
  rolledUp(tmp, tmp3, cols, count);
  addTo(tmp3, buf, count);
  rolledUp(tmp2, tmp, cols, count);
  addTo(tmp, buf, count);
  rolledRight(tmp, tmp3, cols, count);
  addTo(tmp3, buf, count);
  rolledRight(tmp2, tmp, cols, count);
  addTo(tmp, buf, count);
  rolledDown(tmp, tmp3, cols, count);
  addTo(tmp3, buf, count);
  rolledDown(tmp2, tmp, cols, count);
  addTo(tmp, buf, count);
  rolledLeft(tmp, tmp3, cols, count);
  addTo(tmp3, buf, count);

  delete[] tmp3;
  delete[] tmp2;
  delete[] tmp;
}
