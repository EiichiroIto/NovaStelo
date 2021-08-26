#include <stdio.h>
#include "debug.h"
#include "SDiffuser.h"

/*
 * SDiffuser
 */

SDiffuser::SDiffuser()
{
  _extended = NULL;
  _normal = NULL;
  _size = 0;
  _cols = 0;
  _rows = 0;
}

SDiffuser::~SDiffuser()
{
  free();
}

void SDiffuser::free()
{
  if (_extended != NULL) {
    delete[] _extended;
    _extended = NULL;
  }
  _size = 0;
  _cols = 0;
  _rows = 0;
}

void SDiffuser::allocate(int size)
{
  if (size > _size) {
    free();
    _size = size;
    _extended = new float[_size];
    debug("SDiffuser::allocate allocated %d\n", _size);
  }
}

void SDiffuser::setupNsum(const float *src, float *dst, int cols, int rows, int neighborSize)
{
  allocate((cols + 2) * (rows + 2));
  _cols = cols;
  _rows = rows;
  setupNeighbor();
  _normal = dst;
  setupExtended(src);
  setupBorder();
  _neighborSize = neighborSize;
  debug("SDiffuser::setupNsum cols=%d rows=%d\n", _cols, _rows);
}

void SDiffuser::setupDiffuse(float *buf, int cols, int rows, int neighborSize)
{
  allocate((cols + 2) * (rows + 2));
  _cols = cols;
  _rows = rows;
  setupNeighbor();
  _normal = buf;
  clearExtended();
  _neighborSize = neighborSize;
  debug("SDiffuser::setupDiffuse cols=%d rows=%d\n", _cols, _rows);
}

void SDiffuser::setupExtended(const float *src)
{
  int count = 0;
  for (int x = 0; x < _cols + 2; x ++) {
    _extended[count ++] = 0;
  }
  for (int y = 0; y < _rows; y ++) {
    _extended[count ++] = 0;
    for (int x = 0; x < _cols; x ++) {
      _extended[count ++] = *src++;
    }
    _extended[count ++] = 0;
  }
  for (int x = 0; x < _cols + 2; x ++) {
    _extended[count ++] = 0;
  }
  if (count != _size) {
    debug("count=%d, size=%d, cols=%d rows=%d\n", count, _size, _cols, _rows);
    error("SDiffuser::setupSrc: internal error");
  }
}

void SDiffuser::clearExtended()
{
  for (int i = 0; i < (_cols + 2) * (_rows + 2); i ++) {
    _extended[i] = 0;
  }
}

int SDiffuser::indexOfExtended(int x, int y) const
{
  return (x + 1) + ((y + 1) * (_cols + 2));
}

int SDiffuser::indexOfNormal(int x, int y) const
{
  return x + (y * _cols);
}

void SDiffuser::setupNeighbor()
{
  neighbor[0] = 1;
  neighbor[1] = -1;
  neighbor[2] = _cols + 2;
  neighbor[3] = - (_cols + 2);
  neighbor[4] = _cols + 1;
  neighbor[5] = _cols + 3;
  neighbor[6] = - (_cols + 1);
  neighbor[7] = - (_cols + 3);
}

void SDiffuser::setupBorder()
{
  int src = indexOfExtended(0, 0);
  int dst = indexOfExtended(0, _rows);
  for (int i = 0; i < _cols; i ++) {
    _extended[dst ++] = _extended[src ++];
  }
  src = indexOfExtended(0, _rows-1);
  dst = indexOfExtended(0, -1);
  for (int i = 0; i < _cols; i ++) {
    _extended[dst ++] = _extended[src ++];
  }
  src = indexOfExtended(_cols-1, 0);
  dst = indexOfExtended(-1, 0);
  for (int i = 0; i < _rows; i ++) {
    _extended[dst] = _extended[src];
    dst += _cols + 2;
    src += _cols + 2;
  }
  src = indexOfExtended(0, 0);
  dst = indexOfExtended(_cols, 0);
  for (int i = 0; i < _rows; i ++) {
    _extended[dst] = _extended[src];
    dst += _cols + 2;
    src += _cols + 2;
  }
  src = indexOfExtended(0, 0);
  dst = indexOfExtended(_cols, _rows);
  _extended[dst] = _extended[src];
  src = indexOfExtended(_cols-1, _rows-1);
  dst = indexOfExtended(-1, -1);
  _extended[dst] = _extended[src];
  src = indexOfExtended(_cols-1, 0);
  dst = indexOfExtended(-1, _rows);
  _extended[dst] = _extended[src];
  src = indexOfExtended(0, _rows-1);
  dst = indexOfExtended(_cols, -1);
  _extended[dst] = _extended[src];
}

