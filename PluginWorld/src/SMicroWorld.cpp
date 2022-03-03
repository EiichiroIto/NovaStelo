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

/*
 * SMicroWorld
 */

SMicroWorld::SMicroWorld()
{
  _raisedEvents = 0;
  for (int i = 0; i < MAX_BREEDS; i ++) {
    _breeds[i] = NULL;
  }
  SObserver *o = new SObserver;
  o->setMicroWorld(this);
  _breeds[BreedId::observerBreedNo - 1] = o;
  SPatches *ps = new SPatches;
  _breeds[BreedId::patchBreedNo - 1] = ps;
  reset();
  std::random_device rd;
  random.seed(rd());
}

void SMicroWorld::reset()
{
  observer()->reset();
  patches()->reset();
  for (int tno = BreedId::turtleBreedNo; tno <= MAX_BREEDS; tno ++) {
    STurtles *ts = turtleAt(tno);
    if (ts != NULL) {
      delete ts;
      _breeds[tno-1] = NULL;
    }
  }
  _breedId.reset();
  _ticks = 0;
}

void SMicroWorld::print(int indent) const
{
  printSpaces(indent);
  printf("MicroWorld\n");
  _breedId.print(indent+2);
  for (int bno = 1; bno <= MAX_BREEDS; bno ++) {
    const SBreed *breed = cBreedAt(bno);
    if (breed == NULL) {
      continue;
    }
    printSpaces(indent+2);
    printf("bno=%d\n", bno);
    breed->print(indent+4);
  }
}

void SMicroWorld::printDetails() const
{
  for (int bno = 1; bno <= MAX_BREEDS; bno ++) {
    const SBreed *breed = cBreedAt(bno);
    if (breed == NULL) {
      continue;
    }
    breed->printDetails();
  }
}

void SMicroWorld::printScreen() const
{
  cPatches()->printScreen();
}

void SMicroWorld::printTurtle(int bno, int tno) const
{
  cTurtleAt(bno)->printIndex(tno);
}

void SMicroWorld::createPatch(int order)
{
  for (int bno = BreedId::turtleBreedNo; bno <= MAX_BREEDS; bno ++) {
    STurtles *ts = turtleAt(bno);
    if (ts == NULL) {
      continue;
    }
    ts->clear();
  }
  patches()->create(order);
}

void SMicroWorld::createTurtles(int bno, int num)
{
  debug("SMicroWorld::createTurtles bno=%d num=%d\n", bno, num);
  if (bno < BreedId::turtleBreedNo) {
    error("SMicroWorld::createTurtles breedId must be more than 2");
    return;
  }
  STurtles *ts = turtleAt(bno);
  if (ts == NULL) {
    error("SMicroWorld::createTurtles invalid breedId");
    return;
  }
  ts->create(num);
}

void SMicroWorld::forward(int bno, int tno, float step)
{
  if (bno < BreedId::turtleBreedNo) {
    error("SMicroWorld::forward invalid bno");
    return;
  }
  if (tno < 1 || tno > size(bno)) {
    error("SMicroWorld::forward invalid index");
    return;
  }
  SPatches *ps = patches();
  STurtles *ts = turtleAt(bno);
  bool penDown = ts->getPenDown(tno);
  u_int8_t c = ts->getColor(tno);
  float x = ts->getX(tno);
  float y = ts->getY(tno);
  float dx, dy;
  ts->getDelta(tno, &dx, &dy);
  for (int i = 0; i < (int) step; i ++) {
    if (penDown) {
      ps->setColor(x, y, c);
    }
    x += dx;
    y += dy;
    x = ps->normalizeX(x);
    y = ps->normalizeY(y);
  }
  if (penDown) {
    ps->setColor(x, y, c);
  }
  float rest = step - (int) step;
  if (!fCloseTo(rest, 0)) {
    x += rest * dx;
    y += rest * dy;
    x = ps->normalizeX(x);
    y = ps->normalizeY(y);
  }
  ts->setX(tno, x);
  ts->setY(tno, y);
}

const u_int8_t *SMicroWorld::getScreen()
{
  SPatches *ps = patches();
  if (ps == NULL) {
    error("SMicroWorld::getScreen patch is NULL");
  }
  ps->initScreen();
  for (int bno = BreedId::turtleBreedNo; bno <= MAX_BREEDS; bno ++) {
    STurtles *ts = turtleAt(bno);
    if (ts == NULL) {
      continue;
    }
    for (int i = 1; i <= ts->size(); i ++) {
      if (ts->getAlive(i)) {
        float x = ts->getX(i);
        float y = ts->getY(i);
        u_int8_t c = ts->getColor(i);
        ps->setScreen(x, y, c);
      }
    }
  }
  return (const u_int8_t*) ps->getScreen();
}

