#ifndef _SMicroWorld_h_
#define _SMicroWorld_h_

class EventId : public SteloId {
 private:
  int defaultCount() const { return singleEventNo; }

 public:
  const static int startupEventNo = 1;
  const static int setupEventNo = 2;
  const static int loopEventNo = 3;
  const static int singleEventNo = 4;
  const static int maxEventNo = 32;
  void reset() { _max = singleEventNo; }
};

class SMicroWorld {
 private:
  BreedId _breedId;
  SBreed *_breeds[MAX_BREEDS];
  unsigned int _raisedEvents;
  int _ticks;
  std::mt19937 random;

  SBreed *breedAt(int bno) { return _breeds[bno-1]; }
  SObserver *observer() { return (SObserver *) _breeds[BreedId::observerBreedNo-1]; }
  SPatches *patches() { return (SPatches *) _breeds[BreedId::patchBreedNo-1]; }
  STurtles *turtleAt(int tno) {return (STurtles *) _breeds[tno-1]; }
  const SBreed *cBreedAt(int bno) const { return _breeds[bno-1]; }
  const SObserver *cObserver() const { return (SObserver *) _breeds[BreedId::observerBreedNo-1]; }
  const SPatches *cPatches() const { return (const SPatches *) _breeds[BreedId::patchBreedNo-1]; }
  const STurtles *cTurtleAt(int tno) const {return (const STurtles *) _breeds[tno-1]; }
  int getCols() const;
  int getRows() const;
  int countAlive(int bno) const;
  int maxVarNo(int bno) const;
  float patchVarHeading(int vno, float x, float y, float heading) const;

 public:
  SMicroWorld();
  void reset();
  void print(int indent) const;
  void printDetails() const;
  void printScreen() const;
  void printTurtle(int bno, int index) const;
  void createPatch(int order);
  void createTurtles(int bno, int num);
  void forward(int bno, int index, float step);
  const u_int8_t *getScreen();
  int size(int bno) const;
  int getAlive(int bno, int index) const;
  void setupBreed(int bno);
  void clearBreed(int bno);
  void clearTurtles();
  VariableType getType(int bno, int vno) const;
  float getFloat(int bno, int vno, int index) const;
  const float *getFloatAll(int bno, int vno) const;
  void setFloat(int bno, int vno, int index, float value);
  void setFloatAll(int bno, int vno, const float *buf, int count);
  u_int8_t getByte(int bno, int vno, int index) const;
  const u_int8_t *getByteAll(int bno, int vno) const;
  void setByte(int bno, int vno, int index, u_int8_t value);
  void setByteAll(int bno, int vno, const u_int8_t *buf, int count);
  u_int32_t getWord(int bno, int vno, int index) const;
  const u_int32_t *getWordAll(int bno, int vno) const;
  void setWord(int bno, int vno, int index, u_int32_t value);
  void setWordAll(int bno, int vno, const u_int32_t *buf, int count);
  void setHeading(int bno, int index, float deg);
  void setColor(int bno, int index, u_int8_t color);
  void getDelta(int bno, int index, float *pdx, float *pdy) const;
  void kill(int bno, int index);
  int indexAtPoint(float x, float y) const;
  bool isActiveBreed(int bno) const;
  bool addVariable(int bno, int vno);
  void clearRaisedEvents();
  void raiseEvent(int eno);
  bool existsRaisedEvent() const;
  unsigned int raisedEvents() const { return _raisedEvents; }
  void nsum4(int from, int to);
  void nsum8(int from, int to);
  void diffuse4(int vno, float percent);
  void diffuse8(int vno, float percent);
  void hatch(int bno, int index);
  int turtleAt(int bno, int x, int y, int exceptId) const;
  void copyVar(int bid, int vno1, int vno2);
  void changeBy(int bid, int vno, float val);
  void multiplyBy(int bid, int vno, float val);
  void scaleColor(int vno, int bno, float from, float to, u_int8_t baseColor, int index);
  float aimHighPatchVar(int vno, float x, float y, float heading) const;
  void setDefaultTurtleXY(int bno, float x, float y);
  void setRandomSeed(int seed);
  int randomFromTo(int from, int to);
};

#endif /* _SMicroWorld_h_ */

