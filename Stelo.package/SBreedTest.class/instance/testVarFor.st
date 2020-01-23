tests-accessing
testVarFor
	| s |
	s := STurtles new.
	self assert: (s varNoFor: 'color') equals: STurtleVarDef colorVarNo.
	self assert: (s varNoFor: 'x') equals: STurtleVarDef xVarNo.
	self assert: (s varNoFor: 'y') equals: STurtleVarDef yVarNo.