#ifndef BENCH_H_INCLUDED
#define BENCH_H_INCLUDED

#include <sys/time.h>


#define MYTIMEVAL( tv_ )			\
  ((tv_.tv_sec)+(tv_.tv_usec)*1.0e-6)

#define TIMESTAMP( time_ )				\
  {							\
    static struct timeval tv;				\
    gettimeofday( &tv, NULL );				\
    time_=MYTIMEVAL(tv);				\
  }


#endif /* BENCH_H_INCLUDED */