int SMicroWorld::getCols() const
{
  return cPatches()->getCols();
}

int SMicroWorld::getRows() const
{
  return cPatches()->getRows();
}

int SMicroWorld::countAlive(int bno) const
{
  const SBreed *breed = cBreedAt(bno);
  if (breed == NULL) {
    return 0;
  }
  return breed->countAlive();
}

int SMicroWorld::size(int bno) const
{
  const SBreed *breed = cBreedAt(bno);
  if (breed == NULL) {
    return 0;
  }
  return breed->size();
}

int SMicroWorld::maxVarNo(int bno) const
{
  const SBreed *breed = cBreedAt(bno);
  if (breed == NULL) {
    return 0;
  }
  return breed->maxVarNo();
}

int SMicroWorld::getAlive(int bno, int tno) const
{
  const SBreed *breed = cBreedAt(bno);
  if (breed == NULL) {
    return 0;
  }
  return breed->getAlive(tno);
}

void SMicroWorld::setupBreed(int bno)
{
  if (bno == BreedId::observerBreedNo) {
    return;
  } else if (bno == BreedId::patchBreedNo) {
    return;
  }
  if (breedAt(bno) != NULL) {
    debug("bno=%d\n", bno);
    error("SMicroWorld::setupBreed invalid bno");
    return;
  }
  _breedId.updateId(bno);
  STurtles *ts = new STurtles;
  _breeds[bno-1] = ts;
}

void SMicroWorld::clearBreed(int bno)
{
  SBreed *breed = breedAt(bno);
  if (breed == NULL) {
    return;
  }
  breed->clear();
}

void SMicroWorld::clearTurtles()
{
  for (int bno = BreedId::turtleBreedNo; bno <= MAX_BREEDS; bno ++) {
    clearBreed(bno);
  }
}

VariableType SMicroWorld::getType(int bno, int vno) const
{
  const SBreed *bs = cBreedAt(bno);
  if (bs == NULL) {
    error("SMicroWorld::getType invalid bno");
    return VT_None;
  }
  return bs->getType(vno);
}

float SMicroWorld::getFloat(int bno, int vno, int index) const
{
  if (bno == BreedId::observerBreedNo) {
    switch (vno) {
    case SObserverVarId::widthVarNo:
      return getCols();
    case SObserverVarId::heightVarNo:
      return getRows();
    case SObserverVarId::maxBreedVarNo:
      return _breedId.max();
    case SObserverVarId::ticksVarNo:
      return _ticks;
    case SObserverVarId::countAliveVarNo:
      return countAlive(index);
    case SObserverVarId::sizeVarNo:
      return size(index);
    case SObserverVarId::maxVarNo:
      return maxVarNo(index);
    default:
      return cObserver()->getFloat(vno, index);
    }
  } else if (bno == BreedId::patchBreedNo) {
    switch (vno) {
    case SPatchVarId::colorVarNo:
      return (float) cPatches()->getColor(index);
    case SPatchVarId::xVarNo:
      return cPatches()->getX(index);
    case SPatchVarId::yVarNo:
      return cPatches()->getY(index);
    default:
      return cPatches()->getFloat(vno, index);
    }
  } else {
    const STurtles *ts = cTurtleAt(bno);
    if (ts == NULL) {
      error("SMicroWorld::getFloat invalid bno");
      return 0;
    }
    return ts->getFloat(vno, index);
  }
}

const float *SMicroWorld::getFloatAll(int bno, int vno) const
{
  debug("SMicroWorld::getFloatAll(%d,%d)\n", bno, vno);
  const SBreed *breed = cBreedAt(bno);
  if (breed == NULL) {
    error("SMicroWorld::getFloatAll invalid bno");
    return NULL;
  }
  return breed->getFloatAll(vno);
}

void SMicroWorld::setFloat(int bno, int vno, int index, float value)
{
  debug("SMicroWorld::setFloat(%d,%d,%d,%f)\n", bno, vno, index, value);
  if (bno == BreedId::observerBreedNo) {
    switch (vno) {
    case SObserverVarId::widthVarNo:
    case SObserverVarId::heightVarNo:
    case SObserverVarId::maxBreedVarNo:
    case SObserverVarId::countAliveVarNo:
    case SObserverVarId::sizeVarNo:
    case SObserverVarId::maxVarNo:
      break;
    case SObserverVarId::ticksVarNo:
      _ticks = (int) value;
      break;
    default:
      observer()->setFloat(vno, index, value);
      break;
    }
    return;
  } else if (bno == BreedId::patchBreedNo) {
    patches()->setFloat(vno, index, value);
  } else {
    STurtles *ts = turtleAt(bno);
    if (ts == NULL) {
      error("SMicroWorld::setFloat invalid bno");
      return;
    }
    ts->setFloat(vno, index, value);
  }
}

