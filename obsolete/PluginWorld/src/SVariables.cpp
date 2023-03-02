#include <stdio.h>
#include <string.h>
#include <cstdlib>
#include <cmath>
#include "debug.h"
#include "SCommon.h"
#include "SVariables.h"

const char *variableTypeString[] = {"None", "Float", "Byte", "Word", "CFloat"};

/*
 * VarId
 */

VarId::VarId()
{
  debug("VarId::VarId");
  for (int i = 0; i < MAX_VARIABLES; i ++) {
    _inUse[i] = false;
  }
}

VarId::~VarId()
{
  debug("VarId::~VarId");
}

void VarId::reset()
{
  for (int i = defaultCount(); i < MAX_VARIABLES; i ++) {
    _inUse[i] = false;
  }
  _max = defaultCount();
}

bool VarId::add(int id)
{
  if (id < 1 || id > MAX_VARIABLES) {
    error("VarId::add invalid id");
    debug("id=%d", id);
    return false;
  } else if (_inUse[id - 1]) {
    debug("VarId::add var is already added(id=%d)", id);
    return false;
  }
  updateId(id);
  _inUse[id - 1] = true;
  return true;
}

bool VarId::isUsed(int id) const
{
  if (id < 1 || id > MAX_VARIABLES) {
    error("VarId::isUsed invalid id");
    debug("id=%d", id);
    return false;
  }
  return _inUse[id - 1];
}

void VarId::print(int indent) const
{
  printSpaces(indent);
  printf("VarId defaultCount=%d\n", defaultCount());
  printSpaces(indent+2);
  printf("id =");
  for (int i = 0; i < MAX_VARIABLES; i ++) {
    if (_inUse[i]) {
      printf(" %d", i+1);
    }
  }
  printf("\n");
}

/*
 * SObserverVarId
 */

SObserverVarId::SObserverVarId() : VarId()
{
  add(widthVarNo);
  add(heightVarNo);
  add(maxBreedVarNo);
  add(ticksVarNo);
  add(countAliveVarNo);
  add(sizeVarNo);
  add(maxVarNo);
}

/*
 * SPatchVarId
 */

SPatchVarId::SPatchVarId() : VarId()
{
  add(colorVarNo);
  add(screenVarNo);
  add(xVarNo);
  add(yVarNo);
}

VariableType SPatchVarId::classForVar(int vno) const
{
  if (vno == colorVarNo || vno == screenVarNo) {
    return VT_Byte;
  } else if (vno == xVarNo || vno == yVarNo) {
    return VT_ComputedFloat;
  }
  return VarId::classForVar(vno);
}


STurtleVarId::STurtleVarId() : VarId()
{
  add(colorVarNo);
  add(flagVarNo);
  add(xVarNo);
  add(yVarNo);
  add(headingVarNo);
}

VariableType STurtleVarId::classForVar(int vno) const
{
  if (vno == flagVarNo) {
    return VT_Byte;
  } else if (vno == colorVarNo) {
    return VT_Byte;
  }
  return VarId::classForVar(vno);
}

/*
 * SVariables
 */

SVariables::SVariables()
{
  for (int i = 1; i <= MAX_VARIABLES; i ++) {
    resetBase(i);
  }
}

SVariables::~SVariables()
{
  free();
}

void SVariables::forceSize(int size)
{
  for (int i = 1; i <= MAX_VARIABLES; i ++) {
    if (!isAllocated(i)) {
      continue;
    }
    varAt(i).forceSize(size);
  }
}

void SVariables::free(int vno)
{
  resetBase(vno);
}

void SVariables::free()
{
  for (int vno = 1; vno <= MAX_VARIABLES; vno ++) {
    free(vno);
  }
}

void SVariables::setupVarId(const VarId *aVarId)
{
  free();
  for (int vno = 1; vno <= MAX_VARIABLES; vno ++) {
    updateVarId(aVarId, vno);
  }
}

bool SVariables::updateVarId(const VarId *aVarId, int vno)
{
  if (!aVarId->isUsed(vno)) {
    return false;
  }
  if (isAllocated(vno)) {
    return false;
  }
  setType(vno, aVarId->classForVar(vno));
  LazyArray& var = varAt(vno);
  switch (getType(vno)) {
  case VT_Float:
    var.setArrayClass(LA_Float);
    break;
  case VT_Byte:
    var.setArrayClass(LA_Byte);
    break;
  case VT_ComputedFloat:
    break;
  default:
    error("SVariables::updateVarId Invalid varType");
    break;
  }
  return true;
}

float SVariables::getFloat(int vno, int index) const
{
  if (!isFloatArray(vno)) {
    error("SVariables::getFloat invalid type");
    return 0;
  }
  return cVarAt(vno).getFloat(index);
}

const float *SVariables::getFloatAll(int vno) const
{
  //debug("SVariables::getFloatAll(%d)\n", vno);
  if (!isFloatArray(vno)) {
    error("SVariables::getFloatAll invalid type");
    return NULL;
  }
  return cVarAt(vno).cGetFloatArray();
}

float *SVariables::getFloatArray(int vno)
{
  if (!isFloatArray(vno)) {
    error("SVariables::getFloatArray invalid type");
    return NULL;
  }
  return (float *) varAt(vno).getFloatArray();
}

