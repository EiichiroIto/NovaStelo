#ifndef _SVariables_h_
#define _SVariables_h_

#include "LazyArray.h"

extern const char *variableTypeString[];

enum VariableType { VT_None=0, VT_Float, VT_Byte, VT_Word, VT_ComputedFloat };

class VarId : public SteloId {
 private:
  bool _inUse[MAX_VARIABLES];

 public:
  VarId();
  virtual ~VarId();
  void reset();
  bool add(int id);
  virtual VariableType classForVar(int id) const { return VT_Float; }
  void del(int vno);
  bool isUsed(int id) const;
  int userDefinedId() const { return defaultCount() + 1; }
  void print(int indent) const;
};

class SObserverVarId : public VarId {
 private:
  int defaultCount() const { return maxVarNo; }

 public:
  SObserverVarId();
  const static int widthVarNo = 1;
  const static int heightVarNo = 2;
  const static int maxBreedVarNo = 3;
  const static int ticksVarNo = 4;
  const static int countAliveVarNo = 5;
  const static int sizeVarNo = 6;
  const static int maxVarNo = 7;
};

class SPatchVarId : public VarId {
 private:
  int defaultCount() const { return yVarNo; }

 public:
  SPatchVarId();
  const static int colorVarNo = 1; /* do not modify */
  const static int screenVarNo = 2;
  const static int xVarNo = 3;
  const static int yVarNo = 4;
  VariableType classForVar(int id) const override;
};

class STurtleVarId : public VarId {
 private:
  int defaultCount() const { return headingVarNo; }

 public:
  STurtleVarId();
  const static int colorVarNo = 1; /* do not modify */
  const static int flagVarNo = 2;
  const static int xVarNo = 3;
  const static int yVarNo = 4;
  const static int headingVarNo = 5;
  const static int aliveFlagNo = 0;
  const static int penDownFlagNo = 1;
  VariableType classForVar(int id) const override;
};

class SVariables {
 private:
  VariableType _varType[MAX_VARIABLES];
  LazyArray _var[MAX_VARIABLES];
  const char *_varName[MAX_VARIABLES];

  void free(int vno);
  LazyArray& varAt(int vno) { return _var[vno - 1]; }
  const LazyArray& cVarAt(int vno) const { return _var[vno - 1]; }
  void setType(int vno, VariableType t) { _varType[vno-1] = t; }
  void resetBase(int vno) { _varType[vno-1] = VT_None; varAt(vno).free(); }
  void printValue(int vno, int index) const;

 public:
  SVariables();
  ~SVariables();
  void forceSize(int size);
  int sizeOf(int vno) const { return cVarAt(vno).size(); }
  void free();
  bool isAllocated(int vno) const { return _varType[vno-1] != VT_None; }
  void setupVarId(const VarId *aVarId);
  bool updateVarId(const VarId *aVarId, int vno);
  void allocateMore(int more);
  VariableType getType(int vno) const { return _varType[vno-1]; }
  bool isFloatArray(int vno) const { return getType(vno) == VT_Float; }
  bool isByteArray(int vno) const { return getType(vno) == VT_Byte; }
  float getFloat(int vno, int index) const;
  const float *getFloatAll(int vno) const;
  float *getFloatArray(int vno);
  void setFloat(int vno, int index, float value);
  void setFloatAll(int vno, const float *buf, int count);
  void fillFloat(int vno, float value);
  u_int8_t getByte(int vno, int index) const;
  const u_int8_t *getByteAll(int vno) const;
  void setByte(int vno, int index, u_int8_t value);
  void setByteAll(int vno, const u_int8_t *buf, int count);
  void fillByte(int vno, u_int8_t value);
  u_int32_t getWord(int vno, int index) const;
  const u_int32_t *getWordAll(int vno) const;
  void setWord(int vno, int index, u_int32_t value);
  void setWordAll(int vno, const u_int32_t *buf, int count);
  void fillWord(int vno, u_int32_t value);
  const u_int8_t *getColors() const;
  void print(int indent) const;
  void printValues(int vno, int w) const;
  void printAllValues(int w) const;
  void printIndex(int index) const;
  int elementSize(int vno) const;
  void copyScreen(int from, int to);
  void copyVar(int from, int to);
  void changeBy(int vno, float val);
  void multiplyBy(int vno, float val);
};

#endif /* _SVariables_h_ */

