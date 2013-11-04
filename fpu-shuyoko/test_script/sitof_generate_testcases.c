#include <stdio.h>
#include <stdint.h>

int main(void) {
	
	printf("# test script for https://github.com/tomoasleep/vhdl_test_script\n\n"

"VhdlTestScript.scenario \"../sitof.vhd\" do\n"
"  dependencies \"../PriEncoder7.vhd\"\n"
"  dependencies \"../PriEncoder15.vhd\"\n"
"  dependencies \"../PriEncoder31.vhd\"\n\n"

"  ports :i, :f\n\n"

"    step 0,0\n"
"    step  2147483647,0x4f000000\n"
"    step  2147483500,0x4effffff\n"
"    step -2147483500,0xceffffff\n"
"    step -2147483648,0xcf000000  #符号ビット以外全て0\n"
"    step   268435455,0x4d800000  #仮数が繰り上がるケェス\n\n");

	int i;
	for(i=0; i<300; i++) {
	
		union {
			uint32_t u;
			float   f;
		} hoge;
		
		union {
			int32_t  i;
			uint32_t u;
		} in;
		
		unsigned char c[4];
		
		if ( i<150 ) {
			c[0] = (i%2)?rand()%0x100 : 0x0;
			c[1] = rand()% ((rand()%3)?0x100:0x5);
		} else {
			c[0] = 0xff;
			c[1] = 0xff;
		}
		c[2] = rand()%0x100;
		c[3] = rand()%0x100;
		
		
		in.u = c[0]<<24 | c[1]<<16 | c[2]<<8 | c[3];
		hoge.f = (float)in.i;
		
		printf("    step 0x%08x, 0x%08x  # %d  %u\n", in.u, hoge.u, in.i, in.u);
		
	}
	
	printf("\nend\n");
}

