#ifndef _SBreeds_h_
#define _SBreeds_h_

#include "SDiffuser.h"

class BreedId : public SteloId {
 private:
  int defaultCount() const { return patchBreedNo; }

 public:
  const static int observerBreedNo = 1;
  const static int patchBreedNo = 2;
  const static int turtleBreedNo = 3;
  void reset() { _max = patchBreedNo; }
};

class SBreed {
 protected:
  VarId *_varId;
  SVariables *_variables;

 public:
  SBreed();
  virtual ~SBreed();
  virtual void print(int indent) const;
  virtual void printDetails() const = 0;
  virtual void clear() = 0;
  virtual void reset() = 0;
  virtual int countAlive() const = 0;
  virtual int size() const = 0;
  virtual bool getAlive(int index) const = 0;
  virtual VariableType getType(int vno) const;
  float getFloat(int vno, int index) const;
  const float *getFloatAll(int vno) const;
  void setFloat(int vno, int index, float value);
  void setFloatAll(int vno, const float *buf, int count);
  u_int8_t getByte(int vno, int index) const;
  const u_int8_t *getByteAll(int vno) const;
  void setByte(int vno, int index, u_int8_t value);
  void setByteAll(int vno, const u_int8_t *buf, int count);
  u_int32_t getWord(int vno, int index) const;
  const u_int32_t *getWordAll(int vno) const;
  void setWord(int vno, int index, u_int32_t value);
  void setWordAll(int vno, const u_int32_t *buf, int count);
  bool getFlag(int vno, int bit, int index) const;
  void setFlag(int vno, int bit, int index, bool value);
  virtual u_int8_t getColor(int index) const = 0;
  virtual void setColor(int index, u_int8_t color) = 0;
  bool addVariable(int vno);
  void scaleColor(int vno, float from, float to, u_int8_t baseColor, int index);
  int maxVarNo() const { return _varId->max(); }
  void copyVar(int vno1, int vno2) { _variables->copyVar(vno1, vno2); }
  void changeBy(int vno, float val) { _variables->changeBy(vno, val); }
  void multiplyBy(int vno, float val) { _variables->multiplyBy(vno, val); }
};

class SMicroWorld;

class SObserver : public SBreed {
 private:
  SMicroWorld *sworld;
 public:
  SObserver();
  void clear();
  void reset();
  void print(int indent) const;
  void printDetails() const;
  int size() const { return 1; }
  int countAlive() const { return 1; }
  bool getAlive(int index) const { return true; };
  VariableType getType(int vno) const;
  u_int8_t getColor(int index) const { return 0; };
  void setColor(int index, u_int8_t color) {};
  void setMicroWorld(SMicroWorld *w) { sworld = w; };
};

class SPatches : public SBreed {
 private:
  int _cols;
  int _rows;
  const int defaultOrder = 6;
  SDiffuser _diffuser;

 public:
  SPatches();
  void create(int count);
  void clear();
  void reset();
  void print(int indent) const;
  void printDetails() const;
  void printScreen() const;
  int indexAtPoint(float x, float y) const;
  u_int8_t getColor(int index) const;
  void setColor(int index, u_int8_t color);
  void setColor(float x, float y, u_int8_t color);
  float getX(int index) const;
  float getY(int index) const;
  float normalizeX(float x) const;
  float normalizeY(float y) const;
  int size() const { return _rows * _cols; }
  int countAlive() const { return size(); }
  bool getAlive(int index) const { return index > 0 && index <= size(); };
  void initScreen();
  void setScreen(float x, float y, int color);
  const u_int8_t *getScreen() const;
  int getCols() const { return _cols; }
  int getRows() const { return _rows; }
  void nsum4(int from, int to);
  void nsum8(int from, int to);
  void diffuse4(int vno, float percent);
  void diffuse8(int vno, float percent);
  void scaleColorAll(int vno, float from, float to, u_int8_t baseColor);
};

class STurtles : public SBreed {
 private:
  int _defaultColor;
  float _defaultX;
  float _defaultY;
  const int defaultSize = 100;

 public:
  STurtles();
  void clear();
  void reset();
  int size() const;
  void print(int indent) const;
  void printDetails() const;
  void printIndex(int index) const;
  void create(int num);
  void setupTurtle(int index);
  void kill(int index);
  bool getAlive(int index) const;
  u_int8_t getColor(int index) const;
  float getX(int index) const;
  float getY(int index) const;
  float getHeading(int index) const;
  bool getPenDown(int index) const;
  void getDelta(int index, float *pdx, float *pdy) const;
  void setColor(int index, u_int8_t c);
  void setFlag(int index, u_int32_t v);
  void setX(int index, float x);
  void setY(int index, float y);
  void setHeading(int index, float deg);
  void setPenDown(int index, bool b);
  int countAlive() const;
  void hatch(int index);
  int turtleAt(int x, int y, int exceptId) const;
  void setDefaultXY(float x, float y);
};

#endif /* _SBreeds_h_ */

