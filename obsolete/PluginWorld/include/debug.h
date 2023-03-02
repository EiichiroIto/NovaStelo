// thanks: https://qiita.com/tamy0612/items/3076b824bd4edf8d1429

#ifndef _DEBUG_H_
#define _DEBUG_H_

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
