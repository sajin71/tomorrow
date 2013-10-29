# test script for https://github.com/tomoasleep/vhdl_test_script

VhdlTestScript.scenario "../itof.vhd" do
  dependencies "../PriEncoder7.vhd"
  dependencies "../PriEncoder15.vhd"
  dependencies "../PriEncoder31.vhd"
  ports :i, :f

    step 0,0
    step 268435455, 0x4d800000  #仮数が繰り上がるケェス

    step 0xc2f2f291, 0xce743436  # -1024265583
    step 0x6ca7a10a, 0x4ed94f42  # 1822925066
    step 0x57516f5d, 0x4eaea2df  # 1464954717
    step 0x145b1fb3, 0x4da2d8fe  # 341516211
    step 0x84c7e5ba, 0xcef67035  # -2067274310
    step 0x7585664c, 0x4eeb0acd  # 1971676748
    step 0x931759ab, 0xced9d14d  # -1827186261
    step 0x2305c5e5, 0x4e0c1718  # 587580901
    step 0xf7b77663, 0xcd04889a  # -138971549
    step 0x5e176db6, 0x4ebc2edb  # 1578593718
    step 0x69dd137d, 0x4ed3ba27  # 1776096125
    step 0x383231bc, 0x4e60c8c7  # 942813628
    step 0xf916766f, 0xccdd3132  # -115968401
    step 0x9bddbb2e, 0xcec8448a  # -1679967442
    step 0xf414da17, 0xcd3eb25f  # -199960041
    step 0x199ffc10, 0x4dccffe0  # 429915152
    step 0x577274b5, 0x4eaee4e9  # 1467118773
    step 0x89e16bf2, 0xceec3d28  # -1981715470
    step 0xbe7e70f6, 0xce83031e  # -1099009802
    step 0xb1a1b3aa, 0xce9cbc99  # -1314802774
    step 0xb7291952, 0xce91adcd  # -1222043310
    step 0x6d481fa, 0x4cda903f  # 114590202
    step 0xe85b1101, 0xcdbd2778  # -396685055
    step 0xfa0d1251, 0xccbe5db6  # -99806639
    step 0x7f860709, 0x4eff0c0e  # 2139490057
    step 0x6772fb26, 0x4ecee5f6  # 1735588646
    step 0xf16b1ca2, 0xcd694e36  # -244638558
    step 0xccf4cc3, 0x4d4cf4cc  # 214912195
    step 0xf96616ff, 0xccd33d20  # -110749953
    step 0x3a97fa23, 0x4e6a5fe9  # 983038499
    step 0xf20b24ec, 0xcd5f4db1  # -234150676
    step 0x19363e98, 0x4dc9b1f5  # 422985368
    step 0xbc45a124, 0xce8774be  # -1136287452
    step 0xb79d4aa8, 0xce90c56b  # -1214428504
    step 0x8664a15, 0x4d0664a1  # 140921365
    step 0x3697d82f, 0x4e5a5f61  # 915920943
    step 0xfdee2e37, 0xcc047472  # -34722249
    step 0x85285a77, 0xcef5af4b  # -2060952969
    step 0x347f644d, 0x4e51fd91  # 880763981
    step 0xb5a2e572, 0xce94ba35  # -1247615630
    step 0xe787969e, 0xcdc3c34b  # -410544482
    step 0x24e0472c, 0x4e13811d  # 618678060
    step 0x4691417c, 0x4e8d2283  # 1183924604
    step 0x281aab25, 0x4e206aad  # 672836389
    step 0x8da5d8e, 0x4d0da5d9  # 148528526
    step 0x2b70536, 0x4c2dc14e  # 45548854
    step 0x366983ec, 0x4e59a610  # 912884716
    step 0xb695ef2, 0x4d3695ef  # 191454962
    step 0xf0f49114, 0xcd70b6ef  # -252407532
    step 0xd4d8401a, 0xce2c9f00  # -724025318
    step 0x69829792, 0x4ed3052f  # 1770166162
    step 0x9c42b7a4, 0xcec77a91  # -1673349212
    step 0x1c14321f, 0x4de0a191  # 471085599
    step 0xcc385502, 0xce4f1eac  # -868723454
    step 0xa1d9eead, 0xcebc4c23  # -1579553107
    step 0x424c9f32, 0x4e84993e  # 1112317746
    step 0x40304614, 0x4e80608c  # 1076905492
    step 0x8862f72, 0x4d0862f7  # 143011698
    step 0x8c604a4, 0x4d0c604a  # 147195044
    step 0x8bb4925, 0x4d0bb492  # 146491685
    step 0xd07b449c, 0xce3e12ee  # -797227876
    step 0xb3999e55, 0xce98ccc3  # -1281778091
    step 0x728d02b4, 0x4ee51a05  # 1921843892
    step 0xd9a1e61a, 0xce197868  # -643701222
    step 0xd22c2eda, 0xce374f45  # -768856358
    step 0xb35d4cbb, 0xce994567  # -1285731141
    step 0x2350602c, 0x4e0d4181  # 592470060
    step 0xca951dc, 0x4d4a951e  # 212423132
    step 0x249578d8, 0x4e1255e3  # 613775576
    step 0x2e162da1, 0x4e3858b7  # 773205409
    step 0xa32f557d, 0xceb9a155  # -1557179011
    step 0xd03c97a2, 0xce3f0da1  # -801335390
    step 0x68c57d1b, 0x4ed18afa  # 1757773083
    step 0x23c9d746, 0x4e0f275d  # 600430406
    step 0x1a377226, 0x4dd1bb91  # 439841318
    step 0xe0c30204, 0xcdf9e7f0  # -524090876
    step 0x587adc87, 0x4eb0f5b9  # 1484446855
    step 0x90092834, 0xcedfedb0  # -1878448076
    step 0x387db109, 0x4e61f6c4  # 947761417
    step 0xb948ab22, 0xce8d6eaa  # -1186419934
    step 0xd283d30, 0x4d5283d3  # 220740912
    step 0xf214770c, 0xcd5eb88f  # -233539828
    step 0x4be9322b, 0x4e97d264  # 1273573931
    step 0xad343005, 0xcea597a0  # -1389088763
    step 0xae0c8c3e, 0xcea3e6e8  # -1374909378
    step 0x16b4724e, 0x4db5a392  # 380924494
    step 0x322357eb, 0x4e488d60  # 841177067
    step 0x6b030d79, 0x4ed6061b  # 1795362169
    step 0x2b4ba91d, 0x4e2d2ea4  # 726378781
    step 0x5f2029ab, 0x4ebe4053  # 1595943339
    step 0xa5bd6b7, 0x4d25bd6b  # 173790903
    step 0x8f06bc3d, 0xcee1f288  # -1895384003
    step 0x13497c29, 0x4d9a4be1  # 323583017
    step 0xfdee772f, 0xcc046234  # -34703569
    step 0x12cf1b7d, 0x4d9678dc  # 315562877
    step 0xd228f6fd, 0xce375c24  # -769067267
    step 0x73a01bd3, 0x4ee74038  # 1939872723
    step 0xc0447eca, 0xce7eee05  # -1069252918
    step 0xa054812f, 0xcebf56fe  # -1605074641
    step 0x5b3e6d6e, 0x4eb67cdb  # 1530817902

end