void SMicroWorld::setFloatAll(int bno, int vno, const float *buf, int count)
{
  SBreed *breed = breedAt(bno);
  if (breed == NULL) {
    error("SMicroWorld::setFloatAll invalid bno");
    return;
  }
  breed->setFloatAll(vno, buf, count);
}

u_int8_t SMicroWorld::getByte(int bno, int vno, int index) const
{
  const SBreed *breed = cBreedAt(bno);
  if (breed == NULL) {
    error("SMicroWorld::getByte invalid bno");
    return 0;
  }
  return breed->getByte(vno, index);
}

const u_int8_t *SMicroWorld::getByteAll(int bno, int vno) const
{
  const SBreed *breed = cBreedAt(bno);
  if (breed == NULL) {
    error("SMicroWorld::getByteAll invalid bno");
    return NULL;
  }
  return breed->getByteAll(vno);
}

void SMicroWorld::setByte(int bno, int vno, int index, u_int8_t value)
{
  SBreed *breed = breedAt(bno);
  if (breed == NULL) {
    error("SMicroWorld::setByte invalid bno");
    return;
  }
  breed->setByte(vno, index, value);
}

void SMicroWorld::setByteAll(int bno, int vno, const u_int8_t *buf, int count)
{
  SBreed *breed = breedAt(bno);
  if (breed == NULL) {
    error("SMicroWorld::setByteAll invalid bno");
    return;
  }
  breed->setByteAll(vno, buf, count);
}

void SMicroWorld::setHeading(int bno, int tno, float deg)
{
  if (bno < BreedId::turtleBreedNo) {
    error("SMicroWorld::setHeading must be a turtle");
    return;
  }
  STurtles *ts = turtleAt(bno);
  if (ts == NULL) {
    error("SMicroWorld::setHeading invalid bno");
  }
  ts->setHeading(tno, deg);
}

void SMicroWorld::setColor(int bno, int index, u_int8_t color)
{
  if (bno == BreedId::observerBreedNo) {
    error("SMicroWorld::setHeading must be a turtle or a patch");
    return;
  }
  SBreed *breed = breedAt(bno);
  if (breed == NULL) {
    error("SMicroWorld::setColor invalid bno");
  }
  breed->setColor(index, color);
}

void SMicroWorld::getDelta(int bno, int index, float *pdx, float *pdy) const
{
  if (bno < BreedId::turtleBreedNo) {
    error("SMicroWorld::getDelta must be a turtle");
  }
  const STurtles *ts = cTurtleAt(bno);
  if (ts == NULL) {
    error("SMicroWorld::getDelta invalid bno");
  }
  ts->getDelta(index, pdx, pdy);
}

void SMicroWorld::kill(int bno, int tno)
{
  if (bno < BreedId::turtleBreedNo) {
    error("SMicroWorld::kill must be a turtle");
  }
  STurtles *ts = turtleAt(bno);
  if (ts == NULL) {
    error("SMicroWorld::kill invalid bno");
  }
  ts->kill(tno);
}

int SMicroWorld::indexAtPoint(float x, float y) const
{
  return cPatches()->indexAtPoint(x, y);
}

bool SMicroWorld::isActiveBreed(int bno) const
{
  return cBreedAt(bno) != NULL;
}

bool SMicroWorld::addVariable(int bno, int vno)
{
  return breedAt(bno)->addVariable(vno);
}

void SMicroWorld::clearRaisedEvents()
{
  _raisedEvents = 0;
}

void SMicroWorld::raiseEvent(int eno)
{
  debug("SMicroWorld::raiseEvent eno=%d\n", eno);
  _raisedEvents |= 1 << (eno - 1);
}

bool SMicroWorld::existsRaisedEvent() const
{
  return _raisedEvents != 0;
}

void SMicroWorld::nsum4(int from, int to)
{
  patches()->nsum4(from, to);
}

void SMicroWorld::nsum8(int from, int to)
{
  patches()->nsum8(from, to);
}

void SMicroWorld::diffuse4(int vno, float percent)
{
  patches()->diffuse4(vno, percent);
}

