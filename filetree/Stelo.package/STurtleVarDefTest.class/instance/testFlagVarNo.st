tests-accessing
testFlagVarNo
	| v |
	v := STurtleVarDef new.
	self assert: (v varNoFor: 'flag') equals: STurtleVarDef flagVarNo.