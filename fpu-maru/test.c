#include <stdio.h>
#include <stdint.h>
#include <inttypes.h>
#include <stdlib.h>
#include <errno.h>

typedef union _myflt{
  uint32_t u;
  float f;
} myflt;

void fprint_binary(FILE *f,int d,char mode,uint32_t n){
  int i;

  if(!f){
    return;
  }
  
  if(mode == 'v'){
    fprintf(f,"%"PRIu32" ",(n>>31)&1);
    for(i=30;i>=23;i--){
      fprintf(f,"%"PRIu32"",(n>>i)&1);
    }
    fprintf(f," ");
    for(i=22;i>=13;i--){
      fprintf(f,"%"PRIu32"",(n>>i)&1);
    }
    fprintf(f," ");
    for(i=12;i>=0;i--){
      fprintf(f,"%"PRIu32"",(n>>i)&1);
    }
  }

  else{
    for(i=d-1;i>=0;i--){
      fprintf(f,"%"PRIu32"",(n>>i)&1);
    }
  }
  
  return;
}

int main(){
  myflt x;

  x.u = (0<<23) | 12345;
  x.f = 1/x.f;

  fprint_binary(stdout,32,'v',x.u);
  printf("\n");
  return 0;
}
