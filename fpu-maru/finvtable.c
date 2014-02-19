#include <stdio.h>
#include <stdint.h>
#include <inttypes.h>
#include <stdlib.h>
#include <errno.h>

#define TDEPTH 10
#define GWIDTH 12
#define F_E (1<<7)
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

tbl *make_table(){
  uint32_t a0,a1,y;
  uint64_t sxy,sy;
  myflt c;
  tbl *table = calloc(1<<TDEPTH,sizeof(tbl));

  if(!table){
    perror("calloc()");
    return NULL;
  }
  
  for(a0 = 0; a0 < 1<<TDEPTH; a0++){
    sxy = 0;
    sy = 0;
    for(a1 = 0; a1 <= N; a1++){
      c.u = (F_E << 23) | (a0 << (23-TDEPTH)) | a1;
      c.f = 1/c.f;
      y = (c.u<<9)>>9;

      sxy += (uint64_t)a1 * y;
      sy += y;
    }

    if(a0 == 0){
      table[a0].a = ((6*((N+1)*sy-(sxy<<1)))<<GWIDTH)/(N*(N+1)*(N-1));
      table[a0].b = (((2*N+1)*sy-3*sxy)<<1)/(N*(N-1));
    }
    else{
      table[a0].a = ((6*(N*sy-(sxy<<1)))<<GWIDTH)/(N*(N+1)*(N+2));
      table[a0].b = (((2*N+1)*sy-3*sxy)<<1)/((N+1)*(N+2));
    }
  }

  table[3].b++;
  table[10].b++;
  
  return table;
}


void check_table(tbl *table){
  myflt rl;
  uint32_t f,cl,a0,a1,y,over=0,total=0,maxa=0,maxb=0;
  uint32_t shk[15] = {};
  int d=0;

  if(!table){
    fprintf(stderr,"inappropriate address\n");
    return;
  }

  for(f = 0; f < 1<<23; f++){
    a0 = f>>(23-TDEPTH);
    a1 = (f<<(TDEPTH+9))>>(TDEPTH+9);
    y = table[a0].b - (((uint64_t)table[a0].a * a1)>>GWIDTH);
    maxa = table[a0].a > maxa ? table[a0].a : maxa;
    maxb = table[a0].b > maxb ? table[a0].b : maxb;
    
    if(f == 0){
      cl = ((254 - F_E)<<23);
    }
    else{
      cl = ((253 - F_E)<<23) | y;
    }

    rl.u = (F_E << 23) | f;
    rl.f = 1/rl.f;

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

void plot_table(tbl *table){
  uint32_t a,a0,a1,y;
  FILE *tout = fopen("./tout2.txt","w");

  if(!tout){
    perror("fopen()");
    return;
  }
  
  for(a = 0; a < 1<<23; a+=(1<<10)){
    a0 = a>>(23-TDEPTH);
    a1 = (a<<(TDEPTH+9))>>(TDEPTH+9);
    y = table[a0].b - (((uint64_t)table[a0].a * a1)>>GWIDTH);
    fprintf(tout,"%"PRIu32"\t%"PRIu32"\n",(a0<<(23-TDEPTH)) | a1 | (1<<23),y);
  }

  if(fclose(tout) == EOF){
    perror("fclose()");
  }
  
  return;
}

void make_coe(tbl *table){
  FILE *fileout = fopen("./finvtable.coe","w");
  uint32_t a0;
  
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

  fprintf(fileout,"MEMORY_INITIALIZATION_RADIX=2;\nMEMORY_INITIALIZATION_VECTOR=\n");

  for(a0 = 0; a0 < 1<<TDEPTH; a0++){
    fprint_binary(fileout,13,'p',table[a0].a);
    fprint_binary(fileout,23,'p',table[a0].b);
    if(a0 == (1<<TDEPTH) - 1){
      fprintf(fileout,";");
    }
    else{
      fprintf(fileout,",\n");
    }
  }

  if(fclose(fileout) == EOF){
    perror("fclose()");
  }

  return;
}

void make_simtable(tbl *table){
  FILE *fileout = fopen("./finvtablesim.dat","w");
  uint32_t a0;
  
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

  for(a0 = 0; a0 < 1<<TDEPTH; a0++){
    if(fwrite(&(table[a0].a),4,1,fileout) < 1){
      fprintf(stderr,"fwrite() failed");
    }
    if(fwrite(&(table[a0].b),4,1,fileout) < 1){
      fprintf(stderr,"fwrite() failed");
    }
  }

  if(fclose(fileout) == EOF){
    perror("fclose()");
  }

  return;
}
  
int main(){
  tbl *table = make_table();
  check_table(table);
  //  plot_table(table);
  make_coe(table);
  make_simtable(table);
  
  free(table);
  
  return 0;
}
