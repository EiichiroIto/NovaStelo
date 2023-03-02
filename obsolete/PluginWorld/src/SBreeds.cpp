#include <stdio.h>
#include <string.h>
#include <cstdlib>
#include <cmath>
#include "debug.h"
#include "SCommon.h"
#include "SVariables.h"
#include "SBreeds.h"

/*
 * SBreed
 */

SBreed::SBreed()
{
  debug("SBreed::SBreed");
  _varId = NULL;
  _variables = NULL; 
}

SBreed::~SBreed()
{
  debug("SBreed::~SBreed");
  if (_varId != NULL) {
    delete _varId;
  }
  if (_variables != NULL) {
    delete _variables;
  }
}

void SBreed::print(int indent) const
{
  //  if (_varId != NULL) {
  //    _varId->print();
  //  }
  if (_variables != NULL) {
    _variables->print(indent+2);
  }
}

VariableType SBreed::getType(int vno) const
{
  return _variables->getType(vno);
}

float SBreed::getFloat(int vno, int index) const
{
  return _variables->getFloat(vno, index);
}

const float *SBreed::getFloatAll(int vno) const
{
  return _variables->getFloatAll(vno);
}

void SBreed::setFloat(int vno, int index, float value)
{
  _variables->setFloat(vno, index, value);
}

void SBreed::setFloatAll(int vno, const float *buf, int count)
{
  _variables->setFloatAll(vno, buf, count);
}

u_int8_t SBreed::getByte(int vno, int index) const
{
  return _variables->getByte(vno, index);
}

const u_int8_t *SBreed::getByteAll(int vno) const
{
  return _variables->getByteAll(vno);
}

void SBreed::setByte(int vno, int index, u_int8_t value)
{
  _variables->setByte(vno, index, value);
}

void SBreed::setByteAll(int vno, const u_int8_t *buf, int count)
{
  _variables->setByteAll(vno, buf, count);
}

bool SBreed::getFlag(int vno, int bit, int index) const
{
  return _variables->getByte(vno, index) & (1 << bit);
}

void SBreed::setFlag(int vno, int bit, int index, bool value)
{
  u_int32_t v = _variables->getByte(vno, index);
  if (value) {
    v |= 1 << bit;
  } else {
    v &= ~(1 << bit);
  }
  _variables->setByte(vno, index, v);
}

bool SBreed::addVariable(int vno)
{
  if (!_varId->add(vno)) {
    return false;
  }
  _variables->updateVarId(_varId, vno);
  return true;
}

void SBreed::scaleColor(int vno, float from, float to, u_int8_t baseColor, int index)
{
  float value = getFloat(vno, index);
  u_int8_t color = SColorList::scale(value, from, to, baseColor);
  setColor(index, color);
}

/*
 * SObserver
 */

SObserver::SObserver()
{
  _varId = new SObserverVarId();
  _variables = new SVariables();
}

void SObserver::clear()
{
  debug("SObserver::clear");
  SObserverVarId *s = (SObserverVarId *)_varId;
  for (int vno = s->userDefinedId(); vno <= s->max(); vno ++ ) {
    if (s->isUsed(vno)) {
      _variables->fillFloat(vno, 0);
    }
  }
}

void SObserver::reset()
{
  info("SObserver::reset");
  _varId->reset();
}

VariableType SObserver::getType(int vno) const
{
  switch (vno) {
  case SObserverVarId::widthVarNo:
  case SObserverVarId::heightVarNo:
  case SObserverVarId::maxBreedVarNo:
  case SObserverVarId::ticksVarNo:
  case SObserverVarId::countAliveVarNo:
  case SObserverVarId::sizeVarNo:
  case SObserverVarId::maxVarNo:
    return VT_ComputedFloat;
  }
  return SBreed::getType(vno);
}

void SObserver::print(int indent) const
{
  printSpaces(indent);
  printf("Observer:\n");
  SBreed::print(indent);
}

void SObserver::printDetails() const
{
}

/*
 * SPatches
 */

SPatches::SPatches()
{
  _varId = new SPatchVarId();
  _variables = new SVariables();
  create(defaultOrder);
}

void SPatches::create(int order)
{
  debug("SPatches::create order=%d", order);
  _rows = _cols = order;
  _variables->setupVarId(_varId);
  clear();
}

