#include <stdio.h>
#include <string.h>
#include <cstdlib>
#include <cmath>
#include "debug.h"
#include "SCommon.h"

bool fCloseTo(float x, float y)
{
  return fabs(x-y) < 0.0001;
}

/*
 * SColorList
 */

u_int8_t SColorList::scale(float value, float from, float to, u_int8_t color)
{
  if (from == to) {
    return 0;
  }
  float param = (value - from) / (to - from);
  if (color < 5) {
    if (value < from) {
      return 0;
    } else if (value > to) {
      return 255;
    }
    return param * 255;
  }
  if (from < to && value < from) {
    return SColorList::black;
  } else if (from < to && value > to) {
    return SColorList::white;
  } else if (from > to && value > from) {
    return SColorList::black;
  } else if (from > to && value < to) {
    return SColorList::white;
  }
  return ((color - 5) * (1 - param)) + ((color + 4) * param);
}

/*
 * SteloId
 */

SteloId::SteloId()
{
  _max = 0;
}

void SteloId::updateId(int id)
{
  if (id > _max) {
    _max = id;
  }
}

void SteloId::print(int indent) const
{
  printSpaces(indent);
  printf("SteloId max=%d, default=%d\n", _max, defaultCount());
}
