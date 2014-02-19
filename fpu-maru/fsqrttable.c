#include <stdio.h>
#include <stdint.h>
#include <inttypes.h>
#include <stdlib.h>
#include <errno.h>
#include <math.h>

#define TDEPTH 9
#define GWIDTH 13
#define N ((uint64_t)((1<<(23-TDEPTH))-1))

typedef union _myflt{
  uint32_t u;
  float f;
} myflt;

typedef struct _tbl{
  uint32_t a;
  uint32_t b;
} tbl;

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

tbl **make_table(){
  uint32_t eb,a0,a1,y;
  uint64_t sxy,sy;
  myflt c;
  tbl **table = calloc(2,sizeof(tbl*));

  if(!table){
    perror("calloc()");
    return NULL;
  }
  
  table[0] = calloc(1<<TDEPTH,sizeof(tbl));
  table[1] = calloc(1<<TDEPTH,sizeof(tbl));
  
  if(!table[0] || !table[1]){
    free(table[0]);
    free(table[1]);
    free(table);
    return NULL;
  }

  for(eb = 0; eb <= 1; eb++){
    for(a0 = 0; a0 < 1<<TDEPTH; a0++){
      sxy = 0;
      sy = 0;
      for(a1 = 0; a1 <= N; a1++){
	c.u = (1 << 30) | (eb << 23) | (a0 << (23-TDEPTH)) | a1;
	c.f = sqrtf(c.f);
	y = (c.u<<9)>>9;

	sxy += (uint64_t)a1 * y;
	sy += y;
      }

      table[eb][a0].a = ((6*((sxy<<1)-N*sy))<<GWIDTH)/(N*(N+1)*(N+2));
      table[eb][a0].b = (((2*N+1)*sy-3*sxy)<<1)/((N+1)*(N+2)) + 1;
    }
  }
  
  return table;
}

void check_table(tbl **table){
  myflt rl;
  uint32_t f,cl,eb,a0,a1,y,over=0,total=0,maxa=0,maxb=0;
  uint32_t shk[15] = {};
  int d=0;
  
  if(!table){
    fprintf(stderr,"inappropriate address\n");
    return;
  }
  if(!table[0] || !table[1]){
    fprintf(stderr,"inappropriate address\n");
    return;
  }

  for(eb = 0; eb <= 1; eb++){
    for(f = 0; f < 1<<23; f++){
      a0 = f>>(23-TDEPTH);
      a1 = (f<<(TDEPTH+9))>>(TDEPTH+9);
      y = table[eb][a0].b + (((uint64_t)table[eb][a0].a * a1)>>GWIDTH);
      maxa = table[eb][a0].a > maxa ? table[eb][a0].a : maxa;
      maxb = table[eb][a0].b > maxb ? table[eb][a0].b : maxb;
    
      if(eb == 0){
	cl = ((((1<<7)+126)>>1)<<23) | y;
	rl.u = (1<<30) | f;
      }
      else{
	cl = ((((1<<7)+128)>>1)<<23) | y;
	rl.u = (1<<30) | (1<<23) | f;
      }

      rl.f = sqrtf(rl.f);

      d = (int)cl - (int)rl.u;

      if(d>7 || d<-7){
	over++;
      }
      else{
	shk[d+7]++;
      }
	
      if(d>3 || d<-3){
      	printf("----------\ndiff:% d\ncl = ",d);
      	fprint_binary(stdout,32,'v',cl);
      	printf("\nrl = ");
      	fprint_binary(stdout,32,'v',rl.u);
      	printf("\na0 = ");
      	fprint_binary(stdout,32,'v',a0);
      	printf("\na1 = ");
      	fprint_binary(stdout,32,'v',a1);
      	printf("\n----------\n");
      }

    }
  }

  for(d=-7;d<=7;d++){
    printf("% d:%"PRIu32"\n",d,shk[d+7]);
    total += shk[d+7];
  }
  total += over;
  printf("over:%"PRIu32"\ntotal:%"PRIu32"\nmaxa:",over,total);
  fprint_binary(stdout,13,'v',maxa);
  printf("\nmaxb:");
  fprint_binary(stdout,23,'v',maxb);
  printf("\n");

  return;
}

void make_coe(tbl **table){
  FILE *fileout = fopen("./fsqrttable.coe","w");
  uint32_t eb,a0;
  
  if(!fileout){
    perror("fopen()");
    return;
  }

  if(!table){
    fprintf(stderr,"inappropriate table\n");
    if(fclose(fileout) == EOF){
      perror("fclose()");
    }
    return;
  }
  if(!table[0] || !table[1]){
    fprintf(stderr,"inappropriate table\n");
    if(fclose(fileout) == EOF){
      perror("fclose()");
    }
    return;
  }

  fprintf(fileout,"MEMORY_INITIALIZATION_RADIX=2;\nMEMORY_INITIALIZATION_VECTOR=\n");

  for(eb = 0; eb <= 1; eb++){
    for(a0 = 0; a0 < 1<<TDEPTH; a0++){
      fprint_binary(fileout,13,'p',table[eb][a0].a);
      fprint_binary(fileout,23,'p',table[eb][a0].b);
      if(eb == 1 && a0 == (1<<TDEPTH) - 1){
	fprintf(fileout,";");
      }
      else{
	fprintf(fileout,",\n");
      }
    }
  }

  if(fclose(fileout) == EOF){
    perror("fclose()");
  }

  return;
}

void make_simtable(tbl **table){
  FILE *fileout = fopen("./fsqrttablesim.dat","w");
  uint32_t eb,a0;
  
  if(!fileout){
    perror("fopen()");
    return;
  }

  if(!table){
    fprintf(stderr,"inappropriate table\n");
    if(fclose(fileout) == EOF){
      perror("fclose()");
    }
    return;
  }

  if(!table[0] || !table[1]){
    fprintf(stderr,"inappropriate table\n");
    if(fclose(fileout) == EOF){
      perror("fclose()");
    }
    return;
  }

  for(eb = 0; eb <= 1; eb++){
    for(a0 = 0; a0 < 1<<TDEPTH; a0++){
      if(fwrite(&(table[eb][a0].a),4,1,fileout) < 1){
	fprintf(stderr,"fwrite() failed");
      }
      if(fwrite(&(table[eb][a0].b),4,1,fileout) < 1){
	fprintf(stderr,"fwrite() failed");
      }
    }
  }

  if(fclose(fileout) == EOF){
    perror("fclose()");
  }

  return;
}


int main(){
  tbl **table = make_table();
  check_table(table);
  make_coe(table);
  make_simtable(table);
  
  free(table[0]);
  free(table[1]);
  free(table);
  
  return 0;
}
