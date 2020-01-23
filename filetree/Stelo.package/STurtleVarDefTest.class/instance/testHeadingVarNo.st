tests-accessing
testHeadingVarNo
	| v |
	v := STurtleVarDef new.
	self assert: (v varNoFor: 'heading') equals: STurtleVarDef headingVarNo.