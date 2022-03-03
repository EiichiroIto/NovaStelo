#ifndef REAL_M5STACK
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

#define TESTALL

void info(const char *str)
{
  printf("info: %s\n", str);
}

void error(const char *str)
{
  printf("error=%s\n", str);
}

void printString(const char *str)
{
  printf("%s", str);
}

void printHex(int num)
{
  printf("%2x", num);
}

void printInteger(int num)
{
  printf("%d", num);
}

void printFloat(float num)
{
  printf("%.2f", num);
}

void printSpaces(int num)
{
  printf("%*s", num, "");
}

/* --------- */

void testSteloId()
{
  printString("--- testSteloId ---\n");
  SteloId s;
  s.print(0);
  s.updateId(1);
  s.print(0);
  s.updateId(3);
  s.print(0);
}

void testBreedId()
{
  printString("--- testBreedId ---\n");
  BreedId b;
  b.print(0);
  b.updateId(1);
  b.print(0);
  b.updateId(3);
  b.print(0);
  b.updateId(5);
  b.print(0);
  b.reset();
  b.print(0);
}

void testEventId()
{
  printString("--- testEventId ---\n");
  EventId e;
  e.print(0);
  e.updateId(1);
  e.print(0);
  e.updateId(3);
  e.print(0);
  e.updateId(5);
  e.print(0);
  e.reset();
  e.print(0);
}

void testVarId()
{
  printString("--- testVarId ---\n");
  VarId v;
  v.print(0);
  v.add(1);
  v.print(0);
  v.add(3);
  v.print(0);
  v.add(5);
  v.print(0);
  printString("VVVVV \n");
  v.isUsed(0);
  printString("^^^^^ Should raise error\n");
  for (int i = 1; i < 7; i ++) {
    printInteger(i);
    if (v.isUsed(i)) {
      printString(" class=");
      printString(variableTypeString[v.classForVar(i)]);
      printString("\n");
    } else {
      printString(" is not used\n");
    }
  }
  v.reset();
  v.print(0);
  printString("VVVVV \n");
  v.add(0);
  printString("^^^^^ Should raise error\n");
  printString("VVVVV \n");
  v.add(999);
  printString("^^^^^ Should raise error\n");
  v.print(0);
}

void testSObserverVarId()
{
  printString("--- testSObserverVarId ---\n");
  SObserverVarId o;
  o.print(0);
  o.add(10);
  o.print(0);
  o.reset();
  o.print(0);
}

void testSPatchVarId()
{
  printString("--- testSPatchVarId ---\n");
  SPatchVarId p;
  p.print(0);
  p.add(5);
  p.print(0);
  for (int i = 1; i < 8; i ++) {
    printInteger(i);
    if (p.isUsed(i)) {
      printString(" class=");
      printString(variableTypeString[p.classForVar(i)]);
      printString("\n");
    } else {
      printString(" is not used\n");
    }
  }
  p.reset();
  p.print(0);
}

void testSTurtleVarId()
{
  printString("--- testSTurtleVarId ---\n");
  STurtleVarId t;
  t.print(0);
  t.add(7);
  t.print(0);
  for (int i = 1; i <= 8; i ++) {
    printInteger(i);
    if (t.isUsed(i)) {
      printString(" class=");
      printString(variableTypeString[t.classForVar(i)]);
      printString("\n");
    } else {
      printString(" is not used\n");
    }
  }
  t.reset();
  t.print(0);
}

