#include <gtest/gtest.h>
#include <bitset>

TEST(BitSetTestSuite, InitialValueTest){
    std::bitset<8> tgt;
    EXPECT_EQ(0, tgt.to_ulong());
    
    tgt = std::bitset<8>(1);
    tgt = tgt << 2;
    EXPECT_EQ(1 << 2, tgt.to_ulong());

    tgt = std::bitset<8>(0x10);
    tgt = tgt >> 2;
    EXPECT_EQ(0x10 >> 2, tgt.to_ulong());
}
