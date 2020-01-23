tests-accessing
testClassNameForVarNo
	| pv |
	pv := STurtleVarDef new.
	self assert: (pv classNameForVarNo: STurtleVarDef colorVarNo) equals: #ByteArray.
	self assert: (pv classNameForVarNo: STurtleVarDef flagVarNo) equals: #ByteArray.
	self assert: (pv classNameForVarNo: STurtleVarDef xVarNo) equals: #FloatArray.
	self assert: (pv classNameForVarNo: STurtleVarDef yVarNo) equals: #FloatArray.
	self assert: (pv classNameForVarNo: STurtleVarDef headingVarNo) equals: #FloatArray