void testSVariables()
{
  printString("--- testSVariables ---\n");
  SVariables v;
  STurtleVarId t;
  v.print(0);
  v.print(0);
  v.setupVarId(&t);
  printString("do fill values\n");
  v.fillFloat(STurtleVarId::xVarNo, 1);
  v.fillFloat(STurtleVarId::yVarNo, 2);
  v.fillByte(STurtleVarId::colorVarNo, 3);
  printString("do set values\n");
  v.setFloat(STurtleVarId::xVarNo, 1, 5);
  v.setFloat(STurtleVarId::yVarNo, 2, 6);
  v.setByte(STurtleVarId::colorVarNo, 3, 4);
  printString("VVVVV \n");
  v.setByte(STurtleVarId::xVarNo, 4, 4);
  printString("^^^^^ Should raise error\n");
  v.print(0);
  printString("\n");
  printString("float=");
  printFloat(v.getFloat(STurtleVarId::xVarNo, 1));
  printString("(should be 5.0)\n");
  printString("float=");
  printFloat(v.getFloat(STurtleVarId::yVarNo, 2));
  printString("(should be 6.0)\n");
  printString("byte=");
  printInteger(v.getByte(STurtleVarId::colorVarNo, 3));
  printString("(should be 4)\n");
  v.printAllValues(10);
  printString("do add variable vno=7\n");
  t.add(7);
  v.updateVarId(&t, 7);
  v.print(0);
  v.printAllValues(10);
  v.setByte(STurtleVarId::colorVarNo, 5, 1);
  v.copyScreen(STurtleVarId::colorVarNo, STurtleVarId::flagVarNo);
  v.multiplyBy(STurtleVarId::yVarNo, 1.5);
  v.print(0);
  v.printAllValues(10);
  printString("size of float=");
  printInteger(v.elementSize(STurtleVarId::xVarNo));
  printString("(should be 4)\n");
  printString("size of byte=");
  printInteger(v.elementSize(STurtleVarId::flagVarNo));
  printString("(should be 1)\n");
}

void testSPatches()
{
  printString("--- testSPatches ---\n");
  SPatches p;
  printString("size=");
  printInteger(p.size());
  printString("(should be 36)\n");
  printString("index of (0,0)=");
  printInteger(p.indexAtPoint(0,0));
  printString("(should be 22)\n");
  printString("x of center=");
  printInteger(p.getX(22));
  printString("(should be 0)\n");
  printString("y of center=");
  printInteger(p.getY(22));
  printString("(should be 0)\n");
  p.print(1);
  printString("Do create(100)\n");
  p.create(100);
  printString("size=");
  printInteger(p.size());
  printString("(should be 10000)\n");
  printString("index of (0,0)=");
  printInteger(p.indexAtPoint(0,0));
  printString("(should be 5051)\n");
  printString("x of center=");
  printInteger(p.getX(5051));
  printString("(should be 0)\n");
  printString("y of center=");
  printInteger(p.getY(5051));
  printString("(should be 0)\n");
  printString("Do addVariable(10)\n");
  p.addVariable(10);
  p.print(1);
  printString("Do reset\n");
  p.reset();
  p.print(1);
}

void testSTurtles()
{
  printString("--- testSTurtles ---\n");
  STurtles t;
  t.print(1);
  printString("Do create(5)\n");
  t.create(5);
  printString("Do set x,y\n");
  for (int i = 1; i <= 5; i ++) {
    t.setX(i, i);
    t.setY(i, 6-i);
  }
  printString("Do hatch(3)\n");
  t.hatch(3);
  t.printDetails();
  printString("turtle at (1,5)=");
  printInteger(t.turtleAt(1, 5, 0));
  printString("(should be 1)\n");
  printString("turtle at (3,3)=");
  printInteger(t.turtleAt(3, 3, 3));
  printString("(should be 6)\n");
  printString("turtle at (3,3)=");
  printInteger(t.turtleAt(3, 3, 6));
  printString("(should be 3)\n");
  printString("Do addVariable(10)");
  t.addVariable(10);
  t.print(1);
  printString("Do reset\n");
  t.reset();
  t.print(1);
  printString("Do create(105)\n");
  t.create(105);
  t.print(1);
}

void testLazyArray1()
{
  printString("--- testLazyArray(1) ---\n");
  LazyArray l(LA_Float);
  l.print(0);
  printString("get 1=");
  printFloat(l.getFloat(1));
  printString("\n");
  printString("get 100=");
  printFloat(l.getFloat(100));
  printString("\n");
  l.print(0);
  printString("set 1 to 2\n");
  l.setFloat(1, 2);
  printString("set 100 to 3\n");
  l.setFloat(100, 3);
  l.print(0);
  printString("get 1=");
  printFloat(l.getFloat(1));
  printString("\n");
  printString("get 100=");
  printFloat(l.getFloat(100));
  printString("\n");
  printString("set 101 to 5\n");
  l.setFloat(101, 5);
  l.print(0);
  printString("get 1=");
  printFloat(l.getFloat(1));
  printString("\n");
  printString("get 100=");
  printFloat(l.getFloat(100));
  printString("\n");
  printString("get 101=");
  printFloat(l.getFloat(101));
  printString("\n");
  printString("set float array (1,2,3)\n");
  float x[] = {1,2,3};
  l.setFloatArray(x, 3);
  printString("get 1=");
  printFloat(l.getFloat(1));
  printString("\n");
  printString("get 2=");
  printFloat(l.getFloat(2));
  printString("\n");
  printString("get 3=");
  printFloat(l.getFloat(3));
  printString("\n");
  l.print(0);
}

