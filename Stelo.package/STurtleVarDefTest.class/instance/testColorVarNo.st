tests-accessing
testColorVarNo
	| v |
	v := STurtleVarDef new.
	self assert: (v varNoFor: 'color') equals: STurtleVarDef colorVarNo.