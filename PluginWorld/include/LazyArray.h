#ifndef _LazyArray_h_
#define _LazyArray_h_

#ifndef u_int8_t
typedef unsigned char u_int8_t;
typedef unsigned int u_int32_t;
#endif /* u_int8_t */

enum LazyArrayClassName { LA_None = 0, LA_Float, LA_Byte };

class LazyArray {
 private:
  void *_array;
  LazyArrayClassName _arrayClass;
  int _size;
  int _fixedSize;

  const int allocateStep = 100;

  int newSize(int more) const { return ((_size + more + allocateStep - 1) / allocateStep) * allocateStep; }
  void deleteArray();
  void reallocate(int newSize, bool bCopyData);
  void reallocateFloatArray(int newSize, bool bCopyData);
  void reallocateByteArray(int newSize, bool bCopyData);

 public:
  LazyArray();
  LazyArray(LazyArrayClassName arrayClass);
  ~LazyArray();

  void free();
  void setArrayClass(LazyArrayClassName arrayClass);
  bool isEmpty() const { return _size == 0; }
  bool isFixed() const { return _fixedSize > 0; }
  bool isFloatArray() const { return _arrayClass == LA_Float; }
  bool isByteArray() const { return _arrayClass == LA_Byte; }
  bool isOverFixedSize(int size) const { return isFixed() && size > _fixedSize; }
  int size() const;
  int fixedSize() const { return _fixedSize; }
  void print(int indent) const;
  void printValue(int index) const;
  void printValues(int w) const;
  float *getFloatArray() { return (float *) _array; }
  const float *cGetFloatArray() const { return (const float *) _array; }
  void setFloatArray(const float *list, int size);
  const u_int8_t *getByteArray() const { return (const u_int8_t *) _array; }
  void setByteArray(const u_int8_t *list, int size);
  float getFloat(int id) const;
  u_int8_t getByte(int id) const;
  void setFloat(int id, float value);
  void fillFloat(float value);
  void setByte(int id, u_int8_t value);
  void fillByte(u_int8_t value);
  void forceSize(int size);
  void reset();
  void changeBy(float val);
  void multiplyBy(float mul);
};

#endif /* _LazyArray_h_ */
