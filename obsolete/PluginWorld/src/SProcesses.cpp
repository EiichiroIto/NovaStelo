#include <stdio.h>
#include <string.h>
#include <cstdlib>
#include <cmath>
#include <random>
#include "debug.h"
#include "SCommon.h"
#include "SVariables.h"
#include "SBreeds.h"
#include "SMicroWorld.h"
#include "SProcesses.h"

/*
 * SteloValue
 */
bool SteloValue::closeTo(SteloValue& x) const
{
  if (type() != x.type()) {
    return false;
  }
  switch (type()) {
  case SV_Float:
    return fCloseTo(floatValue(), x.floatValue());
  case SV_Symbol:
    return symbolValue() == x.symbolValue();
  }
  return false;
}

void SteloValue::print() const
{
  switch (type()) {
  case SV_Float:
    printf("Float(%.2f)", floatValue());
    break;
  case SV_Symbol:
    printf("Symbol(%d)", symbolValue());
    break;
  default:
    printf("Invalid(%d)", type());
    break;
  }
}

/*
 * SCode
 */
SCode::SCode()
{
  _code = NULL;
  _allocatedSize = 0;
  _size = 0;
}

SCode::~SCode()
{
  if (_code != NULL) {
    delete[] _code;
  }
}

void SCode::require(int more)
{
  if (_size + more < _allocatedSize) {
    return;
  }
  int newSize = ((_size + more + allocateUnit - 1) / allocateUnit) * allocateUnit;
  reallocate(newSize);
}

void SCode::reallocate(int size)
{
  debug("SCode::reallocate size=%d\n", size);
  u_int8_t *ptr = new u_int8_t[size];
  if (_code != NULL) {
    memcpy(ptr, _code, _size * sizeof (u_int8_t));
  }
  delete[] _code;
  _code = ptr;
  _allocatedSize = size;
}

void SCode::addByte(u_int8_t v)
{
  require(1);
  _code[_size++] = v;
}

void SCode::clear()
{
  _size = 0;
}

void SCode::print(int indent) const
{
  printSpaces(indent);
  printf("SCode size=%d allocatedSize=%d\n", _size, _allocatedSize);
  for (int i = 0; i < _size; i ++) {
    printSpaces(indent+2);
    printf("%d: %d\n", i, _code[i]);
  }
}

/*
 * SThread
 */
SThread::SThread(SMicroWorld& w)
{
  _world = &w;
  _sp = 0;
  _pc = 0;
  _isRunning = false;
  _isTerminated = false;
}

void SThread::forBreed(int bno, int index)
{
  _breedNo = bno;
  _index = index;
}

void SThread::code(const SCode& code)
{
  _code = code.contents();
  _codeSize = code.size();
}

void SThread::push(SteloValue v)
{
  if (_sp >= MAX_STACK) {
    error("SThread::push stack overflow");
  }
  _stack[_sp ++] = v;
}

SteloValue SThread::pop()
{
  if (_sp == 0) {
    print(0);
    error("SThread::pop stack underflow");
  }
  return _stack[-- _sp];
}

float SThread::popFloat()
{
  SteloValue v = pop();
  if (!v.isFloat()) {
    error("SThread::popFloat invalid float");
    v.print();
    return 0;
  }
  return v.floatValue();
}

u_int8_t SThread::popByte()
{
  SteloValue v = pop();
  if (!v.isFloat()) {
    error("SThread::popByte invalid float");
    v.print();
    return 0;
  }
  return v.byteValue();
}

bool SThread::popBool()
{
  SteloValue v = pop();
  if (!v.isFloat()) {
    error("SThread::popBool invalid float");
    v.print();
    return false;
  }
  return v.boolValue();
}

bool SThread::doOneCycle(int address)
{
  debug("SThread::doOneCycle index=%d start=%d\n", _index, address);
  _pc = address;
  start();
  do {
    if (_pc >= _codeSize) {
      stop();
      return false;
    }
    u_int8_t op = fetch();
    if (SS_push0 <= op && op <= SS_xyOf) {
      perform((SteloSymbol) op);
    } else {
      printf("SThread::doOneCycle pc=%d sp=%d op=%d\n", _pc, _sp, op);
      error("SThread::doOneCycle invalid symbol");
      stop();
      return false;
    }
  } while (isRunning());
  return false;
}

void SThread::print(int indent) const
{
  printSpaces(indent);
  printf("SThread pc=%d sp=%d isRunning=%s isTerminated=%s bno=%d index=%d codesize=%d\n",
         _pc, _sp, boolString(_isRunning), boolString(_isTerminated), _breedNo, _index, _codeSize);
}

/*
 * SEventCodes
 */
SEventCodes::SEventCodes()
{
  clear();
}

void SEventCodes::addAddress(int bno, int address)
{
  if (_count >= MAX_CODES) {
    error("SEventCodes::addAddress codes exceeds");
  }
  _breedNos[_count] = bno;
  _addresses[_count] = address;
  _count ++;
}

void SEventCodes::clear()
{
  _count = 0;
}

