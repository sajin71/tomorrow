#include <gtest/gtest.h>
#include "interface.h"

union t {
    uint32_t i;
    float f;
};

TEST(InterfaceTest, FaddSimpleTest){
    t a, b, c;
    a.f = b.f = 0;
    c.i = _fadd(a.i, b.i);
    EXPECT_EQ(0, c.f);

    a.f = 1; 
    c.i = _fadd(a.i, b.i);
    EXPECT_EQ(1, c.f);

    b.f = 1;
    c.i = _fadd(a.i, b.i);
    EXPECT_EQ(2, c.f);

    b.f = -1;
    c.i = _fadd(a.i, b.i);
    EXPECT_EQ(0, c.f);

    b.f = -100;
    c.i = _fadd(a.i, b.i);
    EXPECT_EQ(-99, c.f);
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
