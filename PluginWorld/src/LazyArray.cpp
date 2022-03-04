#include <stdio.h>
#include <string.h>
#include "debug.h"
#include "LazyArray.h"

extern bool fCloseTo(float x, float y);
extern void error(const char *str);
extern void info(const char *str);
extern void printString(const char *str);
extern void printHex(int num);
extern void printInteger(int num);
extern void printFloat(float num);
extern void printSpaces(int num);

/*
 * LazyArray
 */

LazyArray::LazyArray()
{
  debug("LazyArray::LazyArray default");
  _array = NULL;
  _arrayClass = LA_None;
  _size = 0;
  _fixedSize = 0;
}

LazyArray::LazyArray(LazyArrayClassName arrayClass)
{
  debug("LazyArray::LazyArray arrayClass=%d", arrayClass);
  _array = NULL;
  _arrayClass = arrayClass;
  _size = 0;
  _fixedSize = 0;
}

LazyArray::~LazyArray()
{
  debug("LazyArray::~LazyArray");
  free();
}

void LazyArray::free()
{
  deleteArray();
  _array = NULL;
  _arrayClass = LA_None;
  _size = 0;
  _fixedSize = 0;
}

int LazyArray::size() const
{
  if (_fixedSize > 0) {
    return _fixedSize;
  }
  return _size;
}

void LazyArray::setArrayClass(LazyArrayClassName arrayClass)
{
  debug("LazyArray::setArrayClass arrayClass=%d", arrayClass);
  if (_arrayClass != LA_None) {
    debug("_arrayClass=%d", _arrayClass);
    error("LazyArray::setArrayClass already set class");
  }
  _arrayClass = arrayClass;
}

void LazyArray::print(int indent) const
{
  printSpaces(indent);
  printString("LazyArray(");
  switch (_arrayClass) {
  case LA_Float:
    printString("Float");
    break;
  case LA_Byte:
    printString("Byte");
    break;
  default:
    printString("Unknown");
    break;
  }
  printf(") _size=%d, _fixedSize=%d, _array=%p\n", _size, _fixedSize, _array);
}

void LazyArray::printValue(int index) const
{
  switch (_arrayClass) {
  case LA_Float:
    printFloat(getFloat(index));
    break;
  case LA_Byte:
    printHex(getByte(index));
    break;
  default:
    printString("<?>");
    break;
  }
}

void LazyArray::printValues(int w) const
{
  for (int i = 1; i <= _size; i ++) {
    printString(" ");
    printValue(i);
    if (i % w == 0) {
      printString("\n");
    }
  }
  printString("\n");
}

void LazyArray::setFloatArray(const float *list, int size)
{
  if (isOverFixedSize(size)) {
    debug("size=%d", size);
    error("LazyArray::setFloatArray fixed size over");
    return;
  }
  if (!isFloatArray()) {
    error("LazyArray::setFloatArray invalid type");
    return;
  }
  if (size > _size) {
    reallocateFloatArray(newSize(size - _size), false);
  }
  if (size > 0) {
    memcpy(_array, list, size * sizeof (float));
  }
}

void LazyArray::setByteArray(const u_int8_t *list, int size)
{
  if (isOverFixedSize(size)) {
    debug("size=%d", size);
    error("LazyArray::setByteArray fixed size over");
    return;
  }
  if (!isByteArray()) {
    error("LazyArray::setByteArray invalid type");
    return;
  }
  if (size > _size) {
    reallocateByteArray(newSize(size - _size), false);
  }
  if (size > 0) {
    memcpy(_array, list, size * sizeof (u_int8_t));
  }
}

float LazyArray::getFloat(int id) const
{
  if (isOverFixedSize(id)) {
    debug("id=%d", id);
    error("LazyArray::getFloat fixed size over");
    return 0;
  }
  if (!isFloatArray()) {
    error("LazyArray::getFloat invalid type");
    return 0;
  }
  if (id > _size) {
    return 0;
  }
  return ((float *) _array)[id - 1];
}

u_int8_t LazyArray::getByte(int id) const
{
  if (isOverFixedSize(id)) {
    debug("id=%d", id);
    error("LazyArray::getByte fixed size over");
    return 0;
  }
  if (!isByteArray()) {
    error("LazyArray::getByte invalid type");
    return 0;
  }
  if (id > _size) {
    return 0;
  }
  return ((u_int8_t *) _array)[id - 1];
}

void LazyArray::setFloat(int id, float value)
{
  if (isOverFixedSize(id)) {
    debug("id=%d", id);
    error("LazyArray::setFloat fixed size over");
    return;
  }
  if (!isFloatArray()) {
    error("LazyArray::setFloat invalid type");
    return;
  }
  if (id < 1) {
    error("LazyArray::setFloat invalid id");
    return;
  }
  if (id > _size) {
    if (fCloseTo(value, 0)) {
      return;
    }
    reallocateFloatArray(newSize(id - _size), true);
  }
  ((float *) _array)[id - 1] = value;
}

