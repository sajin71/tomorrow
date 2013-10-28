#include <stdint.h>

#define ARRSIZE(x) (sizeof(x) / sizeof(x[0]))
#define isInBYTE(x) ( -128 <= x && x <= 127 )

typedef uint32_t inst_t;
typedef int16_t imm_t;
typedef uint16_t uimm_t;
typedef int32_t disp_t;

void dprintf(const char *str, ...);
int getregbyorder(int order, int regmax, const int oporder[]);

