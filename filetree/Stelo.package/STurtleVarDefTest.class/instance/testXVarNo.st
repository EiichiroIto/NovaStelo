tests-accessing
testXVarNo
	| v |
	v := STurtleVarDef new.
	self assert: (v varNoFor: 'x') equals: STurtleVarDef xVarNo.