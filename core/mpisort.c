#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <mpi.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/time.h>
#include <fcntl.h>
#include <string.h>
#include <errno.h>

#define DATA_EXP 10

void merge(int *a,int *b,int *res,int n,int m){
  int i = 0,j = 0,k = 0;

  while(i<n && j<m){
    if(a[i] < b[j]) res[k++] = a[i++];
    else res[k++] = b[j++];
  }
  if(i==n){
    while(j<m){
      res[k++] = b[j++];
    }
  }
  else{
    while(i<n){
      res[k++] = a[i++];
    }
  }
}

int compar(int *a,int *b){
  int r;

  if(*a < *b) r = -1;
  else if(*a > *b) r = 1;
  else r = 0;

  return r;
}

int log_2(int n){
  int r = 0;

  while((n >> 1) != 0){
    n = (n >> 1);
    r++;
  }

  return r;
}

int check_if_sorted(int *a,int len){
  int i;
  int flag = 0;
  
  for(i=0;i<len-1;i++){
    if(a[i] > a[i+1]){
      flag = 1;
      break;
    }
  }

  return flag;
}

int check_flag(int *a,int len){
  int i;
  int flag = 0;

  for(i=0;i<len;i++){
    if(a[i] != 0){
      flag = 1;
      break;
    }
  }

  return flag;
}
  
int main(int argc,char *argv[]){
  int myrank,processnum;
  int total_data_size;
  int unko_length;
  struct timeval tv;
  int i,j;
  int *buf;
  int *mainbuf[2];
  int flag;
  int *flagc;
  
  MPI_Init(&argc,&argv);
  MPI_Comm_rank(MPI_COMM_WORLD,&myrank);
  MPI_Comm_size(MPI_COMM_WORLD,&processnum);

  total_data_size = 1 << DATA_EXP;
  unko_length = total_data_size/processnum;

  if(gettimeofday(&tv,NULL)<0){
    perror("gettimeofday()");
    return 1;
  }

  srand(tv.tv_sec + myrank);

  buf = malloc(unko_length * sizeof(int));
  for(i=0;i<unko_length;i++){
    buf[i] = rand();
  }

  qsort(buf,unko_length,sizeof(int),*compar);

  if(myrank == 0){
    mainbuf[0] = malloc(total_data_size * sizeof(int));
    mainbuf[1] = malloc(total_data_size * sizeof(int));
    flagc = malloc(processnum * sizeof(int));
  }

  MPI_Gather(buf,unko_length,MPI_INT,mainbuf[log_2(processnum) % 2],unko_length,MPI_INT,0,MPI_COMM_WORLD);

  for(i=processnum;i>1;i = (i >> 1)){
    for(j=0;j<i;j+=2){
      merge(mainbuf[log_2(i) % 2]+(j*(total_data_size/i)),mainbuf[log_2(i) % 2]+((j+1)*(total_data_size/i)),mainbuf[1-(log_2(i) % 2)]+(j*(total_data_size/i)),total_data_size/i,total_data_size/i);
    }
  }

  MPI_Scatter(mainbuf[0],unko_length,MPI_INT,buf,unko_length,MPI_INT,0,MPI_COMM_WORLD);

  flag = check_if_sorted(buf,unko_length);

  MPI_Gather(&flag,1,MPI_INT,flagc,processnum,MPI_INT,0,MPI_COMM_WORLD);

  printf("myrank = %d\n",myrank);
  
  if(myrank == 0){
    if(check_flag(flagc,processnum) == 0){
      printf("OK\n");
    }
    else{
      printf("NG\n");
    }

    free(mainbuf[0]);
    free(mainbuf[1]);
    free(flagc);
  }

  free(buf);

  MPI_Finalize();

  return 0;
}
