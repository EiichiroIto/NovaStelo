tests-accessing
testYVarNo
	| v |
	v := STurtleVarDef new.
	self assert: (v varNoFor: 'y') equals: STurtleVarDef yVarNo.