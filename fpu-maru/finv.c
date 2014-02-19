#include <stdio.h>
#include <stdint.h>
#include <inttypes.h>
#include <stdlib.h>
#include <errno.h>

#define FCL_RET(fd) do{				\
  if(fclose(fd) == EOF){			\
    perror("fclose()");				\
  }						\
    return 0;					\
  } while(0)

uint32_t finv(uint32_t a){
  FILE *fd = fopen("./finvtablesim.dat","r");
  uint32_t a0,a1,e,s,grad,cons,y,q;

  if(!fd){
    perror("fopen()");
    return 0;
  }

  a0 = (a<<9)>>22;		/* a0 <= a(22 downto 13) */
  a1 = (a<<19)>>19;		/* a1 <= a(12 downto 0) */
  e = (a<<1)>>24;		/* e <= a(30 downto 23) */
  s = a>>31;			/* s <= a(31) */

  if(fseek(fd,8*a0,SEEK_SET)<0){
    perror("fseek()");
    FCL_RET(fd);
  }
  
  if(fread(&grad,4,1,fd) < 1){
    fprintf(stderr,"fread() failed\n");
    FCL_RET(fd);
  }
  if(fread(&cons,4,1,fd) < 1){
    fprintf(stderr,"fread() failed\n");
    FCL_RET(fd);
  }

  y = cons - ((grad * a1)>>12);

  if(a0 == 0 && a1 == 0){
    q = (s<<31) | ((254 - e)<<23);
  }
  else{
    q = (s<<31) | ((253 - e)<<23) | y;
  }

  if(fclose(fd) == EOF){
    perror("fclose()");
  }

  return q;
}