void SDiffuser::nsum()
{
  for (int y = 0; y < _rows; y ++) {
    int srcOffset = indexOfExtended(0, y);
    int dstOffset = indexOfNormal(0, y);
    for (int x = 0; x < _cols; x ++) {
      int sum = 0;
      for (int i = 0; i < _neighborSize; i ++) {
        sum += _extended[srcOffset + neighbor[i]];
      }
      srcOffset ++;
      _normal[dstOffset ++] = sum;
    }
  }
}

void SDiffuser::nsum4(const float *src, float *dst, int cols, int rows)
{
  setupNsum(src, dst, cols, rows, 4);
  nsum();
}

void SDiffuser::nsum8(const float *src, float *dst, int cols, int rows)
{
  setupNsum(src, dst, cols, rows, 8);
  nsum();
}

void SDiffuser::diffuse(float percent)
{
  for (int y = 0; y < _rows; y ++) {
    int srcOffset = indexOfNormal(0, y);
    int dstOffset = indexOfExtended(0, y);
    for (int x = 0; x < _cols; x ++) {
      float data = _normal[srcOffset];
      float use = data / 100.0 * percent;
      float distributes = use / _neighborSize;
      _extended[dstOffset] += data - use;
      for (int i = 0; i < _neighborSize; i ++) {
        _extended[dstOffset + neighbor[i]] += distributes;
      }
      srcOffset ++;
      dstOffset ++;
    }
  }
}

void SDiffuser::restoreExtended(float *buf)
{
  int src, dst;

  for (int y = 0; y < _rows; y ++) {
    src = indexOfExtended(0, y);
    dst = indexOfNormal(0, y);
    for (int x = 0; x < _cols; x ++) {
      buf[dst ++] = _extended[src ++];
    }
  }
  src = indexOfExtended(0, -1);
  dst = indexOfNormal(0, _rows-1);
  for (int x = 0; x < _cols; x ++) {
    buf[dst ++] += _extended[src ++];
  }
  src = indexOfExtended(0, _rows);
  dst = indexOfNormal(0, 0);
  for (int x = 0; x < _cols; x ++) {
    buf[dst ++] += _extended[src ++];
  }
  src = indexOfExtended(-1, 0);
  dst = indexOfNormal(_cols-1, 0);
  for (int y = 0; y < _rows; y ++) {
    buf[dst] += _extended[src];
    src += _cols + 2;
    dst += _cols;
  }
  src = indexOfExtended(_cols, 0);
  dst = indexOfNormal(0, 0);
  for (int y = 0; y < _rows; y ++) {
    buf[dst] += _extended[src];
    src += _cols + 2;
    dst += _cols;
  }
  src = indexOfExtended(_cols, _rows);
  dst = indexOfNormal(0, 0);
  buf[dst] += _extended[src];
  src = indexOfExtended(-1, -1);
  dst = indexOfNormal(_cols-1, _rows-1);
  buf[dst] += _extended[src];
  src = indexOfExtended(-1, _rows);
  dst = indexOfNormal(_cols-1, 0);
  buf[dst] += _extended[src];
  src = indexOfExtended(_cols, -1);
  dst = indexOfNormal(0, _rows-1);
  buf[dst] += _extended[src];
}

void SDiffuser::diffuse4(float *buf, int cols, int rows, float percent)
{
  setupDiffuse(buf, cols, rows, 4);
  diffuse(percent);
  restoreExtended(buf);
}

void SDiffuser::diffuse8(float *buf, int cols, int rows, float percent)
{
  setupDiffuse(buf, cols, rows, 8);
  diffuse(percent);
  restoreExtended(buf);
}

void SDiffuser::printExtended() const
{
  if (_extended == NULL) {
    return;
  }
  for (int i = 0; i < _size; i ++) {
    printString(" ");
    printf(" %2.2f", _extended[i]);
    if (i % (_cols+2) == (_cols+2) - 1) {
      printString("\n");
    }
  }
  printString("\n");
}

void SDiffuser::printNeighbor() const
{
  printf("neighbor:");
  for (int i = 0; i < _neighborSize; i ++) {
    printf(" %d", neighbor[i]);
  }
  printf("\n");
}
