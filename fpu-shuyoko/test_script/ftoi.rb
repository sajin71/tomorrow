# test script for https://github.com/tomoasleep/vhdl_test_script

VhdlTestScript.scenario "../ftoi.vhd" do

  ports :f, :round, :i

	step 0x00000000, 0, 0
	step 0x00000000, 1, 0
	step 0x00000000, 2, 0
	step 0x00000000, 3, 0

	step 0x80000000, 0, 0
	step 0x80000000, 1, 0
	step 0x80000000, 2, 0
	step 0x80000000, 3, 0

	step 0x3effffff, 0, 0  #0.49999999999999
	step 0x3effffff, 1, 0  #0.49999999999999
	step 0x3effffff, 2, 1  #0.49999999999999
	step 0x3effffff, 3, 0  #0.49999999999999

    step 0x3f000000, 0, 1  #0.5
    step 0x3f000000, 1, 0  #0.5
    step 0x3f000000, 2, 1  #0.5
    step 0x3f000000, 3, 0  #0.5

	step 0xbeffffff, 0, 0  #-0.49999999999999
	step 0xbeffffff, 1, 0  #-0.49999999999999
	step 0xbeffffff, 2, 0  #-0.49999999999999
	step 0xbeffffff, 3, -1  #-0.49999999999999

    step 0xbf000000, 0, -1  #-0.5
    step 0xbf000000, 1, 0  #-0.5
    step 0xbf000000, 2, 0  #-0.5
    step 0xbf000000, 3, -1  #-0.5

	step 0x3FBFFFFF, 0, 1  #1.49999999999999
	step 0x3FBFFFFF, 1, 1  #1.49999999999999
	step 0x3FBFFFFF, 2, 2  #1.49999999999999
	step 0x3FBFFFFF, 3, 1  #1.49999999999999

	step 0xBFBFFFFF, 0, -1  #1.49999999999999
	step 0xBFBFFFFF, 1, -1  #1.49999999999999
	step 0xBFBFFFFF, 2, -1  #1.49999999999999
	step 0xBFBFFFFF, 3, -2  #1.49999999999999

	step 0x3fc00000, 0, 2  #1.5
	step 0x3fc00000, 1, 1  #1.5
	step 0x3fc00000, 2, 2  #1.5
	step 0x3fc00000, 3, 1  #1.5

	step 0xbfc00000, 0, -2  #-1.5
	step 0xbfc00000, 1, -1  #-1.5
	step 0xbfc00000, 2, -1  #-1.5
	step 0xbfc00000, 3, -2  #-1.5


	step 0x41400000, 0, 12  #12
	step 0x41400000, 1, 12  #12
	step 0x41400000, 2, 12  #12
	step 0x41400000, 3, 12  #12

	step 0xC1400000, 0, -12  #-12
	step 0xC1400000, 1, -12  #-12
	step 0xC1400000, 2, -12  #-12
	step 0xC1400000, 3, -12  #-12

	step 0x41400001, 0, 12  #12.00000000+eps
	step 0x41400001, 1, 12  #12.00000000+eps
	step 0x41400001, 2, 13  #12.00000000+eps
	step 0x41400001, 3, 12  #12.00000000+eps

	step 0xC1400001, 0, -12  #-12.00000000-eps
	step 0xC1400001, 1, -12  #-12.00000000-eps
	step 0xC1400001, 2, -12  #-12.00000000-eps
	step 0xC1400001, 3, -13  #-12.00000000-eps

	step 0x41480000, 0, 13  #12.5
	step 0x41480000, 1, 12  #12.5
	step 0x41480000, 2, 13  #12.5
	step 0x41480000, 3, 12  #12.5

	step 0xC1480000, 0, -13  #-12.5
	step 0xC1480000, 1, -12  #-12.5
	step 0xC1480000, 2, -12  #-12.5
	step 0xC1480000, 3, -13  #-12.5

	step 0x4A800001, 0, 4194305
	step 0x4A800001, 1, 4194304
	step 0x4A800001, 2, 4194305
	step 0x4A800001, 3, 4194304

	step 0xCA800001, 0, -4194305
	step 0xCA800001, 1, -4194304
	step 0xCA800001, 2, -4194304
	step 0xCA800001, 3, -4194305

	step 0x4b000001, 0, 8388609
	step 0x4b000001, 1, 8388609
	step 0x4b000001, 2, 8388609
	step 0x4b000001, 3, 8388609

	step 0xCb000001, 0, -8388609
	step 0xCb000001, 1, -8388609
	step 0xCb000001, 2, -8388609
	step 0xCb000001, 3, -8388609

	step 0x4e367e8e, 0, 765436800
	step 0x4e367e8e, 1, 765436800
	step 0x4e367e8e, 2, 765436800
	step 0x4e367e8e, 3, 765436800

	step 0xce367e8e, 0, -765436800
	step 0xce367e8e, 1, -765436800
	step 0xce367e8e, 2, -765436800
	step 0xce367e8e, 3, -765436800

	step 0x4effffff, 0, 2147483520
	step 0x4effffff, 1, 2147483520
	step 0x4effffff, 2, 2147483520
	step 0x4effffff, 3, 2147483520

	step 0xceffffff, 0, -2147483520
	step 0xceffffff, 1, -2147483520
	step 0xceffffff, 2, -2147483520
	step 0xceffffff, 3, -2147483520
end
