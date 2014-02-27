#include "interface.h"
#include "fadd.h"
#include "fmul.h"

uint32_t _a, _b, _q;
//fadd fadd(_a, _b, _q);
uint32_t _am, _bm, _qm;
fmul fmul(_am, _bm, _qm);

extern "C" {
uint32_t _fadd(const uint32_t a, const uint32_t b){
    return fadd(a, b);
}

uint32_t _fmul(const uint32_t a, const uint32_t b){
    _am = a;
    _bm = b;
    fmul.clockUpdate();
    fmul.clockUpdate();
    fmul.clockUpdate();
    return _qm;
}

}