void SVariables::setFloat(int vno, int index, float value)
{
  if (!isFloatArray(vno)) {
    debug("SVariables::setFloat(%d,%d,%f)\n", vno, index, value);
    error("SVariables::setFloat invalid type");
    return;
  }
  varAt(vno).setFloat(index, value);
}

void SVariables::setFloatAll(int vno, const float *src, int count)
{
  if (!isFloatArray(vno)) {
    error("SVariables::setFloatAll invalid type");
    return;
  }
  varAt(vno).setFloatArray(src, count);
}

void SVariables::fillFloat(int vno, float value)
{
  if (!isFloatArray(vno)) {
    error("SVariables::fillFloat invalid type");
    return;
  }
  varAt(vno).fillFloat(value);
}

u_int8_t SVariables::getByte(int vno, int index) const
{
  if (!isByteArray(vno)) {
    error("SVariables::getByte invalid type");
    return 0;
  }
  return cVarAt(vno).getByte(index);
}

const u_int8_t *SVariables::getByteAll(int vno) const
{
  if (!isByteArray(vno)) {
    error("SVariables::getByteAll: invalid variable");
    return NULL;
  }
  return cVarAt(vno).getByteArray();
}

void SVariables::setByte(int vno, int index, u_int8_t value)
{
  if (!isByteArray(vno)) {
    error("SVariables::setByte invalid type");
    return;
  }
  varAt(vno).setByte(index, value);
}

void SVariables::setByteAll(int vno, const u_int8_t *src, int count)
{
  if (!isByteArray(vno)) {
    error("SVariables::setByteAll invalid type");
    return;
  }
  varAt(vno).setByteArray(src, count);
}

void SVariables::fillByte(int vno, u_int8_t value)
{
  if (!isByteArray(vno)) {
    error("SVariables::fillByte invalid type");
    return;
  }
  varAt(vno).fillByte(value);
}

void SVariables::print(int indent) const
{
  printSpaces(indent);
  printf("SVariables\n");
  for (int i = 1; i <= MAX_VARIABLES; i ++) {
    if (!isAllocated(i)) {
      continue;
    }
    printSpaces(indent+2);
    printf("%d: %s\n", i, variableTypeString[getType(i)]);
  }
}

void SVariables::printValue(int vno, int index) const
{
  if (!isAllocated(vno)) {
    error("SVariables::printValue invalid vno");
    return;
  }
  cVarAt(vno).printValue(index);
}

void SVariables::printValues(int vno, int w) const
{
  printString("vno=");
  printInteger(vno);
  printString("(");
  printString(variableTypeString[getType(vno)]);
  printString(")\n");
  if (!isAllocated(vno)) {
    return;
  }
  cVarAt(vno).printValues(w);
}

void SVariables::printAllValues(int w) const
{
  for (int i = 1; i <= MAX_VARIABLES; i ++) {
    printValues(i, w);
  }
}

void SVariables::printIndex(int index) const
{
  for (int vno = 1; vno <= MAX_VARIABLES; vno ++) {
    if (!isAllocated(vno)) {
      continue;
    }
    printInteger(vno);
    printString("=");
    printValue(vno, index);
    printString("\n");
  }
}

int SVariables::elementSize(int vno) const
{
  switch (getType(vno)) {
  case VT_Float:
    return sizeof (float);
  case VT_Byte:
    return sizeof (u_int8_t);
  case VT_Word:
    return sizeof (u_int32_t);
  default:
    break;
  }
  return 0;
}

void SVariables::copyScreen(int from, int to)
{
  if (!isByteArray(from)) {
    error("SVariables::copyScreen from is not type of Byte");
  }
  if (!isByteArray(to)) {
    error("SVariables::copyScreen to is not type of Byte");
  }
  if (!isAllocated(from)) {
    error("SVariables::copyScreen from is not allocated");
    return;
  }
  if (!isAllocated(to)) {
    error("SVariables::copyScreen to is not allocated");
    return;
  }
  LazyArray& src = varAt(from);
  LazyArray& dst = varAt(to);
  dst.setByteArray(src.getByteArray(), src.size());
}

void SVariables::copyVar(int from, int to)
{
  if (!isFloatArray(from)) {
    error("SVariables::copyVar from is not type of Byte");
  }
  if (!isFloatArray(to)) {
    error("SVariables::copyVar to is not type of Byte");
  }
  if (!isAllocated(from)) {
    error("SVariables::copyVar from is not allocated");
    return;
  }
  if (!isAllocated(to)) {
    error("SVariables::copyVar to is not allocated");
    return;
  }
  LazyArray& src = varAt(from);
  LazyArray& dst = varAt(to);
  dst.setFloatArray(src.getFloatArray(), src.size());
}

void SVariables::changeBy(int vno, float val)
{
  if (!isFloatArray(vno)) {
    error("SVariables::changeBy invalid type");
  }
  varAt(vno).changeBy(val);
}

void SVariables::multiplyBy(int vno, float val)
{
  if (!isFloatArray(vno)) {
    error("SVariables::multiplyBy invalid type");
  }
  varAt(vno).multiplyBy(val);
}
