tests-accessing
testClassNameForVarNo
	| pv |
	pv := SPatchVarDef new.
	self assert: (pv classNameForVarNo: SPatchVarDef colorVarNo) equals: #ByteArray.
	self assert: (pv classNameForVarNo: SPatchVarDef screenVarNo) equals: #ByteArray.
	self assert: (pv classNameForVarNo: SPatchVarDef xVarNo) equals: #FloatArray.
	self assert: (pv classNameForVarNo: SPatchVarDef yVarNo) equals: #FloatArray