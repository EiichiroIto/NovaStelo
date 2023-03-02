#ifndef _COMMON_H_
#define _COMMON_H_

#define MAX_VARIABLES 32
#define MAX_BREEDS 16

#ifndef u_int8_t
typedef unsigned char u_int8_t;
typedef unsigned int u_int32_t;
#endif /* u_int8_t */

extern void info(const char *str);
extern void error(const char *str);
extern void printString(const char *str);
extern void printHex(int num);
extern void printInteger(int num);
extern void printFloat(float num);
extern void printSpaces(int num);

extern bool fCloseTo(float x, float y);

#define boolString(b) ((b)?"true":"false")
#ifndef min
#define min(x,y) ((x)<(y)?(x):(y))
#endif /* min */
#ifndef M_PI
#define M_PI (3.14159265358979)
#endif /* M_PI */
#define deg_to_rad(deg) (((deg)/360)*2*M_PI)
#define rad_to_deg(rad) (((rad)/2/M_PI)*360)

class SColorList {
 public:
  const static u_int8_t black = 0;
  const static u_int8_t white = 9;
  const static int colors = 140;
  static u_int8_t random() { return rand() % colors; }
  static u_int8_t scale(float value, float from, float to, u_int8_t color);
};

class SteloId {
 protected:
  int _max;

  virtual int defaultCount() const { return 0; }

 public:
  SteloId();
  void updateId(int n);
  int max() const { return _max; }
  virtual void print(int indent) const;
};

#endif /* _COMMON_H_ */
