#include <stdio.h>
#include <arpa/inet.h>

int main(){
  int num;
  FILE *fl;
  
  scanf("%d",&num);
  num = htonl(num);
  
  fl = fopen("/dev/ttyUSB0","w");
  fwrite(&num,sizeof(int),1,fl);
  fclose(fl);

  return 0;
}
