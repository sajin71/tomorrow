#include <gtest/gtest.h>
#include "interface.h"
#include <bitset>

union t {
    uint32_t i;
    float f;
};

TEST(InterfaceTest, FaddSimpleTest){
    t a, b, c;
    for(int i = 0; i <= 0xffffffff; i++){
	for(int j = i; j <= 0xffffffff; j++){
	    t d;
	    a.i = i;
	    b.i = j;
	    d.f = a.f+b.f;
	    c.i = _fadd(a.i, b.i);
	    //c.f = a.f+b.f;
	    std::bitset<32> t = d.i ^ c.i;
	    int cnt = 0;
	    for(int i = 0; i < 32; i++){
		if(t[i]){
		    cnt ++;
		}
	    }
	    EXPECT_GE(1, cnt);
	}
    }
}
TEST(InterfaceTest, FmulSimpleTest){
    t a, b, c;

    a.f = b.f = 0;
    c.i = _fmul(a.i, b.i);
    EXPECT_FLOAT_EQ(0, c.f);

    a.f = 1;
    c.i = _fmul(a.i, b.i);
    EXPECT_FLOAT_EQ(0, c.f);

    b.f = 1;
    c.i = _fmul(a.i, b.i);
    EXPECT_FLOAT_EQ(1, c.f);

    b.f = -1;
    c.i = _fmul(a.i, b.i);
    EXPECT_FLOAT_EQ(-1, c.f);
}