void LazyArray::setByte(int id, u_int8_t value)
{
  if (isOverFixedSize(id)) {
    debug("id=%d", id);
    error("LazyArray::setByte fixed size over");
    return;
  }
  if (!isByteArray()) {
    error("LazyArray::setByte invalid type");
    return;
  }
  if (id < 1) {
    error("LazyArray::setFloat invalid id");
    return;
  }
  if (id > _size) {
    if (value == 0) {
      return;
    }
    reallocateByteArray(newSize(id - _size), true);
  }
  ((u_int8_t *) _array)[id - 1] = value;
}

void LazyArray::forceSize(int size)
{
  if (size <= _fixedSize) {
    return;
  }
  reallocate(size, !isEmpty());
  _fixedSize = size;
}

void LazyArray::reset()
{
  if (isFixed()) {
    reallocate(_fixedSize, false);
  } else {
    deleteArray();
  }
}

void LazyArray::deleteArray()
{
  if (_array == NULL) {
    return;
  }
  debug("LazyArray::deleteArray");
  switch (_arrayClass) {
  case LA_Float:
    delete[] (float *)_array;
    break;
  case LA_Byte:
    delete[] (u_int8_t *)_array;
    break;
  default:
    printString("_arrayClass=");
    printInteger((int) _arrayClass);
    printString("\n");
    error("LazyArray::deleteArray invalid _arrayClass");
    break;
  }
  _array = NULL;
  _size = 0;
  _fixedSize = 0;
}

void LazyArray::reallocate(int newSize, bool bCopyData)
{
  switch (_arrayClass) {
  case LA_None:
    break;
  case LA_Float:
    reallocateFloatArray(newSize, bCopyData);
    break;
  case LA_Byte:
    reallocateByteArray(newSize, bCopyData);
    break;
  default:
    printString("_arrayClass=");
    printInteger((int) _arrayClass);
    printString("\n");
    error("LazyArray::reallocate invalid _arrayClass");
    break;
  }
}

void LazyArray::reallocateFloatArray(int newSize, bool bCopyData)
{
  debug("LazyArray::reallocateFloatArray newSize=%d, bCopyData=%d", newSize, bCopyData);
  float *p = new float[newSize];
  if (newSize <= _size) {
    return;
  }
  if (bCopyData && _array && _size > 0) {
    float *org = (float *) _array;
    memcpy(p, org, _size * sizeof (float));
  }
  memset(&p[_size], 0, (newSize - _size) * sizeof (float));
  deleteArray();
  _array = (void *) p;
  _size = newSize;
}

void LazyArray::reallocateByteArray(int newSize, bool bCopyData)
{
  debug("LazyArray::reallocateByteArray newSize=%d, bCopyData=%d", newSize, bCopyData);
  u_int8_t *p = new u_int8_t[newSize];
  if (newSize <= _size) {
    return;
  }
  if (bCopyData && _array && _size > 0) {
    u_int8_t *org = (u_int8_t *) _array;
    memcpy(p, org, _size * sizeof (u_int8_t));
  }
  memset(&p[_size], 0, (newSize - _size) * sizeof (u_int8_t));
  deleteArray();
  _array = (void *) p;
  _size = newSize;
}

void LazyArray::fillFloat(float value)
{
  if (!isFloatArray()) {
    error("LazyArray::fillFloat invalid type");
    return;
  }
  if (isEmpty()) {
    return;
  }
  float *ptr = (float *) _array;
  for (int i = 0; i < _size; i ++) {
    *ptr++ = value;
  }
}

void LazyArray::fillByte(u_int8_t value)
{
  if (!isByteArray()) {
    error("LazyArray::fillByte invalid type");
    return;
  }
  if (isEmpty()) {
    return;
  }
  u_int8_t *ptr = (u_int8_t *) _array;
  for (int i = 0; i < _size; i ++) {
    *ptr++ = value;
  }
}

void LazyArray::changeBy(float val)
{
  if (!isFloatArray()) {
    error("LazyArray::changeBy invalid type");
    return;
  }
  if (isEmpty()) {
    return;
  }
  float *ptr = (float *) _array;
  for (int i = 0; i < _size; i ++) {
    *ptr++ += val;
  }
}

void LazyArray::multiplyBy(float mul)
{
  if (!isFloatArray()) {
    error("LazyArray::multiplyBy invalid type");
    return;
  }
  if (isEmpty()) {
    return;
  }
  float *ptr = (float *) _array;
  for (int i = 0; i < _size; i ++) {
    *ptr++ *= mul;
  }
}