int SEventCodes::countBreed(int bno) const
{
  int sum = 0;
  for (int i = 0; i < _count; i ++) {
    if (_breedNos[i] == bno) {
      sum ++;
    }
  }
  return sum;
}

void SEventCodes::print(int indent) const
{
  printSpaces(indent);
  printf("SEventCodes %d codes\n", _count);
  for (int i = 0; i < _count; i ++) {
    printSpaces(indent+2);
    printf("bno=%d address=%d\n", _breedNos[i], _addresses[i]);
  }
}

/*
 * SProgram
 */

SProgram::SProgram()
{
  title = NULL;
}

SProgram::~SProgram()
{
  if (title) {
    delete[] title;
  }
}

void SProgram::setTitle(const char *str)
{
  if (title) {
    delete[] title;
  }
  title = new char[strlen(str) + 1];
  strcpy(title, str);
}

void SProgram::setCodes(const u_int8_t *codes, int size)
{
  _scode.clear();
  for (int i = 0; i < size; i ++) {
    _scode.addByte(codes[i]);
  }
}

SEventCodes& SProgram::forEvent(int eno)
{
  if (eno >= MAX_EVENTS) {
    error("SProgram::addCode eno exceeds");
  }
  return _events[eno-1];
}

void SProgram::addEntryPoint(int eno, int bno, int address)
{
  SEventCodes& eventCodes = forEvent(eno);
  eventCodes.addAddress(bno, address);
}

/*
 * SProgram
 */

void SProgram::clear()
{
  for (int i = 0; i < MAX_EVENTS; i ++) {
    _events[i].clear();
  }
}

void SProgram::print(int indent) const
{
  if (title) {
    printSpaces(indent);
    printf("Title=%s\n", title);
  }
  for (int i = 0; i < MAX_EVENTS; i ++ ) {
    if (_events[i].count() == 0) {
      continue;
    }
    printSpaces(indent);
    printf("EventId=%d\n", i+1);
    _events[i].print(indent+2);
  }
}

/*
 * SProcess
 */

SProcess::SProcess(SMicroWorld& w, SProgram& p) : _world(w), _program(p)
{
  _executionMode = EM_Idle;
}

void SProcess::setupEvent(int eno)
{
  _eventMask = 1 << (eno - 1);
}

bool SProcess::isActiveEvent(int eno)
{
  return (1 << (eno - 1)) & _eventMask;
}

void SProcess::setupRaisedEvents()
{
  _eventMask = _world.raisedEvents();
}

bool SProcess::doOneCycle()
{
  int count = 0;
  for (int bno = 1; bno <= MAX_BREEDS; bno ++) {
    if (!_world.isActiveBreed(bno)) {
      continue;
    }
    for (int eno = EventId::startupEventNo; eno <= EventId::maxEventNo; eno ++) {
      if (!isActiveEvent(eno)) {
	continue;
      }
      SEventCodes& eventCodes = _program.forEvent(eno);
      for (int i = 0; i < eventCodes.count(); i ++) {
	if (eventCodes.breedAt(i) != bno) {
	  continue;
	}
	int address = eventCodes.addressAt(i);
	for (int index = 1; index <= _world.size(bno); index ++) {
	  if (!_world.getAlive(bno, index)) {
	    continue;
	  }
	  if (executeThread(bno, index, address)) {
	    stop();
	    return false;
	  }
	  count ++;
	}
      }
    }
  }
  debug("count=%d\n", count);
  return false;
}

bool SProcess::executeThread(int bno, int index, int address)
{
  SThread thread(_world);
  thread.code(_program.getCodes());
  thread.forBreed(bno, index);
  thread.doOneCycle(address);
  if (thread.isRunning()) {
    error("SProcess::doOneCycle SS_yield should not be implemented");
  }
  return thread.isTerminated();
}

void SProcess::stop()
{
  _executionMode = EM_Idle;
}

void SProcess::startup()
{
  _executionMode = EM_Startup;
  setupEvent(EventId::startupEventNo);
}

void SProcess::setup()
{
  _executionMode = EM_Setup;
  setupEvent(EventId::setupEventNo);
}

void SProcess::loop()
{
  _executionMode = EM_Loop;
  setupEvent(EventId::loopEventNo);
}

void SProcess::single()
{
  _executionMode = EM_Single;
  setupEvent(EventId::singleEventNo);
}

bool SProcess::step()
{
  if (!isRunning()) {
    return false;
  }
  _world.clearRaisedEvents();
  while (doOneCycle()) {
  }
  if (!isRunning()) {
    return false;
  }
  if (_world.existsRaisedEvent()) {
    setupRaisedEvents();
  } else {
    switch (_executionMode) {
    case EM_Startup:
      setup();
      break;
    case EM_Setup:
      stop();
      break;
    case EM_Loop:
      loop();
      break;
    case EM_Single:
      stop();
      break;
    default:
      debug("_executionMode=%d\n", _executionMode);
      error("SProcess::step invalid exeutionMode");
      return false;
    }
  }
  return true;
}

void SProcess::print(int indent) const
{
  printSpaces(indent);
  printf("SProcess mode=%d\n", _executionMode);
}
