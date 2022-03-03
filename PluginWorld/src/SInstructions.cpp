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

union {
  int i;
  float f;
} convIntToFloat;

SteloValue SThread::getVar(int bno, int vno, int index) const
{
  SteloValue v;
  switch (_world->getType(bno, vno)) {
  case VT_Float:
  case VT_ComputedFloat:
    v = SteloValue(_world->getFloat(bno, vno, index));
    break;
  case VT_Byte:
    v = SteloValue(_world->getByte(bno, vno, index));
    break;
  default:
    debug("%d\n", _world->getType(bno, vno));
    error("SThread::getVar invalid type");
    break;
  }
  return v;
}

void SThread::setVar(int bno, int vno, int index, SteloValue val)
{
  switch (_world->getType(bno, vno)) {
  case VT_Float:
    _world->setFloat(bno, vno, index, val.floatValue());
    break;
  case VT_Byte:
    _world->setByte(bno, vno, index, val.byteValue());
    break;
  default:
    debug("bno=%d, vno=%d, type=%d\n", bno, vno, _world->getType(bno, vno));
    error("SThread::setVar invalid type");
    break;
  }
}

void SThread::perform(SteloSymbol s)
{
  //printf("SThread::perform s=%d\n", s);
  switch (s) {
  case SS_push0:
    pushFloat(0);
    break;

  case SS_push1:
    pushFloat(1);
    break;

  case SS_pushShort:
    {
      SteloValue v1 = fetch();
      SteloValue v2 = fetch();
      int v = (int) v1.byteValue();
      v += (int) v2.byteValue() * 0x100;
      if (v >= 0x8000) {
	v -= 0x10000;
      }
      pushFloat(v);
    }
    break;

  case SS_pushFloat:
    {
      SteloValue v1 = fetch();
      SteloValue v2 = fetch();
      SteloValue v3 = fetch();
      SteloValue v4 = fetch();
      int v = (int) v1.byteValue();
      v += (int) v2.byteValue() * 0x100;
      v += (int) v3.byteValue() * 0x10000;
      v += (int) v4.byteValue() * 0x1000000;
      convIntToFloat.i = v;
      pushFloat(convIntToFloat.f);
    }
    break;

  case SS_abs:
    {
      float x = popFloat();
      x = fabs(x);
      pushFloat(x);
    }
    break;

  case SS_acos:
    {
      float x = popFloat();
      x = fmin(x, 1.0);
      x = fmax(x, -1.0);
      x = acos(x);
      x = rad_to_deg(x);
      pushFloat(x);
    }
    break;

  case SS_aimHigh:
    {
      int vno = (int) popFloat();
      if (_breedNo < BreedId::turtleBreedNo) {
        error("SS_aimHigh invalid breedId");
	pushFloat(0);
	return;
      }
      float x = _world->getFloat(_breedNo, STurtleVarId::xVarNo, _index);
      float y = _world->getFloat(_breedNo, STurtleVarId::yVarNo, _index);
      float heading = _world->getFloat(_breedNo, STurtleVarId::headingVarNo, _index);
      float dir = _world->aimHighPatchVar(vno, x, y, heading);
      pushFloat(dir);
    }
    break;

  case SS_and:
    {
      int x = popFloat();
      int y = popFloat();
      pushFloat(x & y);
    }
    break;

  case SS_appendToList:
    break;

  case SS_asin:
    {
      float x = popFloat();
      x = fmin(x, 1.0);
      x = fmax(x, -1.0);
      x = asin(x);
      x = rad_to_deg(x);
      pushFloat(x);
    }
    break;

  case SS_atan:
    {
      float x = popFloat();
      x = fmin(x, 1.0);
      x = fmax(x, -1.0);
      x = atan(x);
      x = rad_to_deg(x);
      pushFloat(x);
    }
    break;

  case SS_broadcast:
    {
      int eno = (int) popFloat();
      _world->raiseEvent(eno);
    }
    break;

  case SS_call:
    {
      int address = (int) popFloat() - 1;
      pushFloat(_pc);
      _pc = address;
    }
    break;

  case SS_changeBreedVarBy:
    {
      int bid = (int) popFloat();
      int vno = (int) popFloat();
      float val = popFloat();
      _world->changeBy(bid, vno, val);
    }
    break;

  case SS_clearBreed:
    {
      int bno = (int) popFloat();
      _world->clearBreed(bno);
    }
    break;

  case SS_clearList:
    break;

  case SS_clearPlots:
    break;

  case SS_clearTurtles:
    _world->clearTurtles();
    break;

  case SS_copyBreedVarTo:
    {
      int bid = (int) popFloat();
      int vno1 = (int) popFloat();
      int vno2 = (int) popFloat();
      _world->copyVar(bid, vno1, vno2);
    }
    break;

  case SS_cos:
    {
      float x = popFloat();
      x = deg_to_rad(x);
      x = cos(x);
      pushFloat(x);
    }
    break;

  case SS_createPatch:
    {
      int count = (int) popFloat();
      _world->createPatch(count);
    }
    break;

  case SS_createTurtles:
    {
      int bno = (int) popFloat();
      int count = (int) popFloat();
      _world->createTurtles(bno, count);
    }
    break;

  case SS_dec:
    {
      float x = popFloat();
      pushFloat(x-1);
    }
    break;

  case SS_diffuse:
    {
      float percent = popFloat();
      int vno = (int) popFloat();
      _world->diffuse8(vno, percent);
    }
    break;

  case SS_diffuse4:
    {
      float percent = popFloat();
      int vno = (int) popFloat();
      _world->diffuse4(vno, percent);
    }
    break;

  case SS_direction:
    {
      float y = popFloat();
      float x = popFloat();
      float d = 0;
      if (fCloseTo(x, 0)) {
        d = y < 0 ? -90 : 90;
      } else {
        d = rad_to_deg(atan(y/x));
      }
      pushFloat(d);
    }
    break;

  case SS_div:
    {
      float y = popFloat();
      float x = popFloat();
      pushFloat(x/y);
    }
    break;

  case SS_drop:
    pop();
    break;

  case SS_dup:
    {
      SteloValue v = pop();
      push(v);
      push(v);
    }
    break;

  case SS_dx:
    {
      float dx, dy;
      _world->getDelta(_breedNo, _index, &dx, &dy);
      pushFloat(dx);
    }
    break;

  case SS_dy:
    {
      float dx, dy;
      _world->getDelta(_breedNo, _index, &dx, &dy);
      pushFloat(dy);
    }
    break;

  case SS_equal:
    {
      SteloValue y = pop();
      SteloValue x = pop();
      pushBool(x.closeTo(y));
    }
    break;

  case SS_exp:
    {
      float x = popFloat();
      pushFloat(exp(x));
    }
    break;

  case SS_exp10:
    {
      float x = popFloat();
      pushFloat(pow(10,x));
    }
    break;

  case SS_forward:
    {
      float step = popFloat();
      _world->forward(_breedNo, _index, step);
    }
    break;

  case SS_getBreedId:
    pushFloat(_breedNo);
    break;

  case SS_getBreedVar:
    {
      int bno = (int) popFloat();
      int vno = (int) popFloat();
      int index = (int) popFloat();
      //printf("bno=%d vno=%d index=%d\n", bno, vno, index);
      float ret = 0;
      if (index > 0) {
	ret = _world->getFloat(bno, vno, index);
      }
      pushFloat(ret);
    }
    break;

  case SS_getId:
    pushFloat(_index);
    break;

  case SS_getLineOfList:
    break;
    
  case SS_getVar:
    {
      int vno = (int) popFloat();
      SteloValue v = getVar(_breedNo, vno, _index);
      push(v);
    }
    break;

  case SS_getX:
    {
      int vno = 0;
      if (_breedNo == BreedId::patchBreedNo) {
        vno = SPatchVarId::xVarNo;
      } else if (_breedNo >= BreedId::turtleBreedNo) {
        vno = STurtleVarId::xVarNo;
      } else {
        error("SS_getX invalid breedId");
	break;
      }
      SteloValue v = getVar(_breedNo, vno, _index);
      push(v);
    }
    break;

  case SS_getY:
    {
      int vno = 0;
      if (_breedNo == BreedId::patchBreedNo) {
        vno = SPatchVarId::yVarNo;
      } else if (_breedNo >= BreedId::turtleBreedNo) {
        vno = STurtleVarId::yVarNo;
      } else {
        error("SS_getY invalid breedId");
	break;
      }
      SteloValue v = getVar(_breedNo, vno, _index);
      push(v);
    }
    break;

  case SS_hatch:
    _world->hatch(_breedNo, _index);
    break;

  case SS_inv:
    {
      int x = popFloat();
      pushFloat((float) ~x);
    }
    break;

  case SS_jump:
    _pc = (int) popFloat() - 1;
    break;

  case SS_jumpIfFalse:
    {
      int address = (int) popFloat() - 1;
      bool cond = popBool();
      if (!cond) {
        _pc = address;
      }
    }
    break;

  case SS_jumpIfTrue:
    {
      int address = (int) popFloat() - 1;
      bool cond = popBool();
      if (cond) {
        _pc = address;
      }
    }
    break;

  case SS_kill:
    {
      float index = popFloat();
      float bno = popFloat();
      _world->kill(bno, index);
    }
    break;

  case SS_less:
    {
      float y = popFloat();
      float x = popFloat();
      pushBool(x < y);
    }
    break;

  case SS_lessEqual:
    {
      float y = popFloat();
      float x = popFloat();
      pushBool(x <= y);
    }
    break;

  case SS_lineCountOfList:
    break;

  case SS_listContains:
    break;
    
  case SS_ln:
    {
      float x = popFloat();
      pushFloat(log(x));
    }
    break;

  case SS_log:
    {
      float x = popFloat();
      pushFloat(log10(x));
    }
    break;

  case SS_minus:
    {
      float y = popFloat();
      float x = popFloat();
      pushFloat(x - y);
    }
    break;

  case SS_mod:
    {
      float y = popFloat();
      float x = popFloat();
      pushFloat(fmod(x,y));
    }
    break;

  case SS_mul:
    {
      float y = popFloat();
      float x = popFloat();
      pushFloat(x*y);
    }
    break;

  case SS_multiplyBreedVarBy:
    {
      int bid = (int) popFloat();
      int vno = (int) popFloat();
      float val = popFloat();
      _world->multiplyBy(bid, vno, val);
    }
    break;

  case SS_not:
    {
      bool x = popBool();
      pushBool(!x);
    }
    break;

  case SS_nsum:
    {
      int v2 = (int) popFloat();
      int v1 = (int) popFloat();
      _world->nsum8(v1, v2);
    }
    break;

  case SS_nsum4:
    {
      int v2 = (int) popFloat();
      int v1 = (int) popFloat();
      _world->nsum4(v1, v2);
    }
    break;

  case SS_or:
    {
      int x = popFloat();
      int y = popFloat();
      pushFloat(x | y);
    }
    break;

  case SS_patchAt:
    {
      float y = popFloat();
      float x = popFloat();
      float index = _world->indexAtPoint(x, y);
      pushFloat(index);
    }
    break;

  case SS_plotColor:
    break;

  case SS_plotData:
    break;

  case SS_plus:
    {
      float y = popFloat();
      float x = popFloat();
      pushFloat(x + y);
    }
    break;

  case SS_randomFromTo:
    {
      float to = popFloat();
      float from = popFloat();
      float result = _world->randomFromTo(from, to);
      pushFloat(result);
    }
    break;

  case SS_return:
    {
      _retVal = popFloat();
      _pc = (int) popFloat();
    }
    break;

  case SS_returnValue:
    pushFloat(_retVal);
    break;

  case SS_rot:
    {
      SteloValue x1 = pop();
      SteloValue x2 = pop();
      SteloValue x3 = pop();
      push(x2);
      push(x1);
      push(x3);
    }
    break;

  case SS_rounded:
    {
      float x = popFloat();
      pushFloat(round(x));
    }
    break;

  case SS_scaleColorFromTo:
    {
      float to = popFloat();
      float from = popFloat();
      u_int8_t color = (u_int8_t) popFloat();
      int vno = (int) popFloat();
      _world->scaleColor(vno, _breedNo, from, to, color, _index);
    }
    break;

  case SS_setBreedVarTo:
    {
      int bno = (int) popFloat();
      int vno = (int) popFloat();
      SteloValue val = pop();
      int index = (int) popFloat();
      setVar(bno, vno, index, val);
    }
    break;
    
  case SS_setColorTo:
    {
      u_int8_t color = (u_int8_t) popFloat();
      _world->setColor(_breedNo, _index, color);
    }
    break;

  case SS_setHeading:
    {
      float degrees = popFloat();
      _world->setHeading(_breedNo, _index, degrees);
    }
    break;

  case SS_setLineOfListTo:
    break;

  case SS_setPatchColorTo:
    {
      u_int8_t color = popByte();
      float index = popFloat();
      _world->setColor(BreedId::patchBreedNo, index, color);
    }
    break;

  case SS_setPlotYMax:
    break;

  case SS_setPlotYMin:
    break;

  case SS_setRandomSeed:
    {
      int seed = (int) popFloat();
      _world->setRandomSeed(seed);
    }
    break;

  case SS_setVarTo:
    {
      SteloValue val = pop();
      int vno = (int) popFloat();
      setVar(_breedNo, vno, _index, val);
    }
    break;

  case SS_setX:
    {
      float x = popFloat();
      int vno = 0;
      if (_breedNo == BreedId::patchBreedNo) {
        vno = SPatchVarId::xVarNo;
      } else if (_breedNo >= BreedId::turtleBreedNo) {
        vno = STurtleVarId::xVarNo;
      } else {
        error("SS_getX invalid breedId");
      }
      setVar(_breedNo, vno, _index, SteloValue(x));
    }
    break;

  case SS_setY:
    {
      float y = popFloat();
      int vno = 0;
      if (_breedNo == BreedId::patchBreedNo) {
        vno = SPatchVarId::yVarNo;
      } else if (_breedNo >= BreedId::turtleBreedNo) {
        vno = STurtleVarId::yVarNo;
      } else {
        error("SS_getX invalid breedId");
      }
      setVar(_breedNo, vno, _index, SteloValue(y));
    }
    break;

  case SS_sin:
    {
      float x = popFloat();
      x = deg_to_rad(x);
      x = sin(x);
      pushFloat(x);
    }
    break;

  case SS_sqrt:
    {
      float x = popFloat();
      pushFloat(sqrt(x));
    }
    break;

  case SS_stop:
    stop();
    break;

  case SS_stopAll:
    stop();
    terminate();
    break;

  case SS_swap:
    {
      SteloValue x = pop();
      SteloValue y = pop();
      push(x);
      push(y);
    }
    break;

  case SS_tan:
    {
      float x = popFloat();
      x = deg_to_rad(x);
      x = tan(x);
      pushFloat(x);
    }
    break;

  case SS_truncated:
    {
      float x = popFloat();
      pushFloat(trunc(x));
    }
    break;

  case SS_turtleAt:
    {
      int bno = (int) popFloat();
      int pno = (int) popFloat();
      int x = _world->getFloat(BreedId::patchBreedNo, SPatchVarId::xVarNo, pno);
      int y = _world->getFloat(BreedId::patchBreedNo, SPatchVarId::yVarNo, pno);
      int index = _world->turtleAt(bno, x, y, bno == _breedNo ? _index : 0 );
      pushFloat(index);
    }
    break;

  case SS_xyOf:
    {
      int pno = (int) popFloat();
      float x = _world->getFloat(BreedId::patchBreedNo, SPatchVarId::xVarNo, pno);
      float y = _world->getFloat(BreedId::patchBreedNo, SPatchVarId::yVarNo, pno);
      pushFloat(x);
      pushFloat(y);
    }
    break;

  default:
    debug("%d\n", s);
    error("SThread::perform invalid symbol");
    break;
  }
}