void testLazyArray2()
{
  printString("--- testLazyArray(2) ---\n");
  LazyArray l(LA_Byte);
  l.print(0);
  printString("get 1=");
  printInteger(l.getByte(1));
  printString("\n");
  printString("get 100=");
  printInteger(l.getByte(100));
  printString("\n");
  l.print(0);
  printString("set 1 to 2\n");
  l.setByte(1, 2);
  printString("set 100 to 3\n");
  l.setByte(100, 3);
  l.print(0);
  printString("get 1=");
  printInteger(l.getByte(1));
  printString("\n");
  printString("get 100=");
  printInteger(l.getByte(100));
  printString("\n");
  printString("set 101 to 5\n");
  l.setByte(101, 5);
  l.print(0);
  printString("get 1=");
  printInteger(l.getByte(1));
  printString("\n");
  printString("get 100=");
  printInteger(l.getByte(100));
  printString("\n");
  printString("get 101=");
  printInteger(l.getByte(101));
  printString("\n");
  printString("set byte array (10,20,30)\n");
  u_int8_t x[] = {10,20,30};
  l.setByteArray(x, 3);
  printString("get 1=");
  printInteger(l.getByte(1));
  printString("\n");
  printString("get 2=");
  printInteger(l.getByte(2));
  printString("\n");
  printString("get 3=");
  printInteger(l.getByte(3));
  printString("\n");
  l.print(0);
}

void testLazyArray3()
{
  printString("--- testLazyArray(3) ---\n");
  LazyArray l(LA_Float);
  l.print(0);
  l.forceSize(10);
  l.print(0);
  printString("get 1=");
  printFloat(l.getFloat(1));
  printString("\n");
  printString("VVVVV \n");
  printString("get 100=");
  printFloat(l.getFloat(100));
  printString("\n");
  printString("^^^^^ Should raise error\n");
  l.print(0);
  printString("set 1 to 2\n");
  l.setFloat(1, 2);
  printString("set 100 to 3\n");
  printString("VVVVV \n");
  l.setFloat(100, 3);
  printString("^^^^^ Should raise error\n");
  l.print(0);
  printString("set float array (1,2,3)\n");
  float x[] = {1,2,3};
  l.setFloatArray(x, 3);
  printString("get 1=");
  printFloat(l.getFloat(1));
  printString("\n");
  printString("get 2=");
  printFloat(l.getFloat(2));
  printString("\n");
  printString("get 3=");
  printFloat(l.getFloat(3));
  printString("\n");
  l.print(0);
  printString("set float array (10,20,30,40,50,60,70,80,90,100,110)\n");
  float y[] = {10,20,30,40,50,60,70,80,90,100,110};
  printString("VVVVV \n");
  l.setFloatArray(y, 11);
  printString("^^^^^ Should raise error\n");
  printString("get 1=");
  printFloat(l.getFloat(1));
  printString("\n");
  printString("get 2=");
  printFloat(l.getFloat(2));
  printString("\n");
  printString("get 3=");
  printFloat(l.getFloat(3));
  printString("\n");
  l.print(0);
}

void testSPatches2()
{
  printString("--- testSPatches(2) ---\n");
  SPatches p;
  p.addVariable(10);
  p.addVariable(11);
  p.setFloat(10,1,1);
  p.setFloat(11,1,1);
  p.changeBy(10, 2);
  p.copyVar(10, 11);
  p.changeBy(11, 1);
  p.multiplyBy(10, 2);
  p.multiplyBy(11, 3);
  p.printDetails();
}

int main()
{
  testSteloId();
  testBreedId();
  testEventId();
  testVarId();
  testSObserverVarId();
  testSPatchVarId();
  testSTurtleVarId();
  testSVariables();
  testSPatches();
  testSTurtles();
  testLazyArray1();
  testLazyArray2();
  testLazyArray3();
  testSPatches2();

  printString("All done\n");
  return 0;
}

#endif /* REAL_M5STACK */
