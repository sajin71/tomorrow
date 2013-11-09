#include "tools.h"

#include <stdio.h>
#include <stdarg.h>

#ifdef NO_DPRINTF
void dprintf(const char *str, ...) { return; }
#else
void dprintf(const char *str, ...) {
	va_list arg;
	va_start(arg, str);
	vfprintf(stderr, str, arg);
	va_end(arg);
}
#endif

int getregbyorder(int order, int regmax, const int oporder[]) {
	for(int r=0; r<regmax; r++) {
		if ( oporder[r] == order ) {
			return r;
		}
	}
	
	return -1;
}