void SPatches::clear()
{
  debug("SPatches::clear");
  _variables->forceSize(_rows * _cols);
  SPatchVarId *s = (SPatchVarId *)_varId;
  _variables->fillByte(s->colorVarNo, SColorList::black);
  for (int vno = s->userDefinedId(); vno <= s->max(); vno ++ ) {
    if (s->isUsed(vno)) {
      _variables->fillFloat(vno, 0);
    }
  }
}

void SPatches::reset()
{
  info("SPatches::reset");
  _varId->reset();
  create(defaultOrder);
}

void SPatches::print(int indent) const
{
  printSpaces(indent);
  printf("Patches rows=%d, cols=%d, defaultOrder=%d\n", _rows, _cols, defaultOrder);
  SBreed::print(indent);
}

void SPatches::printDetails() const
{
  _variables->printAllValues(_cols);
}

void SPatches::printScreen() const
{
  _variables->printValues(((SPatchVarId *)_varId)->screenVarNo, _cols);
}

int SPatches::indexAtPoint(float x, float y) const
{
  x = normalizeX(x);
  y = normalizeY(y);
  int index = (((int) floor(y) + (_cols / 2)) * _cols) + (int) floor(x) + (_rows / 2);
  while (index < 0) {
    index += size();
  }
  index %= size();
  return index + 1;
}

u_int8_t SPatches::getColor(int pno) const
{
  return _variables->getByte(((SPatchVarId *)_varId)->colorVarNo, pno);
}

void SPatches::setColor(int pno, u_int8_t color)
{
  _variables->setByte(((SPatchVarId *)_varId)->colorVarNo, pno, color);
}

void SPatches::setColor(float x, float y, u_int8_t color)
{
  int pno = indexAtPoint(x, y);
  setColor(pno, color);
}

float SPatches::getX(int pno) const
{
  return (float) (((pno - 1) % _cols) - (_cols / 2));
}

float SPatches::getY(int pno) const
{
  return (float) (((pno - 1) / _rows) - (_rows / 2));
}

float SPatches::normalizeX(float x) const
{
  x = fmodf(x, _cols);
  if (x >= (_cols / 2) ) {
    x -= _cols;
  }
  return x;
}

float SPatches::normalizeY(float y) const
{
  y = fmodf(y, _rows);
  if (y >= (_rows / 2) ) {
    y -= _rows;
  }
  return y;
}

void SPatches::initScreen()
{
  SPatchVarId *s = (SPatchVarId *)_varId;
  _variables->copyScreen(s->colorVarNo, s->screenVarNo);
}

void SPatches::setScreen(float x, float y, int color)
{
  int pno = indexAtPoint(x, y);
  _variables->setByte(((SPatchVarId *)_varId)->screenVarNo, pno, color);
}

const u_int8_t *SPatches::getScreen() const
{
  return _variables->getByteAll(((SPatchVarId *)_varId)->screenVarNo);
}

void SPatches::nsum4(int from, int to)
{
  const float *src = _variables->getFloatAll(from);
  float *dst = _variables->getFloatArray(to);
  _diffuser.nsum4(src, dst, _cols, _rows);
}

void SPatches::nsum8(int from, int to)
{
  const float *src = _variables->getFloatAll(from);
  float *dst = _variables->getFloatArray(to);
  _diffuser.nsum8(src, dst, _cols, _rows);
}

void SPatches::diffuse4(int vno, float percent)
{
  float *buf = _variables->getFloatArray(vno);
  _diffuser.diffuse4(buf, _cols, _rows, percent);
}

void SPatches::diffuse8(int vno, float percent)
{
  float *buf = _variables->getFloatArray(vno);
  _diffuser.diffuse8(buf, _cols, _rows, percent);
}

void SPatches::scaleColorAll(int vno, float from, float to, u_int8_t baseColor)
{
  for (int pno = 1; pno <= size(); pno ++) {
    scaleColor(vno, from, to, baseColor, pno);
  }
}

/*
 * STurtles
 */

STurtles::STurtles()
{
  _varId = new STurtleVarId();
  _variables = new SVariables();
  _variables->setupVarId(_varId);
  clear();
  _defaultColor = SColorList::random();
}

void STurtles::clear()
{
  STurtleVarId *s = (STurtleVarId *)_varId;
  _variables->fillByte(s->flagVarNo, 0);
  _defaultX = _defaultY = 0;
}

void STurtles::reset()
{
  info("STurtles::reset");
  _varId->reset();
  _variables->setupVarId(_varId);
  clear();
}

int STurtles::size() const
{
  return _variables->sizeOf(((STurtleVarId *)_varId)->flagVarNo);
}

