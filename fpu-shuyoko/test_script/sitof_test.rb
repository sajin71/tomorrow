# test script for https://github.com/tomoasleep/vhdl_test_script

VhdlTestScript.scenario "../sitof.vhd" do
  dependencies "../PriEncoder7.vhd"
  dependencies "../PriEncoder15.vhd"
  dependencies "../PriEncoder31.vhd"

  ports :i, :f

    step 0,0
    step  2147483647,0x4f000000
    step  2147483500,0x4effffff
    step -2147483500,0xceffffff
    step -2147483648,0xcf000000  #符号ビット以外全て0
    step   268435455,0x4d800000  #仮数が繰り上がるケェス

    step 0x67c66973, 0x4ecf8cd3  # 1741056371  1741056371
    step 0x51ff4aec, 0x4ea3fe96  # 1375685356  1375685356
    step 0x29cdbaab, 0x4e2736eb  # 701348523  701348523
    step 0xf2fbe346, 0xcd5041cc  # -218373306  4076593990
    step 0x7cc254f8, 0x4ef984aa  # 2093110520  2093110520
    step 0x1be8e78d, 0x4ddf473c  # 468248461  468248461
    step 0x765a2e63, 0x4eecb45d  # 1985621603  1985621603
    step 0x339fc99a, 0x4e4e7f26  # 866109850  866109850
    step 0x66320db7, 0x4ecc641b  # 1714556343  1714556343
    step 0x3158a35a, 0x4e45628d  # 827892570  827892570
    step 0x255d0517, 0x4e157414  # 626853143  626853143
    step 0x58e95ed4, 0x4eb1d2be  # 1491689172  1491689172
    step 0xabb2cdc6, 0xcea89a64  # -1414345274  2880622022
    step 0x9bb45411, 0xcec89758  # -1682680815  2612286481
    step 0xe827441, 0x4d682744  # 243430465  243430465
    step 0x213ddc87, 0x4e04f772  # 557702279  557702279
    step 0x70e93ea1, 0x4ee1d27d  # 1894334113  1894334113
    step 0x41e1fc67, 0x4e83c3f9  # 1105329255  1105329255
    step 0x3e017e97, 0x4e7805fa  # 1040285335  1040285335
    step 0xeadc6b96, 0xcda91ca3  # -354653290  3940314006
    step 0x8f385c2a, 0xcee18f48  # -1892131798  2402835498
    step 0xecb03bfb, 0xcd9a7e20  # -323994629  3970972667
    step 0x32af3c54, 0x4e4abcf1  # 850345044  850345044
    step 0xec18db5c, 0xcd9f3925  # -333915300  3961051996
    step 0x21afe43, 0x4c06bf91  # 35323459  35323459
    step 0xfbfaaa3a, 0xcc80aab9  # -67458502  4227508794
    step 0xfb29d1e6, 0xcc9ac5c3  # -81145370  4213821926
    step 0x53c7c94, 0x4ca78f92  # 87850132  87850132
    step 0x75d8be61, 0x4eebb17d  # 1977138785  1977138785
    step 0x89f95cbb, 0xceec0d47  # -1980146501  2314820795
    step 0xa8990f95, 0xceaecde1  # -1466364011  2828603285
    step 0xb1ebf1b3, 0xce9c281d  # -1309937229  2985030067
    step 0x5eff700, 0x4cbdfee0  # 99612416  99612416
    step 0xe9a13ae5, 0xcdb2f629  # -375309595  3919657701
    step 0xca0bcbd0, 0xce57d0d1  # -905196592  3389770704
    step 0x484764bd, 0x4e908ec9  # 1212638397  1212638397
    step 0x1f231ea8, 0x4df918f5  # 522395304  522395304
    step 0x1c7b64c5, 0x4de3db26  # 477848773  477848773
    step 0x14735ac5, 0x4da39ad6  # 343104197  343104197
    step 0x5e4b7963, 0x4ebc96f3  # 1582004579  1582004579
    step 0x3b706424, 0x4e6dc191  # 997221412  997221412
    step 0x119e09dc, 0x4d8cf04f  # 295569884  295569884
    step 0xaad4acf2, 0xceaa56a6  # -1428902670  2866064626
    step 0x1b10af3b, 0x4dd8857a  # 454078267  454078267
    step 0x33cde350, 0x4e4f378d  # 869131088  869131088
    step 0x4847155c, 0x4e908e2b  # 1212618076  1212618076
    step 0xbb6f2219, 0xce8921bc  # -1150344679  3144622617
    step 0xba9b7df5, 0xce8ac904  # -1164214795  3130752501
    step 0xbe11a1c, 0x4d3e11a2  # 199301660  199301660
    step 0x7f23f829, 0x4efe47f0  # 2133063721  2133063721
    step 0xf8a41b13, 0xcceb7c9e  # -123462893  4171504403
    step 0xb5ca4ee8, 0xce946b62  # -1245032728  3049934568
    step 0x983238e0, 0xcecf9b8e  # -1741539104  2553428192
    step 0x794d3d34, 0x4ef29a7a  # 2035105076  2035105076
    step 0xbc5f4e77, 0xce874163  # -1134604681  3160362615
    step 0xfacb6c05, 0xcca6927f  # -87331835  4207635461
    step 0xac86212b, 0xcea6f3be  # -1400495829  2894471467
    step 0xaa1a55a2, 0xceabcb55  # -1441114718  2853852578
    step 0xbe70b573, 0xce831e95  # -1099909773  3195057523
    step 0x3b045cd3, 0x4e6c1173  # 990141651  990141651
    step 0x3694b3af, 0x4e5a52cf  # 915714991  915714991
    step 0xe2f0e49e, 0xcde878db  # -487529314  3807437982
    step 0x4f321549, 0x4e9e642b  # 1328682313  1328682313
    step 0xfd824ea9, 0xcc1f6c56  # -41791831  4253175465
    step 0x870d4b2, 0x4d070d4b  # 141612210  141612210
    step 0x8a295448, 0xceebad57  # -1977002936  2317964360
    step 0x9a0abcd5, 0xcecbea86  # -1710572331  2584394965
    step 0xe18a844, 0x4d618a84  # 236496964  236496964
    step 0xac5bf38e, 0xcea74819  # -1403260018  2891707278
    step 0x4cd72d9b, 0x4e99ae5b  # 1289170331  1289170331
    step 0x942e506, 0x4d142e50  # 155378950  155378950
    step 0xc433afcd, 0xce6f3141  # -1003245619  3291721677
    step 0xa3847f2d, 0xceb8f702  # -1551597779  2743369517
    step 0xadd47647, 0xcea45713  # -1378585017  2916382279
    step 0xde321cec, 0xce07378c  # -567141140  3727826156
    step 0x4ac430f6, 0x4e958862  # 1254371574  1254371574
    step 0x2023856c, 0x4e008e16  # 539198828  539198828
    step 0xfbb20704, 0xcc89bf20  # -72218876  4222748420
    step 0xf4ec0bb9, 0xcd313f44  # -185857095  4109110201
    step 0x20ba86c3, 0x4e02ea1b  # 549095107  549095107
    step 0x3e05f1ec, 0x4e7817c8  # 1040577004  1040577004
    step 0xd96733b7, 0xce1a6331  # -647547977  3647419319
    step 0x9950a3e3, 0xcecd5eb8  # -1722768413  2572198883
    step 0x14d3d934, 0x4da69eca  # 349428020  349428020
    step 0xf75ea0f2, 0xcd0a15f1  # -144793358  4150173938
    step 0x10a8f605, 0x4d8547b0  # 279508485  279508485
    step 0x9401beb4, 0xced7fc83  # -1811824972  2483142324
    step 0xbc4478fa, 0xce87770e  # -1136363270  3158604026
    step 0x4969e623, 0x4e92d3cc  # 1231676963  1231676963
    step 0xd01ada69, 0xce3f9496  # -803546519  3491420777
    step 0x6a7e4c7e, 0x4ed4fc99  # 1786662014  1786662014
    step 0x5125b348, 0x4ea24b67  # 1361425224  1361425224
    step 0x84533a94, 0xcef7598b  # -2074920300  2220046996
    step 0xfb319990, 0xcc99ccce  # -80635504  4214331792
    step 0x325744ee, 0x4e495d14  # 844580078  844580078
    step 0x9bbce9e5, 0xcec8862c  # -1682118171  2612849125
    step 0x25cf08f5, 0x4e173c24  # 634325237  634325237
    step 0xe9e25e53, 0xcdb0ed0d  # -371040685  3923926611
    step 0x60aad2b2, 0x4ec155a5  # 1621807794  1621807794
    step 0xd085fa54, 0xce3de817  # -796525996  3498441300
    step 0xd835e8d4, 0xce1f285d  # -667555628  3627411668
    step 0x66826498, 0x4ecd04c9  # 1719821464  1719821464
    step 0xd9a88775, 0xce195de2  # -643266699  3651700597
    step 0x65705a8a, 0x4ecae0b5  # 1701862026  1701862026
    step 0x3f628029, 0x4e7d8a01  # 1063419945  1063419945
    step 0x44de7ca5, 0x4e89bcf9  # 1155431589  1155431589
    step 0x894e5759, 0xceed6351  # -1991354535  2303612761
    step 0xd351adac, 0xce32b949  # -749621844  3545345452
    step 0x869580ec, 0xcef2d4fe  # -2037022484  2257944812
    step 0x17e485f1, 0x4dbf2430  # 400852465  400852465
    step 0x8c0c66f1, 0xcee7e732  # -1945344271  2349623025
    step 0x7cc07cbb, 0x4ef980f9  # 2092989627  2092989627
    step 0x22fce466, 0x4e0bf392  # 586998886  586998886
    step 0xda610b63, 0xce167bd2  # -631174301  3663792995
    step 0xaf62bc83, 0xcea13a87  # -1352483709  2942483587
    step 0xb4692f3a, 0xce972da2  # -1268175046  3026792250
    step 0xffaf2716, 0xcaa1b1d4  # -5298410  4289668886
    step 0x93ac071f, 0xced8a7f2  # -1817442529  2477524767
    step 0xb86d1134, 0xce8f25de  # -1200811724  3094155572
    step 0x2d8def4f, 0x4e3637bd  # 764276559  764276559
    step 0x89d4b663, 0xceec5693  # -1982548381  2312418915
    step 0x35c1c7e4, 0x4e570720  # 901892068  901892068
    step 0x248367d8, 0x4e120d9f  # 612591576  612591576
    step 0xed9612ec, 0xcd934f69  # -308931860  3986035436
    step 0x453902d8, 0x4e8a7206  # 1161364184  1161364184
    step 0xe50af89d, 0xcdd7a83b  # -452265827  3842701469
    step 0x7709d1a5, 0x4eee13a3  # 1997132197  1997132197
    step 0x96c1f41f, 0xced27c18  # -1765673953  2529293343
    step 0x95aa82ca, 0xced4aafa  # -1783987510  2510979786
    step 0x6c49ae90, 0x4ed8935d  # 1816768144  1816768144
    step 0xcd1668ba, 0xce4ba65d  # -854169414  3440797882
    step 0xac7aa6f2, 0xcea70ab2  # -1401248014  2893719282
    step 0xb4a8ca99, 0xce96ae6b  # -1264006503  3030960793
    step 0xb2c2372a, 0xce9a7b92  # -1295894742  2999072554
    step 0xcb08cf61, 0xce53dcc2  # -888615071  3406352225
    step 0xc9c3805e, 0xce58f1ff  # -909934498  3385032798
    step 0x6e0328da, 0x4edc0652  # 1845700826  1845700826
    step 0x4cd76a19, 0x4e99aed4  # 1289185817  1289185817
    step 0xedd2d399, 0xcd916963  # -304950375  3990016921
    step 0x4c798b00, 0x4e98f316  # 1283033856  1283033856
    step 0x22569ad4, 0x4e095a6b  # 576101076  576101076
    step 0x18d1fee4, 0x4dc68ff7  # 416415460  416415460
    step 0xd9cd45a3, 0xce18cae9  # -640858717  3654108579
    step 0x91c601ff, 0xcedc73fc  # -1849294337  2445672959
    step 0xc92ad915, 0xce5b549c  # -919938795  3375028501
    step 0x1432fee, 0x4ba197f7  # 21180398  21180398
    step 0x15028761, 0x4da8143b  # 352487265  352487265
    step 0x7c13629e, 0x4ef826c5  # 2081645214  2081645214
    step 0x69fc7281, 0x4ed3f8e5  # 1778152065  1778152065
    step 0xcd7165a6, 0xce4a3a69  # -848206426  3446760870
    step 0x3eab49cf, 0x4e7aad27  # 1051412943  1051412943
    step 0x714bce3a, 0x4ee2979c  # 1900793402  1900793402
    step 0x75a74f76, 0x4eeb4e9f  # 1973899126  1973899126
    step 0xea7e64ff, 0xcdac0cd8  # -360815361  3934151935
    step 0x81eb61fd, 0xcefc293c  # -2115280387  2179686909
    step 0xfec39b67, 0xcb9e324c  # -20735129  4274232167
    step 0xbf0de98c, 0xce81e42d  # -1089607284  3205360012
    step 0x7e4e32bd, 0x4efc9c65  # 2119054013  2119054013
    step 0xf97c8c6a, 0xccd06e73  # -109278102  4185689194
    step 0xc75ba43c, 0xce62916f  # -950295492  3344671804
    step 0x2f4b2ed, 0x4c3d2cbb  # 49591021  49591021
    step 0x7216ecf3, 0x4ee42dda  # 1914105075  1914105075
    step 0x14df000, 0x4ba6f800  # 21884928  21884928
    step 0x108b67cf, 0x4d845b3e  # 277571535  277571535
    step 0x99505b17, 0xcecd5f4a  # -1722787049  2572180247
    step 0x9f8ed498, 0xcec0e257  # -1618029416  2676937880
    step 0xa6103d1, 0x4d26103d  # 174130129  174130129
    step 0xbca70dbe, 0xce86b1e5  # -1129902658  3165064638
    step 0x9bbfab0e, 0xcec880aa  # -1681937650  2613029646
    step 0xd59801d6, 0xce299ff9  # -711458346  3583508950
    step 0xe5f2d6f6, 0xcdd06948  # -437070090  3857897206
    step 0x7d3ec516, 0x4efa7d8a  # 2101265686  2101265686
    step 0x8e212e2d, 0xcee3bda4  # -1910428115  2384539181
    step 0xaf02c6b9, 0xcea1fa73  # -1358772551  2936194745
    step 0x63c98a1f, 0x4ec79314  # 1674152479  1674152479
    step 0x7097de0c, 0x4ee12fbc  # 1889000972  1889000972
    step 0x56891a2b, 0x4ead1234  # 1451825707  1451825707
    step 0x211b0107, 0x4e046c04  # 555417863  555417863
    step 0xdd8fd8b, 0x4d5d8fd9  # 232324491  232324491
    step 0x16c2a1a4, 0x4db6150d  # 381854116  381854116
    step 0xe3cfd292, 0xcde1816b  # -472919406  3822047890
    step 0xd2984b35, 0xce359ed3  # -761771211  3533196085
    step 0x61d555d1, 0x4ec3aaac  # 1641371089  1641371089
    step 0x6c33ddc2, 0x4ed867bc  # 1815338434  1815338434
    step 0xbcf7edde, 0xce861024  # -1124602402  3170364894
    step 0x13efe520, 0x4d9f7f29  # 334488864  334488864
    step 0xc7e2abdd, 0xce607551  # -941446179  3353521117
    step 0xa44d8188, 0xceb764fd  # -1538424440  2756542856
    step 0x1c531aee, 0x4de298d7  # 475208430  475208430
    step 0xeb66244c, 0xcda4cede  # -345627572  3949339724
    step 0x3b791ea8, 0x4e6de47b  # 997793448  997793448
    step 0xacfb6a68, 0xcea6092b  # -1392809368  2902157928
    step 0xf3584606, 0xcd4a7ba0  # -212318714  4082648582
    step 0x472b260e, 0x4e8e564c  # 1194010126  1194010126
    step 0xdd2ebb2, 0x4d5d2ebb  # 231926706  231926706
    step 0x1f6c3a3b, 0x4dfb61d2  # 527186491  527186491
    step 0xc0542aab, 0xce7eaf55  # -1068225877  3226741419
    step 0xba4ef8f6, 0xce8b620e  # -1169229578  3125737718
    step 0xc7169e73, 0xce63a586  # -954818957  3340148339
    step 0x1108db04, 0x4d8846d8  # 285793028  285793028
    step 0x60220aa7, 0x4ec04415  # 1612843687  1612843687
    step 0x4d31b55b, 0x4e9a636b  # 1295103323  1295103323
    step 0x3a00d22, 0x4c680348  # 60820770  60820770
    step 0xd475dcd, 0x4d5475dd  # 222780877  222780877
    step 0x9b877856, 0xcec8f10f  # -1685620650  2609346646
    step 0xd5704c9c, 0xce2a3ece  # -714060644  3580906652
    step 0x86ea0f98, 0xcef22be1  # -2031480936  2263486360
    step 0xf2eb9c53, 0xcd51463b  # -219440045  4075527251
    step 0xda7fa5a, 0x4d5a7fa6  # 229112410  229112410
    step 0xd8b0b5db, 0xce1d3d29  # -659507749  3635459547
    step 0x50c2fd5d, 0x4ea185fb  # 1354956125  1354956125
    step 0x95a2aa5, 0x4d15a2aa  # 156904101  156904101
    step 0xe2a3fbb7, 0xcdeae022  # -492569673  3802397623
    step 0x1347549a, 0x4d9a3aa5  # 323441818  323441818
    step 0x31633223, 0x4e458cc9  # 828584483  828584483
    step 0x4ece765b, 0x4e9d9ced  # 1322153563  1322153563
    step 0x7571b64d, 0x4eeae36d  # 1970386509  1970386509
    step 0x216b2871, 0x4e05aca2  # 560670833  560670833
    step 0x2e25cf37, 0x4e38973d  # 774229815  774229815
    step 0x80f9dc62, 0xcefe0c47  # -2131108766  2163858530
    step 0x9cd719b0, 0xcec651cd  # -1663624784  2631342512
    step 0x1e6d4a4f, 0x4df36a52  # 510478927  510478927
    step 0xd17c731f, 0xce3a0e34  # -780373217  3514594079
    step 0x4ae97bc0, 0x4e95d2f8  # 1256815552  1256815552
    step 0x5a310d7b, 0x4eb4621b  # 1513164155  1513164155
    step 0x9c36edca, 0xcec79224  # -1674121782  2620845514
    step 0x5bbc02db, 0x4eb77806  # 1539048155  1539048155
    step 0xb5de3d52, 0xce944385  # -1243726510  3051240786
    step 0xb65702d4, 0xce9351fa  # -1235811628  3059155668
    step 0xc44c2495, 0xce6ecf6e  # -1001642859  3293324437
    step 0xc897b512, 0xce5da12c  # -929581806  3365385490
    step 0x8030d2db, 0xceff9e5a  # -2144283941  2150683355
    step 0x61e056fd, 0x4ec3c0ae  # 1642092285  1642092285
    step 0x1643c871, 0x4db21e44  # 373540977  373540977
    step 0xffca4db5, 0xca56c92c  # -3519051  4291448245
    step 0xa88a075e, 0xceaeebf1  # -1467349154  2827618142
    step 0xe10933a6, 0xcdf7b663  # -519490650  3775476646
    step 0x55573b1d, 0x4eaaae76  # 1431780125  1431780125
    step 0xeef02f6e, 0xcd887e85  # -286249106  4008718190
    step 0x20024981, 0x4e000926  # 537020801  537020801
    step 0xe2a07ff8, 0xcdeafc00  # -492797960  3802169336
    step 0xe34769e3, 0xcde5c4b1  # -481859101  3813108195
    step 0x11b698b9, 0x4d8db4c6  # 297179321  297179321
    step 0x419f1822, 0x4e833e30  # 1100945442  1100945442
    step 0xa84bc8fd, 0xceaf686e  # -1471428355  2823538941
    step 0xa2041a90, 0xcebbf7cb  # -1576789360  2718177936
    step 0xf449fe15, 0xcd3b601f  # -196477419  4098489877
    step 0x4b48962d, 0x4e96912c  # 1263048237  1263048237
    step 0xe81525cb, 0xcdbf56d2  # -401267253  3893700043
    step 0x5c8fae6d, 0x4eb91f5d  # 1552920173  1552920173
    step 0x45462786, 0x4e8a8c4f  # 1162225542  1162225542
    step 0xe53fa98d, 0xcdd602b4  # -448812659  3846154637
    step 0x8a718a2c, 0xceeb1cec  # -1972270548  2322696748
    step 0x75a4bc6a, 0x4eeb4979  # 1973730410  1973730410
    step 0xeeba7f39, 0xcd8a2c06  # -289767623  4005199673
    step 0x21567ea, 0x4c0559fa  # 34957290  34957290
    step 0x2b8cb687, 0x4e2e32da  # 730642055  730642055
    step 0x1b64f561, 0x4ddb27ab  # 459601249  459601249
    step 0xab1ce790, 0xcea9c631  # -1424169072  2870798224
    step 0x5b901ee5, 0x4eb7203e  # 1536171749  1536171749
    step 0x2a81177, 0x4c2a045e  # 44568951  44568951
    step 0x4dcde13b, 0x4e9b9bc2  # 1305338171  1305338171
    step 0x8760748a, 0xcef13f17  # -2023721846  2271245450
    step 0x76db74a1, 0x4eedb6e9  # 1994093729  1994093729
    step 0x682a2883, 0x4ed05451  # 1747593347  1747593347
    step 0x8f1de43a, 0xcee1c438  # -1893866438  2401100858
    step 0x39ccca94, 0x4e67332a  # 969722516  969722516
    step 0x5ce8795e, 0x4eb9d0f3  # 1558739294  1558739294
    step 0x918ad6de, 0xcedcea52  # -1853172002  2441795294
    step 0x57b719df, 0x4eaf6e34  # 1471617503  1471617503
    step 0x188d698e, 0x4dc46b4c  # 411920782  411920782
    step 0x69dd2fd1, 0x4ed3ba60  # 1776103377  1776103377
    step 0x8575497, 0x4d057549  # 139941015  139941015
    step 0x7539d1ae, 0x4eea73a3  # 1966723502  1966723502
    step 0x59b4361, 0x4cb3686c  # 94061409  94061409
    step 0x84bcc015, 0xcef68680  # -2068004843  2226962453
    step 0x4796f39e, 0x4e8f2de7  # 1201075102  1201075102
    step 0x4d0c7d65, 0x4e9a18fb  # 1292664165  1292664165
    step 0x99e6f302, 0xcecc321a  # -1712917758  2582049538
    step 0xc422d3cc, 0xce6f74b1  # -1004350516  3290616780
    step 0x7a2863ef, 0x4ef450c8  # 2049467375  2049467375
    step 0x61349d66, 0x4ec2693b  # 1630838118  1630838118
    step 0xcfe0c753, 0xce407ce3  # -807352493  3487614803
    step 0x9d8768e4, 0xcec4f12e  # -1652070172  2642897124
    step 0x1d5b826b, 0x4deadc13  # 492536427  492536427
    step 0x6700d001, 0x4ece01a0  # 1728106497  1728106497
    step 0xe6c403aa, 0xcdc9dfe3  # -423361622  3871605674
    step 0xe6d77660, 0xcdc9444d  # -422087072  3872880224
    step 0xffd94f60, 0xca1ac280  # -2535584  4292431712
    step 0xdedc6dd, 0x4d5edc6e  # 233686749  233686749
    step 0xcd8d306a, 0xce49cb3e  # -846385046  3448582250
    step 0x15994e32, 0x4dacca72  # 362368562  362368562
    step 0xf4d19d5c, 0xcd32e62a  # -187589284  4107378012
    step 0xd16e5db7, 0xce3a4689  # -781296201  3513671095
    step 0x32606218, 0x4e498188  # 845177368  845177368
    step 0x37d87936, 0x4e5f61e5  # 936933686  936933686
    step 0xb2c896bf, 0xce9a6ed3  # -1295477057  2999490239
    step 0xb55c9c83, 0xce9546c7  # -1252221821  3042745475
    step 0xeacdedff, 0xcda99090  # -355602945  3939364351
    step 0x663c315a, 0x4ecc7863  # 1715220826  1715220826

end
