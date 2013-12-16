#include <stdio.h>


int main(int argc, char *argv[]) {
	
	FILE *fp = stdin;
	if ( argc > 1 ) {
		fp = fopen(argv[1], "r");
		if ( fp == NULL ) { fprintf(stderr, "open err\n"); return -1; }
	}
	
	while ( !feof(fp) ) {
		unsigned int d;
		fscanf(fp, "%u", &d);
		
		printf("%11d ", d);
		
		printf("%d ", d >> 31);
		printf("0x%02x ", (d >> 23)&0xff);
		printf("0x%06x\n", d & 0x7fffff);
	}
}