void STurtles::print(int indent) const
{
  printSpaces(indent);
  printf("Turtles defaultSize=%d alive=%d\n", defaultSize, countAlive());
  SBreed::print(indent);
}

void STurtles::printDetails() const
{
  _variables->printAllValues(10);
}

void STurtles::printIndex(int tno) const
{
  _variables->printIndex(tno);
}

void STurtles::create(int num)
{
  debug("STurtles::create num=%d\n", num);
  int rest = num;
  if (rest < 1) {
    return;
  }
  for (int tno = 1; ; tno ++) {
    if (!getAlive(tno)) {
      setupTurtle(tno);
      rest --;
      if (rest == 0) {
        return;
      }
    }
  }
}

void STurtles::setupTurtle(int tno)
{
  setColor(tno, _defaultColor);
  setFlag(tno, 1 << ((STurtleVarId *)_varId)->aliveFlagNo);
  setX(tno, _defaultX);
  setY(tno, _defaultY);
  setHeading(tno, rand() % 360);
}

void STurtles::kill(int tno)
{
  SBreed::setFlag(((STurtleVarId *)_varId)->flagVarNo, ((STurtleVarId *)_varId)->aliveFlagNo, tno, false);
}

u_int8_t STurtles::getColor(int tno) const
{
  return _variables->getByte(((STurtleVarId *)_varId)->colorVarNo, tno);
}

bool STurtles::getAlive(int tno) const
{
  return SBreed::getFlag(((STurtleVarId *)_varId)->flagVarNo, ((STurtleVarId *)_varId)->aliveFlagNo, tno);
}

float STurtles::getX(int tno) const
{
  return _variables->getFloat(((STurtleVarId *)_varId)->xVarNo, tno);
}

float STurtles::getY(int tno) const
{
  return _variables->getFloat(((STurtleVarId *)_varId)->yVarNo, tno);
}

float STurtles::getHeading(int tno) const
{
  return _variables->getFloat(((STurtleVarId *)_varId)->headingVarNo, tno);
}

bool STurtles::getPenDown(int tno) const
{
  return getFlag(((STurtleVarId *)_varId)->flagVarNo, ((STurtleVarId *)_varId)->penDownFlagNo, tno);
}

void STurtles::getDelta(int tno, float *pdx, float *pdy) const
{
  float deg = getHeading(tno);
  float rad = deg_to_rad(deg);
  *pdx = cos(rad);
  *pdy = sin(rad);
}

void STurtles::setColor(int tno, u_int8_t c)
{
  _variables->setByte(((STurtleVarId *)_varId)->colorVarNo, tno, c);
}

void STurtles::setFlag(int tno, u_int32_t v)
{
  _variables->setByte(((STurtleVarId *)_varId)->flagVarNo, tno, v);
}

void STurtles::setX(int tno, float x)
{
  _variables->setFloat(((STurtleVarId *)_varId)->xVarNo, tno, x);
}

void STurtles::setY(int tno, float y)
{
  _variables->setFloat(((STurtleVarId *)_varId)->yVarNo, tno, y);
}

void STurtles::setHeading(int tno, float deg)
{
  deg = fmod(deg, 360);
  _variables->setFloat(((STurtleVarId *)_varId)->headingVarNo, tno, deg);
}

void STurtles::setPenDown(int tno, bool b)
{
  SBreed::setFlag(((STurtleVarId *)_varId)->flagVarNo, ((STurtleVarId *)_varId)->penDownFlagNo, tno, b);
}

int STurtles::countAlive() const
{
  int ret = 0;
  for (int tno = 1; tno <= size(); tno ++) {
    if (getAlive(tno)) {
      ret ++;
    }
  }
  return ret;
}

void STurtles::hatch(int tno)
{
  for (int i = 1; ; i ++) {
    if (!getAlive(i)) {
      setupTurtle(i);
      setColor(i, getColor(tno));
      setX(i, getX(tno));
      setY(i, getY(tno));
      setHeading(i, getHeading(tno));
      setPenDown(i, getPenDown(tno));
      return;
    }
  }
}

int STurtles::turtleAt(int x, int y, int exceptId) const
{
  for (int i = 1; i <= size(); i ++) {
    if (!getAlive(i)) {
      continue;
    }
    if (i == exceptId) {
      continue;
    }
    if ((int) getX(i) == x && (int) getY(i) == y) {
      return i;
    }
  }
  return 0;
}

void STurtles::setDefaultXY(float x, float y)
{
  _defaultX = x;
  _defaultY = y;
}