void SMicroWorld::diffuse8(int vno, float percent)
{
  patches()->diffuse8(vno, percent);
}

void SMicroWorld::hatch(int bno, int tno)
{
  if (bno < BreedId::turtleBreedNo) {
    error("SMicroWorld::hatch must be a turtle");
  }
  STurtles *ts = turtleAt(bno);
  if (ts == NULL) {
    error("SMicroWorld::hatch invalid bno");
  }
  ts->hatch(tno);
}

int SMicroWorld::turtleAt(int bno, int x, int y, int exceptId) const
{
  if (bno < BreedId::turtleBreedNo) {
    error("SMicroWorld::turtleAt must be a turtle");
  }
  const STurtles *ts = cTurtleAt(bno);
  if (ts == NULL) {
    error("SMicroWorld::turtleAt invalid bno");
  }
  return ts->turtleAt(x, y, exceptId);
}

void SMicroWorld::copyVar(int bno, int vno1, int vno2)
{
  if (bno < BreedId::patchBreedNo) {
    error("SMicroWorld::copyVar invalid bno");
  } else if (bno == BreedId::patchBreedNo) {
    patches()->copyVar(vno1, vno2);
    return;
  }
  STurtles *ts = turtleAt(bno);
  if (ts == NULL) {
    error("SMicroWorld::copyVar invalid bno");
  }
  ts->copyVar(vno1, vno2);
}

void SMicroWorld::changeBy(int bno, int vno, float val)
{
  if (bno < BreedId::patchBreedNo) {
    error("SMicroWorld::changeBy invalid bno");
  } else if (bno == BreedId::patchBreedNo) {
    patches()->changeBy(vno, val);
    return;
  }
  STurtles *ts = turtleAt(bno);
  if (ts == NULL) {
    error("SMicroWorld::changeBy invalid bno");
  }
  ts->changeBy(vno, val);
}

void SMicroWorld::multiplyBy(int bno, int vno, float val)
{
  if (bno < BreedId::patchBreedNo) {
    error("SMicroWorld::multiplyBy invalid bno");
  } else if (bno == BreedId::patchBreedNo) {
    patches()->multiplyBy(vno, val);
    return;
  }
  STurtles *ts = turtleAt(bno);
  if (ts == NULL) {
    error("SMicroWorld::multiplyBy invalid bno");
  }
  ts->multiplyBy(vno, val);
}

void SMicroWorld::scaleColor(int vno, int bno, float from, float to, u_int8_t color, int index)
{
  if (bno == BreedId::observerBreedNo) {
    patches()->scaleColorAll(vno, from, to, color);
  } else if (bno == BreedId::patchBreedNo) {
    patches()->scaleColor(vno, from, to, color, index);
  } else {
    STurtles *ts = turtleAt(bno);
    if (ts == NULL) {
      debug("bno=%d\n", bno);
      error("SMicroWorld::scaleColor NULL");
      return;
    }
    ts->scaleColor(vno, from, to, color, index);
  }
}

float SMicroWorld::patchVarHeading(int vno, float x, float y, float heading) const
{
  float rad = deg_to_rad(heading);
  x += 1.5 * cos(rad);
  y += 1.5 * sin(rad);
  int pno = indexAtPoint(x, y);
  return getFloat(BreedId::patchBreedNo, vno, pno);
}

float SMicroWorld::aimHighPatchVar(int vno, float x, float y, float heading) const
{
  float forward = patchVarHeading(vno, x, y, heading);
  float left = patchVarHeading(vno, x, y, heading + 45);
  float right = patchVarHeading(vno, x, y, heading - 45);
  if (forward >= left && forward >= right) {
    return 0;
  } else if (left >= right) {
    return 45;
  } else {
    return -45;
  }
}

void SMicroWorld::setDefaultTurtleXY(int bno, float x, float y)
{
  if (bno < BreedId::turtleBreedNo) {
    error("SMicroWorld::setDefaultTurtleXY must be a turtle");
    return;
  }
  STurtles *ts = turtleAt(bno);
  if (ts == NULL) {
    error("SMicroWorld::setDefaultTurtleXY invalid bno");
    return;
  }
  ts->setDefaultXY(x, y);
}

void SMicroWorld::setRandomSeed(int seed)
{
  if (seed == 0) {
    std::random_device rd;
    random.seed(rd());
  } else {
    random.seed(seed);
  }
}

int SMicroWorld::randomFromTo(int from, int to)
{
  //return from + (rand() % (to - from + 1));
  std::uniform_int_distribution<int> dist(from, to);
  return dist(random);
}
