#ifndef _SProcesses_h_
#define _SProcesses_h_

#define MAX_EVENTS 10
#define MAX_CODES 10
#define MAX_STACK 100

#include "symbols.h"

class SteloValue {
 private:
  enum SteloValueType { SV_None = 0, SV_Float, SV_Symbol } _type ;
  union {
    float _vFloat;
    SteloSymbol _vSymbol;
  };

 public:
  SteloValue() { _type = SV_None; }
  SteloValue(float v) { _type = SV_Float; _vFloat = v; }
  SteloValue(u_int8_t v) { _type = SV_Float; _vFloat = (float) v; }
  SteloValue(bool v) { _type = SV_Float; _vFloat = v ? 1.0 : 0.0; }
  SteloValue(SteloSymbol v) { _type = SV_Symbol; _vSymbol = v; }
  SteloValueType type() const { return _type; }
  bool closeTo(SteloValue& v) const;
  bool isFloat() const { return _type == SV_Float; }
  bool isSymbol() const { return _type == SV_Symbol; }
  bool isSymbol(SteloSymbol x) const { return isSymbol() && _vSymbol == x; }
  float floatValue() const { return _vFloat; }
  u_int8_t byteValue() const { return (u_int8_t) _vFloat; }
  bool boolValue() const { return !fCloseTo(_vFloat, 0.0); }
  SteloSymbol symbolValue() const { return _vSymbol; }
  void print() const;
};

class SCode {
 private:
  u_int8_t *_code;
  int _allocatedSize;
  int _size;
  void require(int more);
  void reallocate(int size);
  const int allocateUnit = 10;

 public:
  SCode();
  ~SCode();
  void addByte(u_int8_t v);
  void clear();
  void print(int indent) const;
  const u_int8_t *contents() const { return _code; }
  const int size() const { return _size; }
};

class SThread {
 private:
  SMicroWorld *_world;
  SteloValue _stack[MAX_STACK];
  int _sp;
  int _pc;
  float _retVal;
  bool _isRunning;
  bool _isTerminated;
  int _breedNo;
  int _index;
  const u_int8_t *_code;
  int _codeSize;

  u_int8_t fetch() { return _code[_pc++]; }
  void push(SteloValue v);
  void pushFloat(float x) { push(SteloValue(x)); }
  void pushByte(u_int8_t x) { push(SteloValue(x)); }
  void pushBool(bool x) { push(SteloValue(x)); }
  SteloValue pop();
  float popFloat();
  bool popBool();
  u_int8_t popByte();
  SteloValue getVar(int bid, int var, int index) const;
  void setVar(int bid, int var, int index, SteloValue val);
  void perform(SteloSymbol s);

 public:
  SThread(SMicroWorld& w);
  void forBreed(int bid, int index);
  void code(const SCode& code);
  bool doOneCycle(int address);
  void print(int indent) const;
  bool isRunning() const { return _isRunning; }
  bool isTerminated() const { return _isTerminated; }
  void start() { _isRunning = true; }
  void stop() { _isRunning = false; }
  void terminate() { stop(); _isTerminated = true; }
};

class SEventCodes {
 private:
  int _addresses[MAX_CODES];
  int _breedNos[MAX_CODES];
  int _count;

 public:
  SEventCodes();
  void clear();
  int count() const { return _count; }
  int countBreed(int bid) const;
  void addAddress(int bno, int address);
  int addressAt(int index) const { return _addresses[index]; }
  int breedAt(int index) const { return _breedNos[index]; }
  void print(int indent) const;
};

class SProgram {
 private:
  SCode _scode;
  SEventCodes _events[MAX_EVENTS];
  char *title;

 public:
  SProgram();
  ~SProgram();
  void setTitle(const char *str);
  const char *getTitle() const { return title; }
  void setCodes(const u_int8_t *codes, int size);
  const SCode& getCodes() const { return _scode; };
  SEventCodes& forEvent(int eno);
  void addEntryPoint(int eno, int bno, int address);
  void clear();
  void print(int indent) const;
};

class SProcess {
  enum ExecutionMode { EM_Idle = 0, EM_Startup, EM_Setup, EM_Loop, EM_Single };

 private:
  SMicroWorld& _world;
  SProgram& _program;
  ExecutionMode _executionMode;
  unsigned int _eventMask;

  bool doOneCycle();
  bool executeThread(int bno, int index, int address);
  void setupEvent(int eno);
  bool isActiveEvent(int eno);
  void setupRaisedEvents();
  void setup();

 public:
  SProcess(SMicroWorld& w, SProgram& p);
  void stop();
  void startup();
  void loop();
  void single();
  bool step();
  void print(int indent) const;
  bool isRunning() const { return _executionMode != EM_Idle; }
};

#endif /* _SProcesses_h_ */

