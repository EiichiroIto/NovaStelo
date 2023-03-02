// thanks: https://qiita.com/tamy0612/items/3076b824bd4edf8d1429

#ifndef _DEBUG_H_
#define _DEBUG_H_

extern void info(const char *str);
extern void error(const char *str);
extern void printString(const char *str);
extern void printHex(int num);
extern void printInteger(int num);
extern void printFloat(float num);
extern void printSpaces(int num);

#ifdef NDEBUG
#define debug( fmt, ... ) ((void)0)
#else /* !NDEBUG */
#include <stdio.h>
#define debug( fmt, ... )			\
  fprintf( stdout,				\
	   "[%s] %s:%u # " fmt "\n",		\
	   __DATE__, __FILE__,			\
	   __LINE__, ##__VA_ARGS__		\
	   )
#endif /* NDEBUG */
#endif /* _DEBUG_H_ */
