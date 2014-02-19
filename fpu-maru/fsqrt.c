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

uint32_t fsqrt(uint32_t a){
  FILE *fd = fopen("./fsqrttablesim.dat","r");
  uint32_t a0,a1,e,gc[2],y,q;

  if(!fd){
    perror("fopen()");
    return 0;
  }

  a0 = (a<<9)>>23;		/* a0 <= a(22 downto 14) */
  a1 = (a<<18)>>18;		/* a1 <= a(13 downto 0) */
  e = (a<<1)>>24;		/* e <= a(30 downto 23) */

  if(fseek(fd,8*(((e&1)<<9)|a0),SEEK_SET)<0){
    perror("fseek()");
    FCL_RET(fd);
  }
  
  if(fread(gc,8,1,fd) < 1){
    fprintf(stderr,"fread() failed\n");
    FCL_RET(fd);
  }

  y = gc[1] + ((gc[0] * a1)>>13);	/* GWIDTH = 13 */

  if((e&1) == 0){
    q = ((63+(e>>1))<<23) | y;
  }
  else{
    q = ((64+(e>>1))<<23) | y;
  }

  if(fclose(fd) == EOF){
    perror("fclose()");
  }

  return q;
}
