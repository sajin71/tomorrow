#include <stdio.h>
#include <stdint.h>
#include <inttypes.h>
#include <stdlib.h>
#include <errno.h>
#include <math.h>

typedef union _myflt{
  uint32_t u;
  float f;
} myflt;

extern uint32_t finv(uint32_t);
extern uint32_t fsqrt(uint32_t);

void check_func(){
  myflt rl;
  uint32_t f,cl,eb,over=0,total=0;
  uint32_t shk[7] = {};
  int d=0;

  for(f = 0; f < 1<<23; f++){
    cl = finv((1<<30)|f);
    rl.u = (1<<30)|f;
    rl.f = 1/rl.f;

    d = (int)cl - (int)rl.u;
    if(d>3 || d<-3){
      over++;
    }
    else{
      shk[d+3]++;
    }
  }

  printf("-----finv-----\n");
  for(d=-3;d<=3;d++){
    printf("% d:%"PRIu32"\n",d,shk[d+3]);
    total += shk[d+3];
  }
  total += over;
  printf("over:%"PRIu32"\ntotal:%"PRIu32"\n",over,total);

  total = 0;
  over = 0;
  for(d=-3;d<=3;d++){
    shk[d+3] = 0;
  }
  
  for(eb = 0; eb <= 1; eb++){
    for(f = 0; f < 1<<23; f++){
      cl = fsqrt((((1<<7)|eb)<<23)|f);
      rl.u = (((1<<7)|eb)<<23)|f;
      rl.f = sqrtf(rl.f);

      d = (int)cl - (int)rl.u;
      if(d>3 || d<-3){
	over++;
      }
      else{
	shk[d+3]++;
      }
    }
  }

  printf("-----fsqrt-----\n");
  for(d=-3;d<=3;d++){
    printf("% d:%"PRIu32"\n",d,shk[d+3]);
    total += shk[d+3];
  }
  total += over;
  printf("over:%"PRIu32"\ntotal:%"PRIu32"\n",over,total);

  return;
}

int main(){
  check_func();
  return 0;
}
